# Loop lesson

# Set the working directory
setwd("~/Desktop/software-carpentry-2016/data-files/r-lesson/data/")

list.files()

analyze <- function(filename) {
  # Plots the average, min, and max inflammation over time.
  # Input is character string of a csv file.
  
  dat <- read.csv(file = filename, header = FALSE)
  avg_day_inflammation <- apply(dat, 2, mean)
  plot(avg_day_inflammation)
  max_day_inflammation <- apply(dat, 2, max)
  plot(max_day_inflammation)
  min_day_inflammation <- apply(dat, 2, min)
  plot(min_day_inflammation)
}

analyze("inflammation-01.csv")
analyze("inflammation-02.csv")
analyze("inflammation-03.csv")


# For loops

best_practice <- c("Let", "the", "computer", "do", "the", "work")
best_practice

print_words <- function(sentence){
  # Function prints a sentence
  print(sentence[1])
  print(sentence[2])
  print(sentence[3])
  print(sentence[4])
  print(sentence[5])
  print(sentence[6])
}

print_words(best_practice)
print_words(best_practice[-6])

# For loop with a function

print_words <- function(x){
  for(cheese in x){
    # word <- sentence[1]
    # word <- sentence[2]
    print(word)
  }
}


for(word in best_practice){
  print(word)
  print(c(word, word))
}
print_words(best_practice)
print_words(best_practice[-6])

# for(variable in collection){
# do things with variable
# }

len <- 0
vowels <- c("a", "e", "i", "o", "u")
for(dinosaur in vowels){
  print(len)
  len <- len + 1
}
len
v

# Reassigning z
letter <- "z"

for(letter in c("a", "b","c")){
  print(letter)
}

seq(3)

print_N <- function(natural_number){
  # Function prints natural numbers
  # Input is a number
  container_of_numbers <- seq(natural_number)
  for(x in container_of_numbers){
    print(x)
  }
  
}
print_N(3)
print_N(10)


2^4
expo <- function(base, exponent){
  tot <- 1
  
  # Accounts for exponent = 0. Don't worry about this for now  
  for(i in 1:exponent){
    tot <- tot * base
  }
  return(tot)
}
expo(2, 2)

# Loop through files analysis
list.files()
Sys.glob("*.csv")
Sys.glob("i*.csv")
list.files(pattern="inflammation")

# Glob my files
filenames <- Sys.glob("i*.csv")

# Run the analysis on each file
for(file in filenames){
  print(file)
  analyze(file)
}
