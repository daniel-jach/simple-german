
listFiles<-list.files(path = "./corpus/simplyscience", recursive = TRUE, pattern = "\\.txt$", full.names = TRUE)

df<-data.frame(matrix(nrow = length(listFiles), ncol = 1))
for(i in 1:length(listFiles)){
  df[i,1]<-readtext(listFiles[i])$text
}
doubled<-which(duplicated(df$matrix.nrow...length.listFiles...ncol...1.))

df<-df$matrix.nrow...length.listFiles...ncol...1.
df<-df[-doubled]


num<-1:length(df)
for(i in 1:length(df)){
  path<-paste("./corpus/simplyscience/simplyscience-", num[i], ".txt", sep = "")
  fileConn<-file(path)
  writeLines(df[i], fileConn)
  close(fileConn)
}



grep("man die im Eis enthaltenen Sauerstoffisotope", df[,1])

data<-data.frame(matrix(nrow = 0, ncol = 6))
for(i in 1:length(dirsList)){
  path<-paste("./corpus/", dirsList[i], "/", sep = "")
  filesList<-list.files(path = path, recursive = TRUE, pattern = "\\.txt$", full.names = TRUE)
  for(j in 1:length(filesList)){
    df<-treetag.fertilizer("/home/daniel/TreeTagger/", filesList[j], "german")
    df$FILE<-gsub("./corpus/klexikon//", "", filesList[j], fixed = TRUE)
    df$SOURCE<-dirsList[i]
    data<-rbind(data, df)
  }
}

### combine and parse subcorpora







source("./../treetag-fertilizer/fcn_treetag-fertilizer.R")

dirsList<-list.dirs(path = "./corpus/", full.names = FALSE, recursive = TRUE)[-1]

data<-data.frame(matrix(nrow = 0, ncol = 6))
for(i in 1:length(dirsList)){
  path<-paste("./corpus/", dirsList[i], "/", sep = "")
  filesList<-list.files(path = path, recursive = TRUE, pattern = "\\.txt$", full.names = TRUE)
  for(j in 1:length(filesList)){
    df<-treetag.fertilizer("/home/daniel/TreeTagger/", filesList[j], "german")
    df$FILE<-gsub("./corpus/klexikon//", "", filesList[j], fixed = TRUE)
    df$SOURCE<-dirsList[i]
    data<-rbind(data, df)
  }
}
head(data)






### compare corpora
# corpora tagged with treetag.fertilizer




### simplyscience

data<-read.delim("./simplyscience.txt", quote = "", header = FALSE, stringsAsFactors = FALSE) # use read.delim otherwise commas are used as separators and removed
data<-data[,1]

data<-unlist(strsplit(data, split = "<p>", fixed = TRUE)) # split string by paragraphs
data<-data.frame(matrix(unlist(data), nrow=length(data), byrow=T))
data<-gsub(" </p>", "", data[,1]) # remove html

data<-data[-which(duplicated(data) & data != "" & data != "</doc>")] # find duplicated paragraphs and keep only one

data<-gsub('\"', "", data) # remove escape
data<-paste(data, collapse = " ") # collapse into string

data<-unlist(strsplit(data, split = "</doc>", fixed = TRUE)) # split string by documents

data<-data.frame(matrix(unlist(data), nrow=length(data), byrow=T))
data<-data[,1]
library(stringr)
data<-gsub("\\s+", " ", str_trim(data))
data<-trimws(data) # remove leading/trailing whitespace

data<-data[-grep("locale=fr", data)] # remove French files
data<-data[-grep("language=fr", data)] # remove French files
data<-data[-grep(" de | la | et ", data)] # remove French files

data<-data[-grep(" the | first | and | if ", data, perl = TRUE)] # remove English files

data<-gsub(" •", "", data)

data<-gsub("\\<doc.*\\> |\\<doc.*\\>", "", data, perl = TRUE) # remove html document headers

