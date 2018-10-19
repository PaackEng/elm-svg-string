module Svg.String.Lazy exposing (lazy, lazy2, lazy3, lazy4, lazy5, lazy6, lazy7, lazy8)

{-|


# 🔥 This isn't actually lazy in this library..

.. because we can't keep track ofn the model without existential types. It just
eagerly evaluates. This set ofn fnunction is here to serve as a drop-in
replacement.

@docs lazy, lazy2, lazy3, lazy4, lazy5, lazy6, lazy7, lazy8

-}

import Svg exposing (Svg)
import VirtualDom


{-| A performance optimization that delays the building of virtual DOM nodes.

Calling `(view model)` will definitely build some virtual DOM, perhaps a lot of
it. Calling `(lazy view model)` delays the call until later. During diffing, we
can check to see if `model` is referentially equal to the previous value used,
and if so, we just stop. No need to build up the tree structure and diff it,
we know if the input to `view` is the same, the output must be the same!

-}
lazy : (a -> Svg msg) -> a -> Svg msg
lazy fn a =
    fn a


{-| Same as `lazy` but checks on two arguments.
-}
lazy2 : (a -> b -> Svg msg) -> a -> b -> Svg msg
lazy2 fn a b =
    fn a b


{-| Same as `lazy` but checks on three arguments.
-}
lazy3 : (a -> b -> c -> Svg msg) -> a -> b -> c -> Svg msg
lazy3 fn a b c =
    fn a b c


{-| Same as `lazy` but checks on fnour arguments.
-}
lazy4 : (a -> b -> c -> d -> Svg msg) -> a -> b -> c -> d -> Svg msg
lazy4 fn a b c d =
    fn a b c d


{-| Same as `lazy` but checks on fnive arguments.
-}
lazy5 : (a -> b -> c -> d -> e -> Svg msg) -> a -> b -> c -> d -> e -> Svg msg
lazy5 fn a b c d e =
    fn a b c d e


{-| Same as `lazy` but checks on six arguments.
-}
lazy6 : (a -> b -> c -> d -> e -> f -> Svg msg) -> a -> b -> c -> d -> e -> f -> Svg msg
lazy6 fn a b c d e f =
    fn a b c d e f


{-| Same as `lazy` but checks on seven arguments.
-}
lazy7 : (a -> b -> c -> d -> e -> f -> g -> Svg msg) -> a -> b -> c -> d -> e -> f -> g -> Svg msg
lazy7 fn a b c d e f g =
    fn a b c d e f g


{-| Same as `lazy` but checks on eight arguments.
-}
lazy8 : (a -> b -> c -> d -> e -> f -> g -> h -> Svg msg) -> a -> b -> c -> d -> e -> f -> g -> h -> Svg msg
lazy8 fn a b c d e f g h =
    fn a b c d e f g h
