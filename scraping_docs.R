## NH
NH <- scrape_const(url = "https://avalon.law.yale.edu/18th_century/nh09.asp", doc = "NH") %>%
  select(-paragraph)

## DE
DE <- scrape_const(url = "https://avalon.law.yale.edu/18th_century/de02.asp", doc = "DE")%>%
  select(-paragraph)

## PA
PA <- scrape_const(url = "https://avalon.law.yale.edu/18th_century/pa08.asp", doc = "PA")%>%
  select(-paragraph)

## SC
SC <- scrape_const(url = "https://avalon.law.yale.edu/18th_century/sc01.asp", doc = "SC")%>%
  select(-paragraph)

## NJ
NJ <- scrape_const(url = "https://avalon.law.yale.edu/18th_century/nj15.asp", doc = "NJ")%>%
  select(-paragraph)

## NC
NC <- scrape_const(url = "https://avalon.law.yale.edu/18th_century/nc07.asp", doc = "NC")%>%
  select(-paragraph)

## GA
GA <- scrape_const(url = "https://avalon.law.yale.edu/18th_century/ga02.asp", doc = "GA")%>%
  select(-paragraph)

## NY
NY <- scrape_const(url = "https://avalon.law.yale.edu/18th_century/ny01.asp", doc = "NY")%>%
  select(-paragraph)

## VT
VT <- scrape_const(url = "https://avalon.law.yale.edu/18th_century/vt01.asp", doc = "VT")%>%
  select(-paragraph)

## VA
va_html <- read_html("https://encyclopediavirginia.org/entries/the-constitution-of-virginia-1776/")

VA <- va_html %>%
  html_nodes("p") %>%
  html_text()

VA <- tibble(text = VA)

VA <- VA %>% 
  mutate(paragraph = row_number()) %>%
  filter(paragraph != 1 & paragraph < 71) %>%
  unnest_tokens(word, text) %>% 
  anti_join(stop_words, by = "word") %>%
  mutate(word=wordStem(word)) %>%
  select(-paragraph)

## RI Colonial Charter
ri_html <- read_html("https://avalon.law.yale.edu/17th_century/ri04.asp")

RI <- ri_html %>%
  html_nodes("p") %>%
  html_text()

RI <- tibble(text = RI)

RI <- RI %>% 
  mutate(paragraph = row_number()) %>%
  filter(paragraph < 10) %>%
  unnest_tokens(word, text) %>% 
  anti_join(stop_words, by = "word") %>%
  mutate(word=wordStem(word)) %>%
  select(-paragraph)


## MD
md_html <- read_html("http://www.nhinet.org/ccs/docs/md-1776.htm")

MD <- md_html %>%
  html_nodes("p") %>%
  html_text()

MD <- tibble(text = MD)

MD <- MD %>% 
  mutate(paragraph = row_number()) %>%
  filter(paragraph != 1 & paragraph < 112) %>%
  unnest_tokens(word, text) %>% 
  anti_join(stop_words, by = "word") %>%
  mutate(word=wordStem(word)) %>%
  select(-paragraph)

## MA
ma_html <- read_html("http://www.nhinet.org/ccs/docs/ma-1780.htm")

MA <- ma_html %>%
  html_nodes("p") %>%
  html_text()

MA <- tibble(text = MA)

MA <- MA %>% 
  mutate(paragraph = row_number()) %>%
  filter(paragraph != 1 & paragraph < 112) %>%
  unnest_tokens(word, text) %>% 
  anti_join(stop_words, by = "word") %>%
  mutate(word=wordStem(word)) %>%
  select(-paragraph)

## CT Colonial Charter
ct_html <- read_html("http://www.nhinet.org/ccs/docs/conn1662.htm")

CT <- ct_html %>%
  html_nodes("p") %>%
  html_text()

CT <- tibble(text = CT)

CT <- CT %>% 
  mutate(paragraph = row_number()) %>%
  filter(paragraph != 1 & paragraph != 2 & paragraph != 3, paragraph < 14) %>%
  unnest_tokens(word, text) %>% 
  anti_join(stop_words, by = "word") %>%
  mutate(word=wordStem(word)) %>%
  select(-paragraph)

## Albany Plan
ap_html <- read_html("https://avalon.law.yale.edu/18th_century/albany.asp")

AP <- ap_html %>%
  html_nodes("p") %>%
  html_text()

AP <- tibble(text = AP)

AP <- AP %>% 
  mutate(paragraph = row_number()) %>%
  filter(paragraph < 27 ) %>%
  unnest_tokens(word, text) %>% 
  anti_join(stop_words, by = "word") %>%
  mutate(word = wordStem(word))
  

## Articles of Confederation
AC <- scrape_const(url="https://avalon.law.yale.edu/18th_century/artconf.asp", doc = "AC") %>%
  select(-paragraph)

## US Constitution
us_html <- read_html("http://www.nhinet.org/ccs/docs/constitution.htm")

US <- us_html %>%
  html_nodes("p") %>%
  html_text()

US <- tibble(text = US)

US <- US %>% 
  mutate(paragraph = row_number()) %>%
  filter(paragraph != 1 & paragraph != 2 & paragraph < 98) %>%
  unnest_tokens(word, text) %>% 
  anti_join(stop_words, by = "word") %>%
  mutate(word=wordStem(word)) %>%
  select(-paragraph)
