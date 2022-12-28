## Libraries
library(tidyverse)
library(tidytext)
library(SnowballC)
library(igraph)
library(ggraph)
library(rvest)
library(wordcloud2)
library(stringr)
library(tm)
library(wordcloud)
library(RColorBrewer)
library(syuzhet)
library(dbscan)
library(proxy)
library(colorspace)
library(FactoMineR)
library(tidymodels)
library(topicmodels)
library(patchwork)

## List of Packages
list.of.packages <- c("tidyverse", "tm", "dbscan", "proxy", "colorspace", "tidytext", "SnowballC",
                      "igraph", "ggraph", "rvest", "wordcloud", "wordcloud2", "stringr", "RColorBrewer",
                      "syuzhet", "FactoMineR", "tidymodels", "topicmodels", "patchwork")
## Loading Packages
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])] 

if(length(new.packages)) {
  install.packages(new.packages)
}

for (p in list.of.packages) {
  require(p, character.only = TRUE)
}
