server <- function(input, output)
{
    # Result scores tab --------------------------------------------------------
    resultTab <- reactive({
        rslt <- calc_fivb_ratings(t1 = input$teamrat,
                                  t2 = input$opprat,
                                  k = sttngs$importance_map[input$importance],
                                  cutoffs = sttngs$cutoffs[[input$sex]],
                                  scores = sttngs$scores,
                                  sigma = sttngs$sigma,
                                  scaling = sttngs$scaling,
                                  digits = sttngs$digits)

        nums <- names(Filter(is.numeric, rslt))
        frmt <- paste0("%.", sttngs$digits, "f")
        rslt[, (nums) := lapply(.SD, sprintf, fmt = frmt),
             .SDcols = nums]

        rslt[, Change := fifelse(Change == FinalChange,
                                 FinalChange,
                                 paste0(FinalChange, " (", Change, ")"))]
        rslt <- rslt[, .(Result,
                         Change,
                         `A's new rating` = NewT1,
                         `B's new rating` = NewT2)]
        return(rslt)
    })

    # Tables output ------------------------------------------------------------
    output$result_tab <- renderTable(expr = resultTab(),
                                     align = "crrr")

    # Text outputs -------------------------------------------------------------
    output$en_info <- renderText(
        paste0("Using fields on the lefthand side, enter ratings of two ",
               "teams, sex and importance of the match. The results are ",
               "presented in a table below, where you can find how ",
               "a given result impacts the ratings of both teams ",
               "(with the change from A's perspective). ",
               "Additional theoretical change value will appear in parentheses, ",
               "if team A were to lose points with a win/gain with a loss."))
    output$pl_info <- renderText(
        paste0("Używając pól po lewej stronie, wprowadź ratingi obu zespołów, ",
               "płeć oraz rangę meczu. Rezultaty są dostępne w tabelce poniżej, ",
               "gdzie można znaleźć jak poszczególne wyniyki wpływaja na ratingi ",
               " obu zespołów (ze zmianą z perspektywy zespołu A). ",
               "Dodatkowa teoretyczne wartości zmian pojawią się w nawiasach, jeżeli ",
               "drużyna A miałaby stracić punkty mimo zwycięstwa/zyskać mimo ",
               "wygranej. "))
}

