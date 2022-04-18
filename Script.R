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

### tiempo es -3

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
                               TRUE ~ "Tablas"),
         Fecha = as.Date(ymd(paste0(substr(Date,1,4),substr(Date,6,7),substr(Date,9,10)))),
         Hora = as.numeric(substr(UTCTime,1,2)),
         Hora_arg = case_when(Hora == 3 ~ 0,
                              Hora == 2 ~ 23,
                              Hora == 1 ~ 22,
                              Hora == 0 ~ 21,
                              TRUE ~ (Hora - 3)))

#Definimos colores

negro <- "#0c0c0c"
gris1 <- "#585757"
gris2 <- "#727171"
blanco <- "#f9f9f9"


#####Visualizaciones##############

##Linea

g1 <- plot_ly(Datos, x = ~Fecha) %>% 
  add_trace(y = ~Elo, mode = "lines+markers", name = "elo")

g1

#


