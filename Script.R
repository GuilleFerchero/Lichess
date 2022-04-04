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
Datos <- get_raw_lichess("Guillebarracas")
base <- write.csv(lichess_game_data, "base.csv")


# Limpieza de datos

Datos$WhiteElo <- as.numeric(Datos$WhiteElo)

Datos$BlackElo <- as.numeric(Datos$BlackElo)

Datos <- Datos %>% 
  mutate(Color = case_when(White == "Guillebarracas"~"Blanco",
                           TRUE ~ "Negro" ),
         Elo = case_when(Color == "Blanco" ~ WhiteElo,
                         TRUE ~ BlackElo),
         Elo_Rival = case_when(Color == "Blanco" ~ BlackElo,
                         TRUE ~ WhiteElo),
         Resultado = case_when(Color == "Blanco" & Result == "1-0" ~ "Victoria",
                               Color == "Blanco" & Result == "0-1" ~ "Derrota",
                               Color == "Negro" & Result == "0-1" ~ "Victoria",
                               Color == "Negro" & Result == "1-0" ~ "Derrota",
                               TRUE ~ "Tablas"))


