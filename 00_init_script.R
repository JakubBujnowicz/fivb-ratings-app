# Packages ---------------------------------------------------------------------
library(data.table)
library(stringr)
library(checkmate)

# App
library(shiny)
library(rsconnect)


# Functions --------------------------------------------------------------------
invisible(lapply(list.files("functions", pattern = "\\.R$",
                            full.names = TRUE),
                 source, encoding = "UTF-8"))


# Settings ---------------------------------------------------------------------
sttngs <- rev(within(list(),
{
    # FIVB ratings
    cutoffs <- list(Men = c(0.394, 1.060),
                    Women = c(0.3605993, 0.9544951))
    sigma <- 8
    scaling <- 1e3
    scores <- c(`3:0` = 2,
                `3:1` = 1.5,
                `3:2` = 1,
                `2:3` = -1,
                `1:3` = -1.5,
                `0:3` = -2)
    digits <- 2

    importance_map <- c(`Olympic Games` = 50,
                        `World Championship` = 45,
                        `Nations League` = 40,
                        `OQTs / World Cup / Continental Championship` = 35,
                        `Challenger Cup` = 20,
                        `Continental Championship QT` = 17.5,
                        `Other` = 10)

    # App settings
    app_name <- "FIVBRatingsCalculator"
    app_title <- "FIVB Ratings Calculator"
    app_account <- "volleystats"

    rating_start_value <- 300
}))

