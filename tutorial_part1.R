# Tour of RStudio
# * The console
# * The source
# * The file pane
# * The environment pane
# * The help pane
# * Changing the appearance

# R as Calculator: Doing arithmetic
2 + 5
5 - 1
6 * 2
6 / 2
5^3
(6 / 2) * 5

# Variable assignment
x <- 4
x = 4

x + 2
x - 1
x^2

y <- 2
x + y
x * y

# Types
class(x)
class(5)

# strings/characters
greeting <- "Hello"
name <- "world"
class(greeting)
paste(greeting, name)

# logicals
l1 <- TRUE
l2 <- FALSE
class(l1)

l2
!l1
!l2

# Comparison
x > y
x < y
x <= y
x == 4
x >= 4

# Vectors and common functions
v1 <- c(1, 2, 3, 4, 5)
v1
length(v1)
sum(v1)
mean(v1)
median(v1)

v2 <- c("a", "b", "c", "d")
length(v2)
sum(v2)
class(v2)

2 %in% v1
157 %in% v1
"a" %in% v2
"z" %in% v2

v3 <- c(TRUE, TRUE, FALSE, TRUE)
length(v3)
all(v3)
any(v3)

v1 > 3
all(v1 > 3)
any(v1 > 3)

# Other classes: factor, etc.

# R help
?all
?sum
help(all)

# Data frames
View(mtcars)
class(mtcars)

head(mtcars)
str(mtcars)
dim(mtcars)
nrow(mtcars)
ncol(mtcars)

mean(mtcars$mpg)
mean(mtcars$hp)

# Installing packages
install.packages("tidyverse")
install.packages("palmerpenguins")
