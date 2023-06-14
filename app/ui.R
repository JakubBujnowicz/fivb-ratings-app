pageWithSidebar(
    headerPanel(sttngs$app_title),
    sidebarPanel(
        numericInput(inputId = "teamrat",
                     label = "Team A",
                     value = sttngs$rating_start_value),
        numericInput(inputId = "opprat",
                     label = "Team B",
                     value = sttngs$rating_start_value),
        selectInput(inputId = "sex",
                    label = "Sex",
                    selected = "Men",
                    choices = c("Men", "Women")),
        selectInput(inputId = "importance",
                    label = "Importance",
                    selected = "Nations League",
                    choices = names(sttngs$importance_map))
    ),
    mainPanel(
        # Explanation
        fluidRow(column(width = 6,
                        textOutput("en_info")),
                 column(width = 6,
                        textOutput("pl_info"))
                 ),
        hr(),

        tableOutput("result_tab")
    )
)
