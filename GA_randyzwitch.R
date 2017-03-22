#### Connecting to Google Analytics API via R
#### Uses OAuth 2.0
#### https://developers.google.com/analytics/devguides/reporting/core/v3/ for documentation

# Install devtools package & rga - This is only done one time
install.packages("devtools")
library(devtools)
install_github("rga", "skardhamar")


# Load rga package - requires bitops, RCurl, rjson
# Load lubridate to handle dates
library(rga)
library(lubridate)

# Authenticating to GA API. Go to https://code.google.com/apis/console/ and create
# an API application.  Don't need to worry about the client id and shared secret for
# this R code, it is not needed

# If file listed in "where" location doesn't exist, browser window will open.
# Allow access, copy code into R console where prompted
# Once file located in "where" directory created, you will have continous access to
# API without needing to do browser authentication
rga.open(instance = "ga", where = "~/Documents/R/ga-api")


# Get (not provided) Search results.  Replace XXXXXXXX with your profile ID from GA
visits_notprovided.df <- ga$getData(XXXXXXXX,
                                    start.date = "2011-01-01",
                                    end.date = "2013-01-10",
                                    metrics = "ga:visits",
                                    filters = "ga:keyword==(not provided);ga:source==google;ga:medium==organic",
                                    dimensions = "ga:date",
                                    max = 1500,
                                    sort = "ga:date")

names(visits_notprovided.df)<- c("hit_date", "np_visits")

# Get sum of all Google Organic Search results.  Replace XXXXXXXX with your profile ID from GA
visits_orgsearch.df <- ga$getData(XXXXXXXX,
                                  start.date = "2011-01-01",
                                  end.date = "2013-01-10",
                                  metrics = "ga:visits",
                                  filters = "ga:source==google;ga:medium==organic",
                                  dimensions = "ga:date",
                                  max = 1500,
                                  sort = "ga:date")

names(visits_orgsearch.df)<- c("hit_date", "total_visits")

# Merge files, create metrics, limit dataset to just days when tags firing
merged.df <- merge(visits_notprovided.df, visits_orgsearch.df, all=TRUE)
merged.df$search_term_provided <- merged.df$total_visits - merged.df$np_visits
merged.df$pct_np <- merged.df$np_visits / merged.df$total_visits
merged.df$yearmo <- year(merged.df$hit_date)*100 + month(merged.df$hit_date)

final_dataset = subset(merged.df, total_visits > 0)


# Visualization - boxplot by month
# Main plot, minus y axis tick labels
boxplot(pct_np~yearmo,data=final_dataset, main="Google (not provided)\nPercentage of Total Organic Searches",
        xlab="Year-Month", ylab="Percent (not provided)", col= "orange", ylim=c(0,.8), yaxt="n")

#Create tick sequence and format axis labels
ticks <- seq(0, .8, .2)
label_ticks <- sprintf("%1.f%%", 100*ticks)
axis(2, at=ticks, labels=label_ticks)