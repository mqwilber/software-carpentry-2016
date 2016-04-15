# Plyr lesson
mammals <- read.csv(file.choose())
dim(mammals)

install.packages('dplyr')
library(data.table)
library(dplyr)

head(mammals)
glimpse(mammals)
mam2 <- as.data.table(mammals)
summary(mam2)

# Summarize data
head(select(mammals, order, species))
mam2[, list(order, species)]

# Select particular columns
head(select(mammals, species, starts_with("adult")))
head(select(mammals, -order))

# Select by rows
head(filter(mammals, order == "Carnivora"))
head(filter(mammals, order == "Carnivora" & adult_body_mass_g < 5000))
head(filter(mammals, order == "Carnivora" | order == "Primates"))


head(arrange(mammals, adult_body_mass_g))
head(arrange(mammals, desc(adult_body_mass_g)))
head(arrange(mammals, order, adult_body_mass_g))

# Exercise 1
head(arrange(filter(mammals, order == "Carnivora"), desc(adult_body_mass_g)))
dim(filter(mammals, order=="Primates"))
# 376 primates
dim(mam2[order=="Primates", ])


# Summarizing data!
a = group_by(mammals, order)
summarize(a, mean_mass=mean(adult_body_mass_g, na.rm=T))

summarize(a, mean_mass = mean(adult_body_mass_g, na.rm = TRUE), sd_mass = sd(adult_body_mass_g, na.rm = TRUE))

a <- group_by(mammals, order)
b = mutate(a, mean_mass=mean(adult_body_mass_g, na.rm=T)) # this is handy

# using data.table
mam2[, list(mean=mean(adult_body_mass_g, na.rm=T)), by="order"]

a <- group_by(mammals, order)
mutate(a, mean_mass = mean(adult_body_mass_g, na.rm = TRUE), normalized_mass = adult_body_mass_g / mean_mass)



# Exercise:
# 1. Which order has the most species?
mammals %>% group_by(order) %>% summarize(num_spp=length(species)) %>% arrange(desc(num_spp))
mam2[, list(num_spp=length(species)), by=order][order(num_spp)[length(order):1], ][1,]

# Range of body mass
mammals %>% group_by(order) %>% 
        summarize(width=max(adult_body_mass_g, na.rm=T) - min(adult_body_mass_g, na.rm=T)) %>%
        arrange(desc(width))


# Ratio
carn = mammals %>% filter(order=="Carnivora")
carn[which.max(carn$adult_head_body_len_mm / carn$adult_body_mass_g ), ]

## GGplot
library(ggplot2)
        
ggplot(data=mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm)) + geom_point()


ggplot(data=mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm))+
  geom_point()+
  scale_x_log10()


ggplot(data=mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm))+
  geom_point(size=3)+
  scale_x_log10()


ggplot(data=mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm))+
  geom_point(size=3, aes(color=order))+
  scale_x_log10()


TailsnWhales<-filter(mammals, order == "Rodentia" | order == "Cetacea") 

ggplot(data=TailsnWhales, aes(x=adult_body_mass_g, y=adult_head_body_len_mm))+
  geom_point(size=3, aes(color=order))+
  scale_x_log10()

ggplot(data=TailsnWhales, aes(x=order, y=adult_body_mass_g))+
  geom_boxplot(size=1, aes(color=order))+
  scale_y_log10()

ggplot(data=TailsnWhales, aes(x=adult_head_body_len_mm))+  
  geom_histogram()

primncarn = filter(mammals, order=="Carnivora" | order=="Primates")
ggplot(primncarn, aes(x=adult_body_mass_g, y=home_range_km2)) + 
      geom_point(aes(color=order)) + scale_y_log10() + scale_x_log10()


ggplot(data=mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm))+
  geom_point()+
  scale_x_log10()+scale_y_log10()+
  facet_wrap(~order)


mammals$RangeCategory[mammals$home_range_km2 <= 0.01] <- "micro_machines"
mammals$RangeCategory[mammals$home_range_km2 > 0.01 & mammals$home_range_km2 <= 1] <- "homebodies"
mammals$RangeCategory[mammals$home_range_km2 > 0.1 & mammals$home_range_km2 <= 10] <- "strollers"
mammals$RangeCategory[mammals$home_range_km2 > 10 & mammals$home_range_km2 <= 100] <- "roamers"
mammals$RangeCategory[mammals$home_range_km2 > 100 & mammals$home_range_km2 <= 1000] <- "free_agents"
mammals$RangeCategory[mammals$home_range_km2 > 1000] <- "transcendentalists"

OrderSubset<-filter(mammals, order == "Rodentia" | order == "Cetacea" | order=="Primates" | order=="Carnivora") 
OrderSubset$RangeCategory <- factor(OrderSubset$RangeCategory, levels = c("micro_machines", "homebodies", "strollers", "roamers", "free_agents", "transcendentalists"))
OrderSubset$order <- factor(OrderSubset$order, levels = c("Rodentia", "Carnivora", "Primates", "Cetacea"))


ggplot(data=OrderSubset, aes(x=RangeCategory, y=adult_body_mass_g))+
  geom_boxplot()+ scale_y_log10() +
  facet_grid(.~order, scales="free")


# SQL Lesson

install.packages("sqldf", dependencies = TRUE)  
library("sqldf")



mammals <- read.csv("~/Desktop/software-carpentry-2016/data-files/mammal_stats.csv", header=T)
sqldf("select * from mammals limit 10")
sqldf("select distinct `order` from mammals")
sqldf("select distinct `order`, species from mammals")
sqldf("select * from mammals where `order`='Carnivora' order by `adult_body_mass_g` desc limit 10")

sqldf("select distinct species from mammals where `litter_size`<1")
sqldf("select distinct `order` as taxonOrder from mammals")
mammalsEdited <-  sqldf("select `order` as taxonOrder, species, adult_body_mass_g as mass from mammals")
head(mammalsEdited)












