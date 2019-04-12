

library(tableone)
library(stargazer)
library(dplyr)

data <- read.csv('data/ego_features-234834-0306.csv')


dat <-
data %>%
  # filter(social_status_100>=33.36201) %>%    # top 5%
  mutate(log_in_degree = log_in_degree/max(log_in_degree)) %>%
  mutate(log_weak_SD = log_weak_SD/max(log_weak_SD)) %>%
  mutate(log_strong_SD = log_strong_SD/max(log_strong_SD)) %>%
  mutate(log_answerCount = log_answerCount/max(log_answerCount)) %>%
  mutate(new_index = log_voteupCount+log_thankedCount+log_favoritedCount) %>%
  mutate(new_index = new_index/max(new_index)) %>%
  mutate(log_voteupCount = (log_voteupCount-min(log_voteupCount))/(max(log_voteupCount)-min(log_voteupCount))) %>%
  mutate(log_thankedCount = (log_thankedCount-min(log_thankedCount))/(max(log_thankedCount)-min(log_thankedCount))) %>%
  mutate(log_favoritedCount = (log_favoritedCount-min(log_favoritedCount))/(max(log_favoritedCount)-min(log_favoritedCount))) %>%
  mutate(log_pagerank = (log_pagerank-min(log_pagerank))/(max(log_pagerank)-min(log_pagerank))) %>%
  select(log_in_degree, log_weak_SD, 
    log_strong_SD, log_answerCount, log_pagerank, 
    log_voteupCount, log_thankedCount, log_favoritedCount,
    new_index,
    social_status) 
  # %>% summary()


summary(dat)




model1 = lm(social_status ~ log_in_degree,
           data = dat)
summary(model1)

model2 = lm(social_status ~ log_weak_SD,
           data = dat)
summary(model2)

model2.1 = lm(social_status ~ log_in_degree + log_weak_SD,
           data = dat)
summary(model2.1)


model3 = lm(social_status ~ log_strong_SD,
           data = dat)
summary(model3)

model3.1 = lm(social_status ~ log_in_degree + log_strong_SD,
           data = dat)
summary(model3.1)


model3.2 = lm(social_status ~  log_weak_SD + log_strong_SD,
           data = dat)
summary(model3.2)


model4 = lm(social_status ~ log_in_degree + log_weak_SD + log_strong_SD,
           data = dat)
summary(model4)



# generating latex table
stargazer(model1, model2, model3, model4, title="Results", align=TRUE)

stargazer(model1, model2, model3, model2.1, model3.1, model3.2, model4, title="Results", align=TRUE)




