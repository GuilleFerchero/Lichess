#Limpiamos memoria

rm(list = ls())

#Instalamos Librerías

#install.packages("DT")
library("DT")
library(tidyverse)
library(lubridate)
library(kableExtra)
library(plotly)
library("chessR")

# Levantamos ultimos datos
lichess_game_data <- get_raw_lichess("Guillebarracas")
base <- write.csv(lichess_game_data, "base.csv")


j

