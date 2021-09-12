module ScrollSnap exposing (horizontal)

{-| Scrollable containers with snapping

This library is based on elm-css and accepts `Html.Styled.Html` items.
If you are not using elm-css, use `Html.Styled.fromUnstyled` and `Html.Styled.toUnstyled` to convert the items and the resulting container.

![Demo](https://github.com/cedricss/elm-scroll-snap/raw/main/img/horizontal.gif)

@docs horizontal

-}

import Css exposing (LengthOrAuto, after, displayFlex, firstChild, marginLeft, minWidth, overflowX, pct, scroll, width)
import Css.Global exposing (children, typeSelector)
import Html.Styled exposing (Html, div)
import Html.Styled.Attributes as Attributes exposing (css, id)


{-| Create a container with horizontal scrolling. The most visible item is centered horizontally.

    div
        [ css
            [ border3 (px 1) solid (hex "eee")
            , width (px 500)
            ]
        ]
        [ ScrollSnap.horizontal
            { itemWidth = px 280 }
            [ item1, item2, item3, item4, item5 ]
        ]

-}
horizontal :
    { id : String
    , itemWidth : { compatible | value : String, lengthOrMinMaxDimension : Css.Compatible, lengthOrAuto : Css.Compatible }
    }
    -> List (Html msg)
    -> Html msg
horizontal config items =
    div
        [ id config.id
        , css
            [ displayFlex
            , overflowX scroll
            , width (pct 100)
            , Css.property "scroll-snap-type" "x mandatory"
            , Css.property "-webkit-overflow-scrolling" "touch"
            , children
                [ typeSelector "div"
                    [ Css.property "scroll-snap-align" "center"
                    , minWidth config.itemWidth
                    , firstChild [ marginLeft config.itemWidth ]
                    ]
                ]
            , after
                [ Css.property "content" "\"\""
                , minWidth config.itemWidth
                ]
            ]
        ]
        items
