# Homework 2
# Julene Landáburu Ibarra

# Packages
library(tidyverse)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(sf)

# Question 2 (40%): For this question, you will be using the City of Chicago 
# Data Portal to create a choropleth using the ggplot and sf libraries. 
# You should: 1) Download two datasets that interest you, 2) Download one or 
# more shapefiles

# At a minimum you should use the "fill" aes in ggplot to color based on your 
# selected data, but you are free to use others as well. 

# Effort to improve the appearance of your plots relative to the default will 
# be rewarded, as will proper usage of tidyverse style, and loops/containers/
# functions should they be appropriate for your code. 

# Save this code as "question_2.R", and include your downloads from the Data 
# Portal in your repo. Save your choropleths as .png files and commit them as 
# well. Include 2-4 sentences in the README describing each specific choropleth 
# is about. Also include in your README a description of the datasets and 
# shapefile.

# The path + datasets
path  <- "C:/Users/Julene/Documents/GitHub/DAP2R-pset2/"
fname1 <- paste0(path, "Victims_of_Homicides.csv")
fname2 <- paste0(path, "Shotspotter_Alerts.csv")

homicide_victims <- read_csv(fname1)
shotspotter_alerts <- read_csv(fname2)

# The shapefile
chi_communities <- st_read(file.path(path, "/geo_export_a7c0c31a-6b8e-4c3f-8f41-d685a35da7a1.shp"))

# First choropleth: homicide victims
homicide_victims <- homicide_victims %>%
  mutate(YEAR = year(mdy_hms(DATE)))

hom_victims_grpd <- homicide_victims %>%
  filter(YEAR != 2024) %>%
  group_by(COMMUNITY_AREA) %>%
  summarize(homicides = n())

homicides_community <- inner_join(hom_victims_grpd, chi_communities, 
                                  by = c("COMMUNITY_AREA" = "community"))

ggplot() +
  geom_sf(data = homicides_community, 
          aes(fill = homicides, geometry = geometry)) +
  scale_fill_gradient(low = "white", high = "darkred") + 
  labs(title = "Number of Victims of homicides and non-fatal shootings 
                in each community area (1992-2023)", 
       fill = element_blank(),
       caption = "Source: City of Chicago") +
  theme_void()

# Second choropleth FALTA HACER LEFT_JOIN PONIENDO PRIMERO EL SHAPEFILE
shotspotter_alerts <- shotspotter_alerts %>%
  mutate(YEAR = year(mdy_hms(DATE)))

ss_alerts_grpd <- shotspotter_alerts %>%
  filter(YEAR != 2024) %>%
  group_by(COMMUNITY_AREA) %>%
  summarize(alerts = n())

ssalerts_community <- full_join(ss_alerts_grpd, chi_communities, 
                                by = c("COMMUNITY_AREA" = "community"))

ggplot() +
  geom_sf(data = ssalerts_community, 
          aes(fill = alerts, geometry = geometry)) +
  scale_fill_gradient(low = "white", high = "darkred") + 
  labs(title = "Number of shotspotter alerts in each community area 
                (2019-2023)", 
       fill = element_blank(),
       caption = "Source: City of Chicago") +
  theme_void()

# These edits to the data are for Q3
# Homicide dataset
homicides_community_q3 <- homicide_victims %>%
  filter(YEAR == 2019:2023) %>%
  group_by(YEAR, COMMUNITY_AREA) %>%
  summarize(homicides = n())

fname3 <- paste0(path, "homicides_community_q3.csv")
write.csv(homicides_community_q3, file = fname3)

# Question 4 (10%): Create a free account on shinyapps.io and upload your app.R 
# file and data files from question 3 to it. Check that the url it generates is 
# working, and include the url to your Shiny app in a comment at the top of your 
# app.R file. General note: Mind the size of the data you pick, particularly the 
# shapefiles. If it becomes quite large you may have issues committing it to 
# GitHub or uploading it to the shinyapps.io website, so lower resolution is 
# generally preferred, and test the upload steps early.