data<-data[-which(data == "")] # remove empty files

library(ngram) # word count remove texts with less than 15 words
for(i in 1:length(data)){
  if(wordcount(data[i]) < 15){
    data<-data[-i]
  }
}

data<-data[-grep("615 Rf* Db* Sg* Bh* Hs* Mt* Ds* Rg* Cn* 18.1 -37 -41 21.46 19.28 285", data, fixed = TRUE)]




num<-c(1:length(data))
for(i in 1:length(data)){
  path<-paste("./corpus/simplyscience/simplyscience-teens-", num[i], ".txt", sep = "")
  fileConn<-file(path)
  writeLines(data[i], fileConn)
  close(fileConn)
}



data<-read.delim("./simplysciencekids.txt", quote = "", header = FALSE, stringsAsFactors = FALSE) # use read.delim otherwise commas are used as separators and removed
data<-data[,1]

data<-unlist(strsplit(data, split = "<p>", fixed = TRUE)) # split string by paragraphs
data<-data.frame(matrix(unlist(data), nrow=length(data), byrow=T))
data<-gsub(" </p>", "", data[,1]) # remove html

data<-data[-which(duplicated(data) & data != "" & data != "</doc>")] # find duplicated paragraphs and keep only one

data<-gsub('\"', "", data) # remove escape
data<-paste(data, collapse = " ") # collapse into string



data<-unlist(strsplit(data, split = "</doc>", fixed = TRUE)) # split string by documents

data<-data.frame(matrix(unlist(data), nrow=length(data), byrow=T))
data<-data[,1]
library(stringr)
data<-gsub("\\s+", " ", str_trim(data))
data<-trimws(data) # remove leading/trailing whitespace

data<-data[-grep("locale=fr", data)] # remove French files
data<-data[-grep("language=fr", data)] # remove French files
data<-data[-grep(" de | la | et ", data)] # remove French files

data<-data[-grep(" the | first | and | if ", data, perl = TRUE)] # remove English files

data<-gsub(" •", "", data)

data<-data[-grep("615 Rf* Db* Sg* Bh* Hs* Mt* Ds* Rg* Cn* 18.1 -37 -41 21.46 19.28 285", data, fixed = TRUE)]

data<-gsub("\\<doc.*\\> |\\<doc.*\\>", "", data, perl = TRUE) # remove html document headers

data<-data[-which(data == "")] # remove empty files

library(ngram) # word count remove texts with less than 15 words
for(i in 1:length(data)){
  if(wordcount(data[i]) < 15){
    data<-data[-i]
  }
}




num<-c(1:length(data))
for(i in 1:length(data)){
  path<-paste("./corpus/simplyscience/simplyscience-kids-", num[i], ".txt", sep = "")
  fileConn<-file(path)
  writeLines(data[i], fileConn)
  close(fileConn)
}




### hanisauland

data<-read.delim("./hanisauland.txt", quote = "", header = FALSE, stringsAsFactors = FALSE) # use read.delim otherwise commas are used as separators and removed
data<-data[,1]

data<-unlist(strsplit(data, split = "<p>", fixed = TRUE)) # split string by paragraphs
data<-data.frame(matrix(unlist(data), nrow=length(data), byrow=T))
data<-gsub(" </p>", "", data[,1]) # remove html

data<-data[-which(duplicated(data) & data != "" & data != "</doc>")] # find duplicated paragraphs and keep only one

data<-gsub('\"', "", data) # remove escape
data<-paste(data, collapse = " ") # collapse into string

data<-unlist(strsplit(data, split = "</doc>", fixed = TRUE)) # split string by documents

data<-data.frame(matrix(unlist(data), nrow=length(data), byrow=T))
data<-data[,1]
library(stringr)
data<-gsub("\\s+", " ", str_trim(data))
data<-trimws(data) # remove leading/trailing whitespace

data<-gsub("\\<doc.*\\> |\\<doc.*\\>", "", data, perl = TRUE) # remove html document headers

