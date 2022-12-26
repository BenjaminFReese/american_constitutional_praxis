## Scraping Function
scrape_const <- function(url, doc){

doc_html <- read_html(url)

doc <- doc_html %>%
  html_nodes("p") %>%
  html_text()

doc <- tibble(text = doc)

doc <- doc %>% 
  mutate(paragraph = row_number()) %>%
  unnest_tokens(word, text) %>% 
  anti_join(stop_words, by = "word") %>%
  mutate(word = wordStem(word))

}
