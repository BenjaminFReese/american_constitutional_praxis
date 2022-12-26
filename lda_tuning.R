results <- FindTopicsNumber(
  doc_dtm,
  topics = seq(from = 2, to = 12, by = 1),
  metrics = c("CaoJuan2009", "Arun2010", "Deveaud2014"),
  method = "Gibbs",
  control = list(seed = 77),
  mc.cores = 6L,
  verbose = TRUE)

FindTopicsNumber_plot(results)
