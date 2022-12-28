# calculate tf-idf
tf_idf <- docs %>%
  count(doc, word, sort = TRUE) %>%
  bind_tf_idf(term = word, document = doc, n = n)


# plot
tf_idf %>%
  group_by(doc) %>%
  top_n(15, tf_idf) %>%
  mutate(word = reorder(word, tf_idf)) %>%
  ggplot(aes(tf_idf, word, fill = doc)) +
  geom_col() +
  facet_wrap(~doc, scales = "free") +
  theme_minimal() +
  guides(fill = "none")