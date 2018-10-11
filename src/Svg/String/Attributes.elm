module Svg.String.Attributes exposing
    ( attribute
    , id
    , map
    , style
    )

import Json.Encode as Json
import Svg.String exposing (Attribute)
import Svg.Types



-- REGULAR ATTRIBUTES


attribute : String -> String -> Attribute msg
attribute =
    Svg.Types.Attribute


id : String -> Attribute msg
id name =
    attribute "id" name


{-| Transform the messages produced by an `Attribute`.
-}
map : (a -> msg) -> Attribute a -> Attribute msg
map =
    Svg.Types.mapAttribute


style : String -> Attribute msg
style =
    Svg.Types.Style
