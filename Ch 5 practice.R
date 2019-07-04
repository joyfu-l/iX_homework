
#alt shift k for shortcuts

#load library
library(nycflights13)
library(tidyverse)

#filter flights for only Jan 1st
jan1 <- filter(flights, month == 1, day == 1)

#arrange
#flights wiht longest departure delay
arrange(flights, desc(dep_delay))

# select specific columns
select(flights, year:day)

#use mutate to add a new variable
flight_delay <- arrange(flights, desc(dep_delay)) %>%
  select(dep_delay)
view(flight_delay)

flights_sml <- select(flights,
                      year:day,
                      ends_with("delay"),
                      distance,
                      air_time)
view(flights_sml)

flights_sml <- flights_sml %>%
  group_by(month)
arrange(desc(dep_delay))

#introduce the pipe operator
flights_sml <-  flights_sml %>%
  mutate(gain = dep_delay - arr_delay,
         speed = distance / air_time * 60)

#doing operations across groups
#summarise (making a 'smaller' data set)

#average departure delay by day
by_day <- flights %>%
  group_by(year, month, day) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE)) %>%
  ungroup()


#per group metrics
popular_dests <- flights %>%
  group_by(dest) %>%
  filter(n() > 365) %>%
  ungroup()

#keeping datasets 'grouped' can lead to problems later 
#it is safest to always ungroup

