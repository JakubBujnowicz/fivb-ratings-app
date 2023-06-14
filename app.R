# Libraries --------------------------------------------------------------------
source("00_init_script.R", encoding = "UTF-8")


# Run the application ----------------------------------------------------------
# source("app/ui.R", encoding = "UTF-8")
shinyApp(ui = eval(parse("app/ui.R", encoding = "UTF-8")),
         server = eval(parse("app/server.R", encoding = "UTF-8")))

