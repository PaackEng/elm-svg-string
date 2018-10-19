module Svg.String.Attributes exposing
    ( attribute, cx, cy, dx, dy, fill, fillOpacity, fillRule, filter, filterUnits, fontFamily, fontSize
    , fontWeight, height, id, in_, map, r, result, rx, ry, stdDeviation, stroke, strokeWidth, style, transform
    , type_, values, viewBox, width, x, xlinkHref, y
    )

{-| Helper functions for SVG attributes.


# Regular attributes

@docs attribute, cx, cy, dx, dy, fill, fillOpacity, fillRule, filter, filterUnits, fontFamily, fontSize
@docs fontWeight, height, id, in_, map, r, result, rx, ry, stdDeviation, stroke, strokeWidth, style, transform
@docs type_, values, viewBox, width, x, xlinkHref, y

-}

import Json.Encode as Json
import Svg.String exposing (Attribute)
import Svg.Types


{-| Transform the messages produced by an `Attribute`.
-}
map : (a -> msg) -> Attribute a -> Attribute msg
map =
    Svg.Types.mapAttribute



-- ATTRIBUTES


{-| -}
attribute : String -> String -> Attribute msg
attribute =
    Svg.Types.Attribute


{-| -}
cx : String -> Attribute msg
cx value =
    attribute "cx" value


{-| -}
cy : String -> Attribute msg
cy value =
    attribute "cy" value


{-| -}
dx : String -> Attribute msg
dx value =
    attribute "dx" value


{-| -}
dy : String -> Attribute msg
dy value =
    attribute "dy" value


{-| -}
fill : String -> Attribute msg
fill value =
    attribute "fill" value


{-| -}
fillOpacity : String -> Attribute msg
fillOpacity value =
    attribute "fill-opacity" value


{-| -}
fillRule : String -> Attribute msg
fillRule value =
    attribute "fill-rule" value


{-| -}
filter : String -> Attribute msg
filter value =
    attribute "filter" value


{-| -}
filterUnits : String -> Attribute msg
filterUnits value =
    attribute "filterUnits" value


{-| -}
fontFamily : String -> Attribute msg
fontFamily value =
    attribute "font-family" value


{-| -}
fontSize : String -> Attribute msg
fontSize value =
    attribute "font-size" value


{-| -}
fontWeight : String -> Attribute msg
fontWeight value =
    attribute "font-weight" value


{-| -}
height : String -> Attribute msg
height name =
    attribute "height" name


{-| -}
id : String -> Attribute msg
id name =
    attribute "id" name


{-| -}
in_ : String -> Attribute msg
in_ name =
    attribute "in" name


{-| -}
r : String -> Attribute msg
r value =
    attribute "r" value


{-| -}
rx : String -> Attribute msg
rx value =
    attribute "rx" value


{-| -}
ry : String -> Attribute msg
ry value =
    attribute "ry" value


{-| -}
result : String -> Attribute msg
result value =
    attribute "result" value


{-| -}
stdDeviation : String -> Attribute msg
stdDeviation value =
    attribute "stdDeviation" value


{-| -}
stroke : String -> Attribute msg
stroke value =
    attribute "stroke" value


{-| -}
strokeWidth : String -> Attribute msg
strokeWidth value =
    attribute "stroke-width" value


{-| -}
style : String -> Attribute msg
style =
    Svg.Types.Style


{-| -}
transform : String -> Attribute msg
transform name =
    attribute "transform" name


{-| -}
type_ : String -> Attribute msg
type_ name =
    attribute "type" name


{-| -}
viewBox : String -> Attribute msg
viewBox name =
    attribute "viewBox" name


{-| -}
values : String -> Attribute msg
values name =
    attribute "values" name


{-| -}
width : String -> Attribute msg
width name =
    attribute "width" name


{-| -}
xlinkHref : String -> Attribute msg
xlinkHref value =
    attribute "xlink:href" value


{-| -}
x : String -> Attribute msg
x value =
    attribute "x" value


{-| -}
y : String -> Attribute msg
y value =
    attribute "y" value
