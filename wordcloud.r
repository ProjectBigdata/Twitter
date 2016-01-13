library(wordcloud)
library(RColorBrewer)

dataset <- read.delim("FILE PATH", 
                      header=FALSE, quote="", stringsAsFactors=FALSE)
wordcloud(words = dataset$V1, freq = dataset$V2,
          max.words=60, random.order=FALSE, rot.per=0.35,
          colors=brewer.pal(8, "Dark2"))