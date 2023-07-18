

# Import data set and packages
library(readr)
library(dplyr)
library(tidyverse)
library(ggplot2)
library(lubridate)
library(stringi)
library(data.table)


credit_card_fraud <- read_csv("credit_card_fraud.csv", show_col_types = FALSE)
df <- data.frame(credit_card_fraud)


# Drop cols
df <- subset(df, select = c('trans_date_trans_time','merchant','category','amt','gender','city','state',
                            'city_pop','job','dob','trans_num','is_fraud'))


## Basic Data exploration
summary(df)
head(df)


# Check the class imbalance (percentage included)
table(df$is_fraud)
prop.table(table(df$is_fraud))

# Examine the distribution of fraud labels
manual_theme <- theme(plot.title = element_text(hjust = 0.5, face = "bold"))

ggplot(data = df, aes(x = factor(is_fraud), 
                      y = prop.table(stat(count)), fill = factor(is_fraud),
                      label = scales::percent(prop.table(stat(count))))) +
  geom_bar(position = "dodge") + 
  geom_text(stat = 'count',
            position = position_dodge(.9), 
            vjust = -0.5, 
            size = 3) + 
  scale_x_discrete(labels = c("not fraud", "is fraud")) +
  scale_y_continuous(labels = scales::percent)+
  labs(x = 'Fraud Label', y = 'Percentage') +
  ggtitle("Distribution of is_fraud labels") +
  manual_theme


# Examine the feature of 'Amount'
ggplot(df, aes(x = factor(is_fraud), y = amt)) + geom_boxplot() + 
  labs(x = 'Fraud Label', y = 'Amount') +
  ggtitle("Distribution of transaction amount by is_fraud") + 
  manual_theme


# Examine the feature of 'City Population'
ggplot(df, aes(x = factor(is_fraud), y = city_pop)) + geom_boxplot() + 
  labs(x = 'Fraud Label', y = 'Amount') +
  ggtitle("Distribution of transaction amount by is_fraud") + 
  manual_theme


# Get a clear visual to see if there is any irregular data using a boxplot
boxplot(df$amt,df$city_pop)


## Data Cleaning (dropping the N/A values)
is.na(df)
na.omit(df)


# Count total rows in dataframe with no NA values in any column of df
nrow(na.omit(df))


# Target the data with fraud 
is_fraud_df <- df[df$is_fraud == 1,]

summary(is_fraud_df)


# Random Sampling
set.seed(99)

f_df <- is_fraud_df[sample(nrow(is_fraud_df), 500, replace = FALSE), ]

summary(f_df)

# Save new dataset as csv
write.table(f_df, file = "credit_card_fOnly.csv",
            sep = ",", row.names = F)


# Create another random sampling df for other cases
set.seed(3)

r_df <- df[sample(nrow(df), 500, replace = FALSE), ]

table(r_df$is_fraud)

# Save into another csv file
write.table(r_df, file = "credit_card.csv",
            sep = ",", row.names = F)



## Data Manipulation
# 1
# Get the year from string of last 4 digit
x <- stri_extract_last_regex(f_df$dob, "\\d{4}")
x

# Transform the DOB from string into integer
dob <- as.integer(gsub(pattern = "/",replacement = "", x = x))
dob

# Get the age of fraud credit card holder
current_age <- c()

for(i in dob){
  n <- print(2022 - i)
  current_age <- c(current_age, n)
  output <- data.frame(current_age)
}
output

# Find the most affected age in fraud
age_summary <- setDT(output)[, list(Count=.N), names(output)]

age_summary
summary(age_summary$current_age)
boxplot(age_summary$current_age)



# 2.
# Group by sum using dplyr
agg_cate <- f_df %>% group_by(category) %>% 
  summarise(sum_amount = sum(amt),
            .groups = 'drop')
agg_cate

# Convert to df
f0 <- agg_cate %>% as.data.frame()
f0
summary(f0)



# 3.
# alpha = 0.05
model <- lm(f_df$city_pop~ f_df$amt)

summary(model)

# F-statistic, with 1 and n-2 degree
qf(0.95, df1=1, df2=496)


# Compute the test statistic
anova(model)

# Plot the regression
plot(f_df$city_pop, f_df$amt, pch = 16, col = 'blue', main = 'Amount of Transaction against City Population',
     xlab = 'City population', ylab = 'Amount of transaction')

# Regression line
abline(lm(f_df$amt~f_df$city_pop))





# Additional test on amt and gender
Male <- ifelse(f_df$gender == 'M', 1, 0)
Female <- ifelse(f_df$gender == 'F', 0, 1)

# Create model, Male
model_g <- lm(amt ~ Male, data = f_df)

summary(model_g)

anova(model_g)

# Female
model_g2 <- lm(amt ~ Female, data = f_df)

summary(model_g2)

anova(model_g2)





