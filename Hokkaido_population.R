# 北海道市町村に関するデータ集 
# http://www.pref.hokkaido.lg.jp/ss/scs/gyousei/shityousondata.htm
# の
# 市町村別面積・人口・世帯数等の状況（Excel）
# http://www.pref.hokkaido.lg.jp/file.jsp?id=1140134
# を処理して国勢調査にもとづく市区町村の人口を取り出すスクリプト

library(readxl)
library(dplyr)
library(stringr)

filename <- "1-1-.xlsx"

hokkaido_popl <- read_xlsx(filename, skip = 28,
                           col_names = c("name", "c1", "c2", "c3",
                                         "c4", "c5", "c6",
                                         "area", "population"),
                           col_types = c(rep("text", 7),
                                         rep("numeric", 2),
                                         rep("skip", 15))) %>%
  dplyr::filter(!is.na(c1) & !is.na(population)) %>%
  dplyr::transmute(city_code = str_c(c1, c2, c3, c4, c5),
                   name, area, population)

save(hokkaido_popl, file = "Hokkaido_population.RData")
