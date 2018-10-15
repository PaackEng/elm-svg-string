module Tests exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Svg.String as Svg exposing (..)
import Svg.String.Attributes as Attr exposing (..)
import Svg.String.Events as Events
import Test exposing (..)


testSvgIcon pinColor num =
    let
        xText =
            if num > 9 then
                text_
                    [ fill "#0E1520", fontFamily "Helvetica", fontSize "24", fontWeight "normal", id "2" ]
                    [ tspan
                        [ x "7", y "29" ]
                        [ text (String.fromInt num) ]
                    ]

            else
                text_
                    [ fill "#0E1520", fontFamily "Helvetica", fontSize "24", fontWeight "normal", id "2" ]
                    [ tspan
                        [ x "13", y "29" ]
                        [ text (String.fromInt num) ]
                    ]

        svgBody =
            -- [
            defs []
                [ circle
                    [ cx "20", cy "20", id "path-1", r "20" ]
                    []
                , Svg.filter
                    [ filterUnits "objectBoundingBox", height "135.0%", id "filter-2", width "135.0%", x "-17.5%", y "-12.5%" ]
                    [ feOffset
                        [ dx "0", dy "2", in_ "SourceAlpha", result "shadowOffsetOuter1" ]
                        []
                    , feGaussianBlur
                        [ in_ "shadowOffsetOuter1", result "shadowBlurOuter1", stdDeviation "2" ]
                        []
                    , feColorMatrix
                        [ in_ "shadowBlurOuter1", type_ "matrix", values "0 0 0 0 0   0 0 0 0 0   0 0 0 0 0  0 0 0 0.5 0" ]
                        []
                    ]
                ]

        -- , g [ fill "none", fillRule "evenodd", id "Routing-2", stroke "none", strokeWidth "1" ]
        --     [ g [ id "Route-Creation-Drag", transform "translate(-954.000000, -442.000000)" ]
        --         [ g [ id "Group-23", transform "translate(958.000000, 444.000000)" ]
        --             [ g [ id "draft-customer-pin" ]
        --                 [ g [ id "Group-8" ]
        --                     [ rect
        --                         [ fill "#E5E5E5", height "33", id "Rectangle-2", rx "2.5", width "5", x "18", y "33" ]
        --                         []
        --                     , g [ id "Oval-5" ]
        --                         [ use
        --                             [ fill "black", fillOpacity "1", Attr.filter "url(#filter-2)", xlinkHref "#path-1" ]
        --                             []
        --                         , use
        --                             [ fill pinColor, fillRule "evenodd", xlinkHref "#path-1" ]
        --                             []
        --                         ]
        --                     ]
        --                 ]
        --             , xText
        --             ]
        --         ]
        --     ]
        -- ]
        -- icon =
        --     svg [ height "68px", attribute "version" "1.1", viewBox "0 0 48 68", width "48px", attribute "xmlns" "http://www.w3.org/2000/svg", attribute "xmlns:xlink" "http://www.w3.org/1999/xlink" ]
        --         svgBody
    in
    "data:image/svg+xml;utf-8, " ++ Svg.toString 0 svgBody


suite : Test
suite =
    describe "Simple cases"
        [ test "Svg.test" <|
            \_ ->
                Svg.text "hello!"
                    |> Svg.toString 0
                    |> Expect.equal "hello!"
        , test "Svg.g" <|
            \_ ->
                Svg.g [] [ Svg.text "groupped" ]
                    |> Svg.toString 0
                    |> Expect.equal "<g>groupped</g>"
        , test "nested" <|
            \_ ->
                Svg.defs []
                    [ Svg.g []
                        [ Svg.rect []
                            [ Svg.text "inner" ]
                        ]
                    ]
                    |> Svg.toString 0
                    |> Expect.equal "<defs><g><rect>inner</rect></g></defs>"
        , test "setting indent adds newlines and adds indentation" <|
            \_ ->
                Svg.defs [] [ Svg.text "Hello world!" ]
                    |> Svg.toString 2
                    |> Expect.equal "<defs>\n  Hello world!\n</defs>"
        , test "if there are eventshandler attached, remove them from the markup" <|
            \_ ->
                Svg.rect [ Events.onClick 0 ] []
                    |> Svg.toString 0
                    |> Expect.equal "<rect></rect>"
        , test "attributes are rendered as key-value pairs" <|
            \_ ->
                Svg.rect [ Attr.x "100", Attr.y "200", Attr.stroke "red" ] []
                    |> Svg.toString 0
                    |> Expect.equal "<rect x=\"100\" y=\"200\" stroke=\"red\"></rect>"
        , test "styles are serialized to proper css. Sorta." <|
            \_ ->
                Svg.rect [ Attr.style "fill: red", Attr.style "stroke: blue" ] []
                    |> Svg.toString 0
                    |> Expect.equal "<rect style=\"fill: red\" style=\"stroke: blue\"></rect>"
        ]
