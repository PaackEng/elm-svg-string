module Tests exposing (suite)

import Expect
import Svg.String as Svg exposing (..)
import Svg.String.Attributes as Attr exposing (..)
import Svg.String.Events as Events
import Test exposing (..)


suite : Test
suite =
    describe "Simple cases"
        [ test "empty tag" <|
            \_ ->
                svg [] []
                    |> Svg.toString 0
                    |> Expect.equal "<svg></svg>"
        , test "text node" <|
            \_ ->
                svg [] [ Svg.text "hello!" ]
                    |> Svg.toString 0
                    |> Expect.equal "<svg>hello!</svg>"
        , test "group tag" <|
            \_ ->
                svg []
                    [ Svg.g [] [ Svg.text "groupped" ]
                    ]
                    |> Svg.toString 0
                    |> Expect.equal "<svg><g>groupped</g></svg>"
        , test "nested nodes" <|
            \_ ->
                svg []
                    [ Svg.defs []
                        [ Svg.g []
                            [ Svg.rect []
                                [ Svg.text "inner" ]
                            ]
                        ]
                    ]
                    |> Svg.toString 0
                    |> Expect.equal "<svg><defs><g><rect>inner</rect></g></defs></svg>"
        , test "setting indent adds newlines and adds indentation" <|
            \_ ->
                svg []
                    [ Svg.defs [] [ Svg.text "Hello world!" ]
                    ]
                    |> Svg.toString 2
                    |> Expect.equal "<svg>\n  <defs>\n    Hello world!\n  </defs>\n</svg>"
        , test "if there are eventshandler attached, remove them from the markup" <|
            \_ ->
                svg []
                    [ Svg.rect [ Events.onClick 0 ] []
                    ]
                    |> Svg.toString 0
                    |> Expect.equal "<svg><rect></rect></svg>"
        , test "attributes are rendered as key-value pairs" <|
            \_ ->
                svg []
                    [ Svg.rect [ Attr.x "100", Attr.y "200", Attr.stroke "red" ] []
                    ]
                    |> Svg.toString 0
                    |> Expect.equal "<svg><rect x=\"100\" y=\"200\" stroke=\"red\"></rect></svg>"
        , test "styles are serialized to proper css" <|
            \_ ->
                svg []
                    [ Svg.rect [ Attr.style "fill: red", Attr.style "stroke: blue" ] []
                    ]
                    |> Svg.toString 0
                    |> Expect.equal "<svg><rect style=\"fill: red\" style=\"stroke: blue\"></rect></svg>"
        , test "attributes in svg tag are correctly serialized" <|
            \_ ->
                svg [ height "68px", attribute "version" "1.1", viewBox "0 0 48 68" ]
                    [ Svg.rect [ Attr.style "fill: red", Attr.style "stroke: blue" ] []
                    ]
                    |> Svg.toString 0
                    |> Expect.equal "<svg height=\"68px\" version=\"1.1\" view-box=\"0 0 48 68\"><rect style=\"fill: red\" style=\"stroke: blue\"></rect></svg>"
        ]
