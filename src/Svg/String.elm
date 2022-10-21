module Svg.String exposing
    ( toHtml, toString
    , Svg, Html, Attribute, text, node, map
    , circle, defs, feColorMatrix, feGaussianBlur, feOffset, filter, g, rect, svg, text_, tspan, use
    )

{-| This file is organized roughly in order of popularity. The tags which you'd
expect to use frequently will be closer to the top.


# Serialization

@docs toHtml, toString


# Primitives

@docs Svg, Html, Attribute, text, node, map


# Tags

@docs circle, defs, feColorMatrix, feGaussianBlur, feOffset, filter, g, rect, svg, text_, tspan, use

-}

import Html
import Svg
import Svg.Types as Types exposing (..)


{-| The core building block to create SVG. This library is filled with helper
functions to create these `Svg` values.

This is backed by `VirtualDom.Node` in `evancz/virtual-dom`, but you do not
need to know any details about that to use this library!

-}
type alias Svg msg =
    Types.Svg msg


{-| The core building block used to build up HTML.
-}
type alias Html msg =
    Types.Html msg


{-| Set attributes on your `Svg`.
-}
type alias Attribute msg =
    Types.Attribute msg


{-| Create any SVG node. To create a `<rect>` helper function, you would write:

    rect : List (Attribute msg) -> List (Svg msg) -> Svg msg
    rect attributes children =
        node "rect" attributes children

You should always be able to use the helper functions already defined in this
library though!

-}
node : String -> List (Attribute msg) -> List (Svg msg) -> Svg msg
node tag attributes children =
    Node tag attributes (Regular children)


htmlNode : String -> List (Attribute msg) -> List (Svg msg) -> Html msg
htmlNode tag attributes children =
    HtmlNode tag attributes children


nodeWithoutChildren : String -> List (Attribute msg) -> List a -> Svg msg
nodeWithoutChildren tag attrs _ =
    Node tag attrs NoChildren


{-| A simple text node, no tags at all.

Warning: not to be confused with `text_` which produces the SVG `<text>` tag!

-}
text : String -> Svg msg
text =
    TextNode


{-| Transform the messages produced by some `Svg`.
-}
map : (a -> b) -> Svg a -> Svg b
map =
    Types.map


{-| Convert to regular `elm/html` Html.
-}
toHtml : Html msg -> Html.Html msg
toHtml =
    Types.toHtml


{-| Convert to a string with indentation.

Setting indentation to 0 will additionally remove newlines between tags, sort of
like `Json.Encode.encode 0`.

    import Svg.String.Attributes exposing (g, rect, stroke)


    someHtml : Html msg
    someHtml =
        svg [ height "68px" ] [ g [] [ rect [ x "10", y "20", stroke "red" ]]]


    Svg.String.toString 2 someHtml
    -->"<svg height=\"68px\">\n  <g>\n    <rect x=\"10\" y=\"20\" stroke=\"red\">\n    </rect>\n  </g>\n</svg>"

    Svg.String.toString 0 someHtml
    --> "<svg height=\"68px\"><g><rect x=\"10\" y=\"20\" stroke=\"red\"></rect></g></svg>"

-}
toString : Int -> Html msg -> String
toString indent =
    Types.toString indent



-- TAGS


{-| -}
svg : List (Attribute msg) -> List (Svg msg) -> Html msg
svg =
    htmlNode "svg"



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


-- Animation elements

{-| -}
animate : List (Attribute msg) -> List (Svg msg) -> Svg msg
animate = node "animate"

{-| -}
animateTransform : List (Attribute msg) -> List (Svg msg) -> Svg msg
animateTransform = node "animateTransform"

{-| -}
animateColor : List (Attribute msg) -> List (Svg msg) -> Svg msg
animateColor = node "animateColor"

-- Uncategorized elements


{-| -}
filter : List (Attribute msg) -> List (Svg msg) -> Svg msg
filter =
    node "filter"
