module Svg.Types exposing
    ( Acc
    , Attribute(..)
    , Children(..)
    , Html(..)
    , Indenter
    , Svg(..)
    , TagInfo
    , attributeToString
    , attributeToSvg
    , buildProp
    , closingTag
    , escape
    , hyphenate
    , indent
    , join
    , map
    , mapAttribute
    , mapChildren
    , tag
    , toHtml
    , toString
    )

import Char
import Html
import Json.Decode exposing (Decoder)
import Svg
import Svg.Attributes
import Svg.Events
import Svg.Keyed
import VirtualDom


type Children msg
    = NoChildren
    | Regular (List (Svg msg))
    | Keyed (List ( String, Svg msg ))


mapChildren : (a -> b) -> Children a -> Children b
mapChildren f children =
    case children of
        NoChildren ->
            NoChildren

        Regular nodes ->
            Regular (List.map (map f) nodes)

        Keyed keyedNodes ->
            Keyed (List.map (Tuple.mapSecond <| map f) keyedNodes)


type Svg msg
    = Node String (List (Attribute msg)) (Children msg)
    | TextNode String


type Html msg
    = HtmlNode String (List (Attribute msg)) (List (Svg msg))


map : (a -> b) -> Svg a -> Svg b
map f node =
    case node of
        Node tagName attributes children ->
            Node tagName (List.map (mapAttribute f) attributes) (mapChildren f children)

        TextNode content ->
            TextNode content


type Attribute msg
    = Attribute String String
    | Style String
    | Event String (Decoder msg)


mapAttribute : (a -> b) -> Attribute a -> Attribute b
mapAttribute f attribute =
    case attribute of
        Attribute key value ->
            Attribute key value

        Style style ->
            Style style

        Event name msgDecoder ->
            Event name (Json.Decode.map f msgDecoder)


toHtml : Html msg -> Html.Html msg
toHtml (HtmlNode tagName attributes children) =
    Html.node "svg" (List.map attributeToSvg attributes) (List.map svgToSvg children)


svgToSvg : Svg msg -> Svg.Svg msg
svgToSvg node =
    case node of
        Node tagName attributes children ->
            case children of
                NoChildren ->
                    Svg.node tagName (List.map attributeToSvg attributes) []

                Regular nodes ->
                    Svg.node tagName (List.map attributeToSvg attributes) (List.map svgToSvg nodes)

                Keyed keyedNodes ->
                    Svg.Keyed.node tagName (List.map attributeToSvg attributes) (List.map (Tuple.mapSecond svgToSvg) keyedNodes)

        TextNode content ->
            Svg.text content


attributeToSvg : Attribute msg -> Svg.Attribute msg
attributeToSvg attribute =
    case attribute of
        Attribute key value ->
            VirtualDom.attribute key value

        Style style ->
            Svg.Attributes.style style

        Event name decoder ->
            Svg.Events.on name decoder


toString : Int -> Html msg -> String
toString depth html =
    let
        indenter : Indenter
        indenter =
            case depth of
                0 ->
                    always identity

                _ ->
                    indent depth

        joinString : String
        joinString =
            case depth of
                0 ->
                    ""

                _ ->
                    "\n"

        initialAcc : Acc msg
        initialAcc =
            { depth = 0
            , stack = []
            , result = []
            }
    in
    htmlToStringHelper indenter html initialAcc
        |> .result
        |> join joinString


join : String -> List String -> String
join between list =
    case list of
        [] ->
            ""

        [ x ] ->
            x

        x :: xs ->
            List.foldl (\y acc -> y ++ between ++ acc) x xs


type alias Indenter =
    Int -> String -> String


type alias Acc msg =
    { depth : Int
    , stack : List (TagInfo msg)
    , result : List String
    }


type alias TagInfo msg =
    ( String, List (Svg msg) )


htmlToStringHelper : Indenter -> Html msg -> Acc msg -> Acc msg
htmlToStringHelper indenter (HtmlNode tagName attributes children) acc =
    { acc
        | result = indenter acc.depth (tag tagName attributes) :: acc.result
        , depth = acc.depth + 1
        , stack = ( tagName, [] ) :: acc.stack
    }
        |> svgToStringHelper indenter children


svgToStringHelper : Indenter -> List (Svg msg) -> Acc msg -> Acc msg
svgToStringHelper indenter tags acc =
    case tags of
        [] ->
            case acc.stack of
                [] ->
                    acc

                ( tagName, cont ) :: rest ->
                    { acc
                        | result = indenter (acc.depth - 1) (closingTag tagName) :: acc.result
                        , depth = acc.depth - 1
                        , stack = rest
                    }
                        |> svgToStringHelper indenter cont

        (Node tagName attributes children) :: rest ->
            case children of
                NoChildren ->
                    { acc | result = indenter acc.depth (tag tagName attributes) :: acc.result }
                        |> svgToStringHelper indenter rest

                Regular childNodes ->
                    { acc
                        | result = indenter acc.depth (tag tagName attributes) :: acc.result
                        , depth = acc.depth + 1
                        , stack = ( tagName, rest ) :: acc.stack
                    }
                        |> svgToStringHelper indenter childNodes

                Keyed childNodes ->
                    { acc
                        | result = indenter acc.depth (tag tagName attributes) :: acc.result
                        , depth = acc.depth + 1
                        , stack = ( tagName, rest ) :: acc.stack
                    }
                        |> svgToStringHelper indenter (List.map Tuple.second childNodes)

        (TextNode string) :: rest ->
            { acc | result = indenter acc.depth string :: acc.result }
                |> svgToStringHelper indenter rest


tag : String -> List (Attribute msg) -> String
tag tagName attributes =
    "<" ++ String.join " " (tagName :: List.filterMap attributeToString attributes) ++ ">"


buildProp : String -> String -> String
buildProp key value =
    hyphenate key ++ "='" ++ escape value ++ "'"


attributeToString : Attribute msg -> Maybe String
attributeToString attribute =
    case attribute of
        Attribute key value ->
            Just <| buildProp key value

        Style style ->
            Just <| "style='" ++ style ++ "'"

        Event string msgDecoder ->
            Nothing


escape : String -> String
escape =
    String.foldl
        (\char acc ->
            if char == '\'' then
                acc ++ "&apos;"

            else
                acc ++ String.fromChar char
        )
        ""


hyphenate : String -> String
hyphenate =
    String.foldl
        (\char acc ->
            if Char.isUpper char then
                acc ++ "-" ++ String.fromChar (Char.toLower char)

            else
                acc ++ String.fromChar char
        )
        ""


closingTag : String -> String
closingTag tagName =
    "</" ++ tagName ++ ">"


indent : Int -> Int -> String -> String
indent perLevel level x =
    String.repeat (perLevel * level) " " ++ x