data<-data[-which(data == "")] # remove empty files

data<-data[-grep("Antwort von", data)]
data<-data[-grep("Beitrag von", data)]

library(ngram) # word count remove texts with less than 15 words
for(i in 1:length(data)){
  if(wordcount(data[i]) < 15){
    data<-data[-i]
  }
}

data<-gsub("�", "", data)



num<-c(1:length(data))
for(i in 1:length(data)){
  path<-paste("./corpus/hanisauland/hanisauland-", num[i], ".txt", sep = "")
  fileConn<-file(path)
  writeLines(data[i], fileConn)
  close(fileConn)
}




### labbe

data<-read.delim("./labbe.txt", quote = "", header = FALSE, stringsAsFactors = FALSE) # use read.delim otherwise commas are used as separators and removed
data<-data[,1]

data<-unlist(strsplit(data, split = "<p>", fixed = TRUE)) # split string by paragraphs
data<-data.frame(matrix(unlist(data), nrow=length(data), byrow=T))
data<-gsub(" </p>", "", data[,1]) # remove html

data<-data[-which(duplicated(data) & data != "" & data != "</doc>")] # find duplicated paragraphs and keep only one

data<-gsub('\"', "", data) # remove escape
data<-paste(data, collapse = " ") # collapse into string

data<-unlist(strsplit(data, split = "</doc>", fixed = TRUE)) # split string by documents

data<-data.frame(matrix(unlist(data), nrow=length(data), byrow=T))
data<-data[,1]
library(stringr)
data<-gsub("\\s+", " ", str_trim(data))
data<-trimws(data) # remove leading/trailing whitespace

data<-gsub("\\<doc.*\\> |\\<doc.*\\>", "", data, perl = TRUE) # remove html document headers

data<-data[-which(data == "")] # remove empty files

data<-data[-which(nchar(data) < 100)] # remove very short documents

num<-c(1:length(data))
for(i in 1:length(data)){
  path<-paste("./corpus/labbe/labbe-", num[i], ".txt", sep = "")
  fileConn<-file(path)
  writeLines(data[i], fileConn)
  close(fileConn)
}

### rossipotti

data<-read.delim("./rossipotti.txt", quote = "", header = FALSE, stringsAsFactors = FALSE) # use read.delim otherwise commas are used as separators and removed
data<-data[,1]


data<-unlist(strsplit(data, split = "<p>", fixed = TRUE)) # split string by paragraphs
data<-data.frame(matrix(unlist(data), nrow=length(data), byrow=T))
data<-gsub(" </p>", "", data[,1]) # remove html

data<-data[-which(duplicated(data) & data != "" & data != "</doc>")] # find duplicated paragraphs and keep only one

data<-gsub('\"', "", data) # remove escape
data<-paste(data, collapse = " ") # collapse into string

data<-unlist(strsplit(data, split = "</doc>", fixed = TRUE)) # split string by documents

data<-data.frame(matrix(unlist(data), nrow=length(data), byrow=T))
data<-data[,1]
library(stringr)
data<-gsub("\\s+", " ", str_trim(data))
data<-trimws(data) # remove leading/trailing whitespace

data<-gsub("\\<doc.*\\> |\\<doc.*\\>", "", data, perl = TRUE) # remove html document headers

data<-data[-which(data == "")] # remove empty files

data<-data[-c(550, 247, 295, 568, 185, 70, 69, 71, 512)] # remove files with strange content

num<-c(1:length(data))
for(i in 1:length(data)){
  path<-paste("./corpus/rossipotti/rossipotti-", num[i], ".txt", sep = "")
  fileConn<-file(path)
  writeLines(data[i], fileConn)
  close(fileConn)
}

### ich-kenne-meine-Rechte

data<-read.delim("./meinerechteeinfach.txt", quote = "", header = FALSE, stringsAsFactors = FALSE) # use read.delim otherwise commas are used as separators and removed
data<-data[,1]

