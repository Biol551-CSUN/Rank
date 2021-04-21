##Class practice code for Strings/Character Vectors
##by Evan Rank
##2021-04-19


library(here)
library(tidyverse)
library(tidytext)
library(wordcloud2)
library(janeaustenr)

paste("High temp", "Low temp")

paste("High temp", "Low temp", sep = "-")

paste0("High temp", "Low temp")

shapes <- c("Square", "Triangle")
paste("My favorite shape is a", shapes)

two_cities <- c("best", "worst")
paste("It was the", two_cities, "of times.")

str_length(shapes)

seq_data <- c("ATCCCGTC")

str_sub(seq_data, start=2, end=4) #read string subset

str_sub(seq_data, start = 3, end = 3) <- "A" # add an A in the 3rd position
seq_data

str_dup(seq_data, times = c(2, 3)) #duplicate in a set of 2 and a set of 3

badtreatments <- c("High", " High", "High ")

str_trim(badtreatments)

str_trim(badtreatments, side = "left")

str_pad(badtreatments, 5, side = "right") # add a white space to the right side. Pad up to the number of characters specified
str_pad(badtreatments, 5, side = "right", pad = "1") # add a 1 to the right side af

x<-"I love R"
str_to_upper(x) #capitalize everything, may perform differenty by language
str_to_lower(x)
str_to_title(x) #first of every word

#Pattern matching
data<-c("AAA", "TATA", "CTAG", "GCTT")
str_view(data, pattern = "A")
str_detect(data, pattern = "A")
str_locate(data, pattern = "AT")

#Replace metacharacters
vals<-c("a.b", "b.c","c.d")
str_replace(vals, "\\.", " ") #will only replace first option
vals<-c("a.b.c", "b.c.d")
str_replace_all(vals, "\\.", " ")

val2<-c("test 123", "test 456", "test") #Sequences can be matched, here we will match digit characters
str_subset(val2, "\\d")

str_count(val2, "[aeiou]")

strings<-c("550-153-7578",
           "banana",
           "435.114.7586",
           "home: 672-442-6739")
phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"

test <- str_subset(strings, phone)

test %>% 
str_replace_all(pattern = "\\.", "-") %>% 
str_replace_all(pattern = "-",  "") %>% 
  str_replace_all(pattern ="home: ", "")

#tidytext

head(austen_books())
tail(austen_books())

original_books <- austen_books() %>% # get all of Jane Austen's books
  group_by(book) %>%
  mutate(line = row_number(), # find every line
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]", # count the chapters (starts with the word chapter followed by a digit or roman numeral)
                                                 ignore_case = TRUE)))) %>% #ignore lower or uppercase
  ungroup() # ungroup it so we have a dataframe again
# don't try to view the entire thing... its >73000 lines...
head(original_books)

tidy_books <- original_books %>%
  unnest_tokens(output = word, input = text) # add a column named word, with the input as the text column
head(tidy_books)

head(get_stopwords()) #common words with no important meaning

cleaned_books <- tidy_books %>%
  anti_join(get_stopwords())

head(cleaned_books)

cleaned_books %>%
  count(word, sort = TRUE)

sent_word_counts <- tidy_books %>%
  inner_join(get_sentiments()) %>% # only keep pos or negative words
  count(word, sentiment, sort = TRUE) # count them

sent_word_counts %>%
  filter(n > 150) %>% # take only if there are over 150 instances of it
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>% # add a column where if the word is negative make the count negative
  mutate(word = reorder(word, n)) %>% # sort it so it gows from largest to smallest
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col() +
  coord_flip() +
  labs(y = "Contribution to sentiment")

words<-cleaned_books %>%
  count(word) %>% # count all the words
  arrange(desc(n))%>% # sort the words
  slice(1:100) #take the top 100
wordcloud2(words, shape = 'triangle', size=0.3) # make a wordcloud out of the top 100 words