module Svg.String.Events exposing
    ( onClick, onMouseDown, onMouseUp, onMouseOver, onMouseOut
    , on
    )

{-|


# Mouse

@docs onClick, onMouseDown, onMouseUp, onMouseOver, onMouseOut


# Custom

@docs on

-}

import Json.Decode as Json
import Svg.String exposing (Attribute)
import Svg.Types



-- MOUSE


{-| -}
onClick : msg -> Attribute msg
onClick msg =
    on "click" (Json.succeed msg)


{-| -}
onMouseDown : msg -> Attribute msg
onMouseDown msg =
    on "mousedown" (Json.succeed msg)


{-| -}
onMouseUp : msg -> Attribute msg
onMouseUp msg =
    on "mouseup" (Json.succeed msg)


{-| -}
onMouseOver : msg -> Attribute msg
onMouseOver msg =
    on "mouseover" (Json.succeed msg)


{-| -}
onMouseOut : msg -> Attribute msg
onMouseOut msg =
    on "mouseout" (Json.succeed msg)



-- CUSTOM


{-| Create a custom event listener. Normally this will not be necessary, but
you have the power! Here is how `onClick` is defined for example:

    import Json.Decode as Decode

    onClick : msg -> Attribute msg
    onClick message =
        on "click" (Decode.succeed message)

The first argument is the event name in the same format as with JavaScript's
[`addEventListener`][aEL] function.

The second argument is a JSON decoder. Read more about these [here][decoder].
When an event occurs, the decoder tries to turn the event object into an Elm
value. If successful, the value is routed to your `update` function. In the
case of `onClick` we always just succeed with the given `message`.

If this is confusing, work through the [Elm Architecture Tutorial][tutorial].
It really helps!

[aEL]: https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener
[decoder]: /packages/elm/json/latest/Json-Decode
[tutorial]: https://github.com/evancz/elm-architecture-tutorial/

**Note:** This creates a [passive] event listener, enabling optimizations for
touch, scroll, and wheel events in some browsers.

[passive]: https://github.com/WICG/EventListenerOptions/blob/gh-pages/explainer.md

-}
on : String -> Json.Decoder msg -> Attribute msg
on name decoder =
    Svg.Types.Event name decoder
