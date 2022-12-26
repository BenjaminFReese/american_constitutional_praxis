## Turning Each Document Into Single Text String

NH <- paste(unlist(NH), collapse =" ")

PA <- paste(unlist(PA), collapse =" ")

DE <- paste(unlist(DE), collapse =" ")

MA <- paste(unlist(MA), collapse =" ")

VT <- paste(unlist(VT), collapse =" ")

MD <- paste(unlist(MD), collapse =" ")

NY <- paste(unlist(NY), collapse =" ")

NJ <- paste(unlist(NJ), collapse =" ")

GA <- paste(unlist(GA), collapse =" ")

SC <- paste(unlist(SC), collapse =" ")

NC <- paste(unlist(NC), collapse =" ")

VA <- paste(unlist(VA), collapse =" ")

AP <- paste(unlist(AP), collapse =" ")

AC <- paste(unlist(AC), collapse =" ")

US <- paste(unlist(US), collapse =" ")

RI <- paste(unlist(RI), collapse =" ")

CT <- paste(unlist(CT), collapse =" ")

docs <- data.frame(NH, PA, DE, MA, VT, MD, NY, NJ, GA, SC, NC, VA, US, RI, CT)

docs <- pivot_longer(docs, cols = colnames(docs), names_to = "doc") %>%
  mutate(word = value) %>%
  select(-value)

docs <- docs %>%
  unnest_tokens(word, word) %>%
  filter(!str_detect(word, pattern = "^\\d")) %>%
  anti_join(stop_words, by = "word")

doc_dtm <- docs %>%
  count(doc, word) %>%
  cast_dtm(document = doc, term = word, value = n)

doc_lda <- doc_dtm %>%
  LDA(k = 4, control = list(seed = 20221217))

## LDA
lda_gamma <- tidy(doc_lda, matrix = "gamma")

top_gamma <- lda_gamma %>%
  group_by(topic) %>%
  slice_max(gamma, n = 12) %>%
  ungroup() %>%
  arrange(desc(gamma))

print(top_gamma, n=14)

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
