module Main exposing (main)

import Random exposing (generate, int)
import Html exposing (Html, div, text, button)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Dict exposing (fromList)


intToDieFaceChar =
    fromList [ ( 1, "⚀" ), ( 2, "⚁" ), ( 3, "⚂" ), ( 4, "⚃" ), ( 5, "⚄" ), ( 6, "⚅" ) ]


main =
    Html.program
        { init = ( init, generate RolledDie diceGenerator )
        , subscriptions = \_ -> Sub.none
        , update = update
        , view = view
        }


type Msg
    = Roll
    | RolledDie Int


init =
    { dieFace = 6 }


view model =
    let
        currentDieFace =
            case Dict.get model.dieFace intToDieFaceChar of
                Just x ->
                    x

                _ ->
                    ""
    in
        div []
            [ button
                [ onClick Roll
                , style [ ( "margin-top", "-0.4em" ), ( "font-size", "70rem" ) ]
                ]
                [ text currentDieFace ]
            ]


diceGenerator =
    int 1 6


update msg model =
    case msg of
        Roll ->
            ( model, generate RolledDie diceGenerator )

        RolledDie int ->
            ( { model | dieFace = int }, Cmd.none )
