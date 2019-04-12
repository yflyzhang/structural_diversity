
# Propensity Score Matching


library(MatchIt)
library(dplyr)
library(ggplot2)

library(tableone)

options(tibble.width = Inf)


data <- read.csv('data/ego_features-234834-0306.csv')



dat <-
  data %>%
    # filter(follower_cnt_inc>=0) %>%
    filter(in_degree>=2) %>%
    # mutate(treatment = ifelse( ensemble_SD == in_degree, '1', '0'))
    mutate(treatment = ifelse( weak_SD == in_degree, '1', '0'))
    # mutate(treatment = ifelse( strong_SD == in_degree, '1', '0'))

# Note: 'ensemble_SD == in_degree' is equivalent to 'weak_SD == in_degree'

table(dat$treatment)




covs <-
c('gender_male', 'gender_na', 
  'log_in_degree',

  'log_answerCount', 'log_questionCount', 'log_articlesCount', 
  'log_columnsCount', 'log_pinsCount', 'log_favoriteCount', 

  'log_followingColumnsCount', 'log_followingFavlistsCount', 
  'log_followingQuestionCount', 'log_followingTopicCount')


# 3 Executing a matching algorithm
data_nomiss <- dat %>%  # MatchIt does not allow missing values
  select(social_status_100, treatment, one_of(covs)) %>%
  na.omit()




# set seed for replication purpose
set.seed(1234)

# works
mod_match <- matchit(treatment ~ log_in_degree + log_answerCount + log_questionCount + 
             log_articlesCount + log_columnsCount + log_pinsCount + log_favoriteCount +
             log_followingColumnsCount + log_followingFavlistsCount + 
             log_followingQuestionCount + log_followingTopicCount +
             gender_na + gender_male,
             method = "nearest", 
             # exact=c('log_in_degree', 'gender_na', 'gender_male'), 
             data = data_nomiss,  
             caliper = .001)




1. [get matched pairs]

# the matched matrix
mod_match$match.matrix


# data_nomiss[mod_match$match.matrix]
x <- cbind(data_nomiss[row.names(mod_match$match.matrix),'social_status_100'], data_nomiss[mod_match$match.matrix,'social_status_100'])
x <- as.data.frame(x)
xx <- x[!is.na(x$V2),]

t.test(xx$V1, xx$V2)
t.test(xx$V1, xx$V2, paired=TRUE)

# datafile of matches
matched_pairs<-as.data.frame(mod_match$match.matrix)
colnames(matched_pairs)<-c("matched_unit")

matched_pairs$matched_unit<-as.numeric(as.character(matched_pairs$matched_unit))
matched_pairs$treated_unit<-as.numeric(rownames(matched_pairs))

#now delete matches=na
matched_pairs <- matched_pairs[!is.na(matched_pairs$matched_unit),]
matched_pairs$match_num <- 1:dim(matched_pairs)[1]

# melt(data = x, id.vars = "id", measure.vars = c("blue", "red"))

matched_ids <- 
melt(data = matched_pairs, id.vars = "match_num", 
  measure.vars = c("matched_unit", "treated_unit"),
  variable.name = "matched_type", 
  value.name = "id"
  )



2. [get matched data]

data_matched <- match.data(mod_match)
# m.data1 <- match.data(mod_match, distance ="pscore") # create ps matched data set from previous output
# mdata <- match.data(mod_match, group="all", distance = "distance",
# weights = "weights", subclass = "subclass")

dim(data_matched)

data_matched$id<-as.numeric(rownames(data_matched))


3. [merge matched data with pair info]


# data_matched <- merge(matched_ids, data_matched, by = c('id'))
data_matched <- merge(subset(matched_ids, select=c(match_num, id)), 
                      data_matched, by = c('id'))



#look at a table 1
table1<- CreateTableOne(vars=covs, strata="treatment", data=data_matched, test=TRUE)
## include standardized mean difference (SMD)
print(table1,smd=TRUE)





