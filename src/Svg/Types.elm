module Svg.Types exposing
    ( Acc
    , Attribute(..)
    , Children(..)
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
    , toString
    , toStringHelper
    , toSvg
    )

import Char
import Json.Decode exposing (Decoder, Value)
import Json.Encode as Encode
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


toSvg : Svg msg -> Svg.Svg msg
toSvg node =
    case node of
        Node tagName attributes children ->
            case children of
                NoChildren ->
                    Svg.node tagName (List.map attributeToSvg attributes) []

                Regular nodes ->
                    Svg.node tagName (List.map attributeToSvg attributes) (List.map toSvg nodes)

                Keyed keyedNodes ->
                    Svg.Keyed.node tagName (List.map attributeToSvg attributes) (List.map (Tuple.mapSecond toSvg) keyedNodes)

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


toString : Int -> Svg msg -> String
toString depth svg =
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
    toStringHelper indenter [ svg ] initialAcc
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


toStringHelper : Indenter -> List (Svg msg) -> Acc msg -> Acc msg
toStringHelper indenter tags acc =
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
                        |> toStringHelper indenter cont

        (Node tagName attributes children) :: rest ->
            case children of
                NoChildren ->
                    { acc | result = indenter acc.depth (tag tagName attributes) :: acc.result }
                        |> toStringHelper indenter rest

                Regular childNodes ->
                    { acc
                        | result = indenter acc.depth (tag tagName attributes) :: acc.result
                        , depth = acc.depth + 1
                        , stack = ( tagName, rest ) :: acc.stack
                    }
                        |> toStringHelper indenter childNodes

                Keyed childNodes ->
                    { acc
                        | result = indenter acc.depth (tag tagName attributes) :: acc.result
                        , depth = acc.depth + 1
                        , stack = ( tagName, rest ) :: acc.stack
                    }
                        |> toStringHelper indenter (List.map Tuple.second childNodes)

        (TextNode string) :: rest ->
            { acc | result = indenter acc.depth string :: acc.result }
                |> toStringHelper indenter rest


tag : String -> List (Attribute msg) -> String
tag tagName attributes =
    "<" ++ String.join " " (tagName :: List.filterMap attributeToString attributes) ++ ">"


buildProp : String -> String -> String
buildProp key value =
    hyphenate key ++ "=\"" ++ escape value ++ "\""


attributeToString : Attribute msg -> Maybe String
attributeToString attribute =
    case attribute of
        Attribute key value ->
            Just <| buildProp key value

        Style style ->
            Just <| "style=\"" ++ style ++ "\""

        Event string msgDecoder ->
            Nothing


escape : String -> String
escape =
    String.foldl
        (\char acc ->
            if char == '"' then
                acc ++ "\\\""

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
