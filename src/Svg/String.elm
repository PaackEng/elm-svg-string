module Svg.String exposing
    ( Attribute
    , Svg
    , circle
    , defs
    , feColorMatrix
    , feGaussianBlur
    , feOffset
    , filter
    , g
    , map
    , node
    , rect
    , svg
    , text
    , text_
    , toString
    , toSvg
    , tspan
    , use
    )

import Html
import Svg
import Svg.Types as Types exposing (..)


{-| The core building block used to build up HTML. Here we create an `Html`
value with no attributes and one child:

    hello : Html msg
    hello =
        div [] [ text "Hello!" ]

-}
type alias Svg msg =
    Types.Svg msg


{-| Set attributes on your `Html`. Learn more in the
[`Html.String.Attributes`](Html.String.Attributes) module.
-}
type alias Attribute msg =
    Types.Attribute msg


{-| General way to create HTML nodes. It is used to define all of the helper
functions in this library.

    div : List (Attribute msg) -> List (Html msg) -> Html msg
    div attributes children =
        node "div" attributes children

You can use this to create custom nodes if you need to create something that
is not covered by the helper functions in this library.

-}
node : String -> List (Attribute msg) -> List (Svg msg) -> Svg msg
node tag attributes children =
    Node tag attributes (Regular children)


nodeWithoutChildren : String -> List (Attribute msg) -> List a -> Svg msg
nodeWithoutChildren tag attrs _ =
    Node tag attrs NoChildren


{-| Just put plain text in the DOM. It will escape the string so that it appears
exactly as you specify.

    text "Hello World!"

-}
text : String -> Svg msg
text =
    TextNode


{-| Transform the messages produced by some `Html`. In the following example,
we have `viewButton` that produces `()` messages, and we transform those values
into `Msg` values in `view`.

    type Msg
        = Left
        | Right

    view : model -> Html Msg
    view model =
        div []
            [ map (\_ -> Left) (viewButton "Left")
            , map (\_ -> Right) (viewButton "Right")
            ]

    viewButton : String -> Html ()
    viewButton name =
        button [ onClick () ] [ text name ]

This should not come in handy too often. Definitely read [this][reuse] before
deciding if this is what you want.

[reuse]: https://guide.elm-lang.org/reuse/

-}
map : (a -> b) -> Svg a -> Svg b
map =
    Types.map


{-| Convert to regular `elm/svg` Svg.
-}
toSvg : Svg msg -> Svg.Svg msg
toSvg =
    Types.toSvg


{-| Convert to a string with indentation.

Setting indentation to 0 will additionally remove newlines between tags, sort of
like `Json.Encode.encode 0`.

    import Html.String.Attributes exposing (href)


    someHtml : Html msg
    someHtml =
        a [ href "http://google.com" ] [ text "Google!" ]


    Html.String.toString 2 someHtml
    --> "<a href=\"http://google.com\">\n  Google!\n</a>"


    Html.String.toString 0 someHtml
    --> "<a href=\"http://google.com\">Google!</a>"

-}
toString : Int -> Svg msg -> String
toString indent =
    Types.toString indent



-- TAGS


{-| -}
svg : List (Html.Attribute msg) -> List (Svg.Svg msg) -> Html.Html msg
svg =
    Svg.svg



-- Container elements


{-| -}
defs : List (Attribute msg) -> List (Svg msg) -> Svg msg
defs =
    node "defs"


{-| -}
g : List (Attribute msg) -> List (Svg msg) -> Svg msg
g =
    node "g"



-- Filter primitive elements


{-| -}
feColorMatrix : List (Attribute msg) -> List (Svg msg) -> Svg msg
feColorMatrix =
    node "feColorMatrix"


{-| -}
feGaussianBlur : List (Attribute msg) -> List (Svg msg) -> Svg msg
feGaussianBlur =
    node "feGaussianBlur"


{-| -}
feOffset : List (Attribute msg) -> List (Svg msg) -> Svg msg
feOffset =
    node "feOffset"



-- Graphics elements


{-| -}
circle : List (Attribute msg) -> List (Svg msg) -> Svg msg
circle =
    node "circle"


{-| -}
rect : List (Attribute msg) -> List (Svg msg) -> Svg msg
rect =
    node "rect"


{-| -}
use : List (Attribute msg) -> List (Svg msg) -> Svg msg
use =
    node "use"



-- Text content elements


{-| -}
text_ : List (Attribute msg) -> List (Svg msg) -> Svg msg
text_ =
    node "text"


{-| -}
tspan : List (Attribute msg) -> List (Svg msg) -> Svg msg
tspan =
    node "tspan"



-- Uncategorized elements


{-| -}
filter : List (Attribute msg) -> List (Svg msg) -> Svg msg
filter =
    node "filter"
