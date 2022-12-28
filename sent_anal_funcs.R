## Negative Words Function

neg_words_cloud <- function(doc) {

doc %>% 
  inner_join(get_sentiments("bing"), by = "word") %>% 
  filter(sentiment == "negative") %>% count(word) %>% 
  wordcloud2(size = 0.7, fontFamily = "RobotoCondensed-Regular", 
             color = rep(c("black", "grey"), length.out = nrow(.)))
}

## Sentiment Analysis Function
sent_anal <- function(doc, name) {
  
doc %>% 
  inner_join(get_sentiments("bing"), by = "word") %>% 
  count(word, sentiment, sort = TRUE) %>% 
  ungroup() %>% 
  filter(n > 1) %>% 
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>% 
  mutate(word = reorder(word, n)) %>% 
  ggplot(aes(word, n, fill = sentiment)) + 
  geom_col() + 
  labs(x = NULL, y = NULL, fill = "Sentiment",
       title = name) + 
  coord_flip() + 
  theme_minimal() + 
  theme(legend.position = "bottom")

}


## Positive Words
pos_words_cloud <- function(doc) {
  
doc %>%
    inner_join(get_sentiments("bing"), by = "word") %>% 
    filter(sentiment == "positive") %>% 
    count(word) %>% 
    wordcloud2(size = 1,
               color = rep(c("pink", "lightblue"), length.out = nrow(.)))

}

## NRC Sentiment Pot

nrc_plot <- function(doc) {
  
  text <- doc$word
  nrc <- get_nrc_sentiment(text)
  
  nrc <- data.frame(t(nrc))
  
  nrc <- data.frame(rowSums(nrc))
  
  names(nrc)[1] <- "count"
  nrc <- cbind("sentiment" = rownames(nrc), nrc)
  rownames(nrc) <- NULL
  nrc <- nrc[1:8,]
  
  quickplot(sentiment, data=nrc, weight=count, geom="bar", fill=sentiment, ylab="count")+
    ggtitle("Document Sentiments") +
    theme_minimal()
}

words_cloud <- function(doc) {
  
  doc %>% 
    count(word) %>% 
    wordcloud2(size = 0.7, fontFamily = "RobotoCondensed-Regular")
}