data<-unlist(strsplit(data, split = "<p>", fixed = TRUE)) # split string by paragraphs
data<-data.frame(matrix(unlist(data), nrow=length(data), byrow=T))
data<-gsub(" </p>", "", data[,1]) # remove html

data<-data[-which(duplicated(data) & data != "" & data != "</doc>")] # find duplicated paragraphs and keep only one

data<-gsub('\"', "", data) # remove escape
data<-paste(data, collapse = " ") # collapse into string

data<-unlist(strsplit(data, split = "</doc>", fixed = TRUE)) # split string by documents

data<-data.frame(matrix(unlist(data), nrow=length(data), byrow=T))
data<-data[,1]
library(stringr)
data<-gsub("\\s+", " ", str_trim(data))
data<-trimws(data) # remove leading/trailing whitespace

data<-gsub("\\<doc.*\\> |\\<doc.*\\>", "", data, perl = TRUE) # remove html document headers

num<-c(1:length(data))
for(i in 1:length(data)){
  path<-paste("./corpus/Rechte-einfach/ich-kenne-meine-Rechte-", num[i], ".txt", sep = "")
  fileConn<-file(path)
  writeLines(data[i], fileConn)
  close(fileConn)
}


### geolino

data<-read.delim("./geolino.txt", quote = "", header = FALSE, stringsAsFactors = FALSE) # use read.delim otherwise commas are used as separators and removed
data<-data[,1]

data<-unlist(strsplit(data, split = "<p>", fixed = TRUE)) # split string by paragraphs
data<-data.frame(matrix(unlist(data), nrow=length(data), byrow=T))
data<-gsub(" </p>", "", data[,1]) # remove html

data<-data[-which(duplicated(data) & data != "" & data != "</doc>")] # find duplicated paragraphs and keep only one

data<-gsub('\"', "", data) # remove escape
data<-paste(data, collapse = " ") # collapse into string

data<-unlist(strsplit(data, split = "</doc>", fixed = TRUE)) # split string by documents

data<-data.frame(matrix(unlist(data), nrow=length(data), byrow=T))
data<-data[,1]
library(stringr)
data<-gsub("\\s+", " ", str_trim(data))
data<-trimws(data) # remove leading/trailing whitespace

data<-gsub("\\<doc.*\\> |\\<doc.*\\>", "", data, perl = TRUE) # remove html document headers
data<-gsub("• ", "", data) # remove bullet points

data<-data[-which(data == "")] # remove empty files


num<-c(1:length(data))
for(i in 1:length(data)){
  path<-paste("./corpus/geolino/geolino-", num[i], ".txt", sep = "")
  fileConn<-file(path)
  writeLines(data[i], fileConn)
  close(fileConn)
}


### oekoleo
data<-read.delim("./oekoleo.txt", quote = "", header = FALSE, stringsAsFactors = FALSE) # use read.delim otherwise commas are used as separators and removed
data<-data[,1]

data<-unlist(strsplit(data, split = "<p>", fixed = TRUE)) # split string by paragraphs
data<-data.frame(matrix(unlist(data), nrow=length(data), byrow=T))
data<-gsub(" </p>", "", data[,1]) # remove html

data<-data[-which(duplicated(data) & data != "" & data != "</doc>")] # find duplicated paragraphs and keep only one

data<-gsub('\"', "", data) # remove escape
data<-paste(data, collapse = " ") # collapse into string

data<-unlist(strsplit(data, split = "</doc>", fixed = TRUE)) # split string by documents

data<-data.frame(matrix(unlist(data), nrow=length(data), byrow=T))
data<-data[,1]
library(stringr)
data<-gsub("\\s+", " ", str_trim(data))
data<-trimws(data) # remove leading/trailing whitespace


data<-gsub("\\<doc.*\\> ", "", data, perl = TRUE) # remove html document headers

