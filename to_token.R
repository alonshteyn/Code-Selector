# Tokenization 
# Read ICD files
icd10 <- readxl::read_xlsx("~/desktop/icd10 codes.xlsx")

desc_corpus <- tm::VCorpus(VectorSource(icd10$description))
xxx <- tm_map(desc_corpus, content_transformer(tolower))
xxx <- tm_map(xxx, content_transformer(removeNumbers))
#xxx <- tm_map(xxx, content_transformer(removeWords), stopwords())
xxx <- tm_map(xxx, content_transformer(removePunctuation))
xxx <- tm_map(xxx, stemDocument)
xxx <- tm_map(xxx, stripWhitespace)

desc_dtm <- DocumentTermMatrix(xxx)
#desc_tdm <- TermDocumentMatrix(xxx)

freq_words <- findFreqTerms((desc_dtm))
tokens <- as.data.frame(freq_words)

words_of_interest <- c("abdomin", "abdomen")
xxx = desc_dtm[,words_of_interest]
xxx <- as.data.frame(as.matrix(xxx)) 
xxx1 <- cbind(icd10,xxx)
condition = '"abdomin"=1 
codes_of_interest <- filter(xxx1,conditon)
getTransformations()              