# README file: PS2 Julene Landáburu
Data created: 02/01/2024

_Required R packages:_ tidyverse, dplyr, ggplot2, sf, shiny, shinyFeedback, plotly
_Version of R used:_ RStudio 2023.12.0+369

_Summary of code:_ 
* question_2.R loads two datasets (Number of victims of homicides and non-fatal shootings and shotspotter alerts) and one shapefile (Chicago community areas) from the City of Chicago.
* app.R uses the same datasets to create a shiny app that was later on uploaded to https://julenelandaburu.shinyapps.io/dap2r-pset2/

The data was cleaned and each dataset was then merged to make two corresponding choropleths with it:
* question_2a: Choropleth showing the number of victims of homicides and non-fatal shootings in each Chicago community area from 1992 to 2023.
* question_2b: Choropleth showing the number of shotspotter alerts in each Chicago community area from 2019 to 2023.

_Variable definitions:_ Most of the names are self-explanatory. Many make reference to the question that we are dealing with. However, these are the names that were used:
* chi_communities: Shapefile containing Chicago's community areas as downloaded from the City of Chicago's data website. This is also used as an input for the Shiny App.
* homicide_victims: Raw homicide victims data as downloaded from the City of Chicago's data website, with an added YEAR column.
* hom_victims_grpd: homicide_victims without 2024 data, and grouped by COMMUNITY AREA.
* homicides_community: hom_victims_grpd merged with chi_communities to generate question_2a choropleth.
* homicides_community_q3: homicide_victims grouped by YEAR and COMMUNITY AREA, and filtered only from 2019 to 2023 data. This is the dataset used as an input for the Shiny App.
* shotspotter_alerts: Raw shotspotter alerts data as downloaded from the City of Chicago's data website, with an added YEAR column.
* ss_alerts_grpd: shotspotter_alerts with a YEAR column, without 2024 data, and grouped by COMMUNITY AREA.
* ssalerts_community: ss_alerts_grpd merged with chi_communities to generate question_2b choropleth.
The rest were only created for storing or uploading purposes (ex. path, fname)

_Shiny App:_ 
* The elements controlled in the UI are 1) YEAR to filter the data by and 2) high gradient COLOR for the scale used in the choropleth.
* Contains a warning that checks that the YEAR is between 2019 and 2023, inclusive. If the condition is not met, the plot is not displayed.
* Generates a plot filtering by the chosen YEAR and COLOR by using homicides_community_app, which is the merge of chi_communities and homicides_community_q3.
* It is published here: https://julenelandaburu.shinyapps.io/dap2r-pset2/
