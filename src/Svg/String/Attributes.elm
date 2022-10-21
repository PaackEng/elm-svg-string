module Svg.String.Attributes exposing
    ( attribute, cx, cy, dx, dy, fill, fillOpacity, fillRule, filter, filterUnits, fontFamily, fontSize
    , fontWeight, height, id, in_, map, r, result, rx, ry, stdDeviation, stroke, strokeWidth, style, transform
    , type_, values, viewBox, width, x, xlinkHref, y
    , class, points, d, strokeDasharray, cursor, preserveAspectRatio
    , x1, x2, y1, y2
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
class : String -> Attribute msg
class name =
    attribute "class" name


{-| -}
in_ : String -> Attribute msg
in_ name =
    attribute "in" name


{-| -}
points : String -> Attribute msg
points value =
    attribute "points" value


{-| -}
d : String -> Attribute msg
d value =
    attribute "d" value


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
strokeDasharray : String -> Attribute msg
strokeDasharray value =
    attribute "stroke-dasharray" value


{-| -}
style : String -> Attribute msg
style =
    Svg.Types.Style

{-| -}
cursor  : String -> Attribute msg
cursor value =
    attribute "cursor" value


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
preserveAspectRatio : String -> Attribute msg
preserveAspectRatio name =
    attribute "preserveAspectRatio" name

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
x1 : String -> Attribute msg
x1 value =
    attribute "x1" value

{-| -}
x2 : String -> Attribute msg
x2 value =
    attribute "x2" value

{-| -}
y : String -> Attribute msg
y value =
    attribute "y" value

{-| -}
y1 : String -> Attribute msg
y1 value =
    attribute "y1" value

{-| -}
y2 : String -> Attribute msg
y2 value =
    attribute "y2" value

-- SVG Root Node Attributes

{-| -}
shapeRendering : String -> Attribute msg
shapeRendering = attribute "shapeRendering"

{-| -}
visibility : String -> Attribute msg
visibility = attribute "visibility"

{-| -}
version : String -> Attribute msg
version = attribute "version"

{-| -}
xmlns : String -> Attribute msg
xmlns = attribute "xmlns"

-- Animation Attributes

{-| -}
attributeName : String -> Attribute msg
attributeName = attribute "attributeName"

{-| -}
attributeType : String -> Attribute msg
attributeType = attribute "attributeType"

{-| -}
begin : String -> Attribute msg
begin = attribute "begin"

{-| -}
end : String -> Attribute msg
end = attribute "end"

{-| -}
dur : String -> Attribute msg
dur = attribute "dur"

{-| -}
from : String -> Attribute msg
from = attribute "from"

{-| -}
to : String -> Attribute msg
to = attribute "to"

{-| -}
repeatCount : String -> Attribute msg
repeatCount = attribute "repeatCount"
