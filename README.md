# elm-svg-string

> Write code resembling elm/svg and serialize to either a string or actual
SVG

This package copies the entire API of `elm/svg`, but adds 2 functions:

- `toHtml` which serializes the resulting `Svg.String.Html msg` node into a
`Html.Html msg` node
- `toString` which serializes the node into a `String` with optional indentation

Two caveats:

- You need to change your imports
- It can't properly support `lazy` nodes since those can't be expressed in Elm

## Show me an example!

```elm
import Svg.String as Svg exposing (Svg)
import Svg.String.Attributes as Attr
import Svg.String.Events as Events


someSvg : Html Msg
someSvg =
    Svg.svg [ height "68px", attribute "version" "1.1", viewBox "0 0 48 68" ]
        [ Svg.rect [ Attr.style "fill: red", Attr.style "stroke: blue" ] []
        ]


someSvgAsString : String
someSvgAsString =
    Svg.toString 2 <| someSvg

{- Expected output:

    <svg height="68px" version="1.1" view-box="0 0 48 68">
      <rect style="fill: red" style="stroke: blue"></rect>
    </svg>
-}
```

## Cool, anything else I should be aware of?

Yes.

- Event handlers are removed from the output.

## Alright, coolbeans

This library is based on the [elm-html-string](https://github.com/zwilias/elm-html-string) library

Made with ❤️ and licensed under BSD-3. Fork me and send me some pull-requests!
