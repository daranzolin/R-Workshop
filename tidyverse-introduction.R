## SETTINGS THINGS UP
install.packages("tidyverse")
install.packages("lubridate")
install.packages("tidylog")
library(tidyverse)
library(lubridate)
# setwd("yourworkingdirectory")
# setting a working directory is not always necessary. If you're using  as R knows where the script
# file is located, and will use that as the default working directory.
## BASICS
# to run a line of code, use ctrl + enter
# ` <- ` is the assignment operator. It allows you to assign values to variables,
# or transformations to a data frame.
# SHORTCUT: alt + "-"
result <- 3 + 1
df <- tibble(people = c("Charlie", "Anna", "David", "Charlie", "Anna", "Charlie", "David", "Vincent", "Vincent", "Andrew"),
             numbers = c(43, 24, 64, 12, 75, 21, 22, 50, 12, 20),
             OEWD = c("OEWD"))
# ` %>% ` is a pipe. It allows you to chain functions together, while maintaining readability.
# SHORTCUT: ctrl + shift + "m"
df %>%
  function1() %>%
  function2() %>%
  function3
# take df and run it through function1. Take the output of that, and run it through function 2...
# the same code written in base R, might look like this:
function3(function2(function1(df)))
df %>%
  filter(people != "Andrew") %>%
  select(people, numbers) %>%
  group_by(people) %>%
  summarize(mean(numbers))
#base R version
setNames(aggregate(numbers ~ people, data=df[df$people != "Andrew", c("people", "numbers")], FUN=mean), c("people", "mean_numbers"))


## READING IN DATA
df <- read_csv("")
# read_excel() is also another useful function
activity_raw <- read_csv("") #find the activity record CSV downloaded on April 11th

## DATA EXPLORATION
# 1. open the dataset
# view()
# 2. str() or glimpse()
# 3. count()
activity_raw %>%
  count(`Program Activity Name`)
# 4. visualizations

## TRANSFORMING DATA
#1. filter(): choose rows based on values of a variable
activity_raw %>%
  filter(Agency == "Mission Hiring Hall")

#2. `select()`: choose certain columns by name
activity_raw %>%
  select(Agency, `Program Activity Name`)

#3. `group_by()`: group observations based on a variable
activity_raw %>%
  group_by(Agency)
#4. `summarize()`: summarize observations based on some function
activity_raw %>%
  summarize(`Agency Code`)
df %>%
  summarize(sum(numbers))
df %>%
  summarize(min(numbers))
df %>%
  group_by(people) %>%
  summarize(mean(numbers))
# don't use these...use count() instead!
df %>%
  group_by(people) %>%
  summarize(count = n())
activity_raw %>%
  group_by(`Program Activity Name`) %>%
  summarize(count = n())
# count is AWESOME
activity_raw %>%
  count(`Program Activity Name`)

#5.`mutate()`: create new variables with functions of existing variables
df %>%
  group_by(group) %>%
  mutate(max = max(value))
activity_raw %>%
  mutate(begindate_reformat = mdy(`Begin Date`)) %>%
  select(`Begin Date`, begindate_reformat)
activity <- activity_raw %>%
  mutate(`Begin Date` = mdy(`Begin Date`))

#6. `join()`: merge 2 datasets on a shared column or columns.
# left_join = m:1 merge
oewd1 <- read_csv("")
activity_oewd1 <- activity %>%
  left_join(oewd1, by= "ApplicationNumber")

## WRITING OUT DATA
#make sure you know where the dataframe will be saved
getwd()
write_csv(df, "filename.csv")

write.table(df, "clipboard", sep="\t", row.names=FALSE)

## EXERCISE 1: COUNTING CLIENT ACTIVITIES BY AGENCIES FOR FY22-23 Q3







## EXERCISE 2: COUNTING GF/CDBG CLIENTS BY RACE/ETHNICITY FOR SINGLE-RACE INDIVIDUALS FOR FY22-23 Q3
race_cw <- tibble(race_name = c("American Indian or Alaskan Native",
                                "Asian",
                                "Black or African American",
                                "Hispanic, Latino, or Spanish",
                                "Middle Eastern or Northern African",
                                "Native Hawaiian or Other Pacific Islander",
                                "White"),
                  race_value = c("1", "2", "3", "4", "5", "6", "7"))










## EXERCISE 1 ANSWERS
#this gets the job done, but isn't as efficient
activity_raw %>%
  filter(mdy(`Begin Date`) >= "2023-01-01" & mdy(`Begin Date`) <="2023-03-31") %>%
  group_by(Agency, `Program Activity Name`) %>%
  summarize(count = n())
#this is great, but we can actually simplify it further
activity_raw %>%
  filter(mdy(`Begin Date`) >= "2023-01-01" & mdy(`Begin Date`) <="2023-03-31") %>%
  group_by(Agency) %>%
  count(`Program Activity Name`)
#this is *chef's kiss*
activity_raw %>%
  filter(mdy(`Begin Date`) >= "2023-01-01" & mdy(`Begin Date`) <="2023-03-31") %>%
  count(Agency, `Program Activity Name`)
## EXERCISE 2 ANSWERS
race_cw <- tibble(race_name = c("American Indian or Alaskan Native",
                                "Asian",
                                "Black or African American",
                                "Hispanic, Latino, or Spanish",
                                "Middle Eastern or Northern African",
                                "Native Hawaiian or Other Pacific Islander",
                                "White"),
                  race_value = c("1", "2", "3", "4", "5", "6", "7"))
activity_oewd1_race <- activity_oewd1 %>%
  left_join(race_cw, by = c(`Race/Ethnicity` = "race_value"))

filter(`Begin Date` >= "2023-01-01" & `Begin Date` <= "2023-03-31")
filter(between(`Begin Date`, as.Date("2023-01-01"), as.Date("2023-03-31")))
activity_oewd1 %>%
  left_join(race_cw, by = c(`Race/Ethnicity` = "race_value")) %>%
  filter(`Begin Date` >= "2023-01-01" & `Begin Date` <= "2023-03-31") %>%
  filter(`Grant Codes` == "999 888") %>%
  count(race_name) %>%
  view()
#let's do a visual check with the original race/ethnicity values
activity_oewd1 %>%
  filter(`Begin Date` >= "2023-01-01" & `Begin Date` <= "2023-03-31") %>%
  filter(`Grant Codes` == "999 888") %>%
  count(`Race/Ethnicity`) %>%
  view()