data<-gsub("• ", "", data) # remove bullet points
data<-gsub(" ", "", data) # remove strange signs
data<-gsub(" [mehr...]", "", data, fixed = TRUE) # remove bullet points

num<-c(1:length(data))
for(i in 1:length(data)){
  path<-paste("./corpus/oekoleo/oekoleo-", num[i], ".txt", sep = "")
  fileConn<-file(path)
  writeLines(data[i], fileConn)
  close(fileConn)
}



### nachrichtenleicht

data<-read.delim("./nachrichtenleicht.txt", quote = "", header = FALSE, stringsAsFactors = FALSE) # use read.delim otherwise commas are used as separators and removed
data<-data[,1]

data<-unlist(strsplit(data, split = "<p>", fixed = TRUE)) # split string by paragraphs
data<-data.frame(matrix(unlist(data), nrow=length(data), byrow=T))
data<-gsub(" </p>", "", data[,1]) # remove html

data<-data[-which(duplicated(data) & data != "" & data != "</doc>")] # find duplicated paragraphs and keep only one

data<-gsub('\"', "", data) # remove escape
data<-paste(data, collapse = " ") # collapse into string

data<-unlist(strsplit(data, split = "</doc>", fixed = TRUE)) # split string by documents

data<-data.frame(matrix(unlist(data), nrow=length(data), byrow=T))
data<-data[,1]
library(stringr)
data<-gsub("\\s+", " ", str_trim(data))
data<-trimws(data) # remove leading/trailing whitespace


data<-gsub("\\<doc.*\\> ", "", data, perl = TRUE) # remove html document headers

num<-c(1:length(data))
for(i in 1:length(data)){
  path<-paste("./corpus/nachrichtenleicht/nachrichtenleicht-", num[i], ".txt", sep = "")
  fileConn<-file(path)
  writeLines(data[i], fileConn)
  close(fileConn)
}


### klexikon

data<-read.delim("./klexikon.txt", quote = "", header = FALSE, stringsAsFactors = FALSE) # use read.delim otherwise commas are used as separators and removed
data<-gsub("<p> ", "", data[,1]) # remove html
data<-gsub(" </p>", "", data) # remove html
data<-gsub('\"', "", data) # remove escape
data<-paste(data, collapse = " ") # collapse into string
data<-unlist(strsplit(data, split = "</doc>", fixed = TRUE)) # split string by documents
data<-data.frame(matrix(unlist(data), nrow=length(data), byrow=T))
data[,1]<-gsub("  ", " ", data[,1]) # removing double whitespace
data[,1]<-trimws(data[,1]) # remove leading/trailing whitespace
data[,1]<-gsub("In den USA wird bald ein neuer Präsident gewählt. Hier im Klexikon erfährst du das Wichtigste über die beiden Kandidaten Donald Trump und Joe Biden!! ", "", data[,1]) # remove duplicated sentence
data[,1]<-gsub(" Mehr Wissenswertes über .* haben die Blinde Kuh und Frag Finn.", "", data[,1], perl = TRUE, fixed = FALSE) # remove duplicated sentence
data[,1]<-gsub(" Das Klexikon ist wie eine Wikipedia für .* Referate in der Schule.", "", data[,1], perl = TRUE, fixed = FALSE) # remove duplicated sentence
data<-data[,1]
data<-gsub("\\<doc.*\\> ", "", data, perl = TRUE) # remove html document headers

data<-data[-grep("Du bist nicht berechtigt", data)] # remove entries containing this
data<-data[-grep("Die folgende Vorlage ", data)] # remove entries containing this
data<-data[-grep("{{", data, fixed = TRUE)] # remove entries containing this

num<-c(1:length(data))
for(i in 1:length(data)){
  path<-paste("./corpus/klexikon/klexikon-", num[i], ".txt", sep = "")
  fileConn<-file(path)
  writeLines(data[i], fileConn)
  close(fileConn)
}