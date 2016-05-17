
# data gathered 4.17.2016
# http://shop.tcgplayer.com/price-guide/magic/fourth-edition
# http://shop.tcgplayer.com/price-guide/magic/fifth-edition
# http://shop.tcgplayer.com/price-guide/magic/fallen-empires
# http://shop.tcgplayer.com/price-guide/magic/homelands
# http://shop.tcgplayer.com/price-guide/magic/ice-age
# http://shop.tcgplayer.com/price-guide/magic/mirage
# http://shop.tcgplayer.com/price-guide/magic/odyssey
# http://shop.tcgplayer.com/price-guide/magic/portal
# http://shop.tcgplayer.com/price-guide/magic/stronghold
# http://shop.tcgplayer.com/price-guide/magic/tempest
# http://shop.tcgplayer.com/price-guide/magic/visions
# http://shop.tcgplayer.com/price-guide/magic/weatherlight
# 
# data gathered 5.17.2016
# http://shop.tcgplayer.com/price-guide/magic/legends
# http://shop.tcgplayer.com/price-guide/magic/arabian-nights
# http://shop.tcgplayer.com/price-guide/magic/the-dark

# Load Libraries
library(XML)
library(dplyr)

# Set working directory
setwd("C:/Users/Tyler/Desktop/Magic the Cards")

# Read list of cards I have
mycards <- read.csv("Magic Cards.csv")

# search for all of the html files that contain the values of the cards
pricepages <- dir(pattern = ".html$", recursive = TRUE)
pricelist <- data.frame()

# Loop through all the pages of values and generate a data frame (pricelist) of all the values
for (i in 1:length(pricepages)) {
     pricetable <- readHTMLTable(pricepages[i])
     df <- pricetable[[1]]
     df <- df[ ,1:7] # remove column 8
     names(df)[6] <- "Market Price" # Clean up the name of column 6
     ed <- basename(pricepages[i])
     ed <- substr(ed, 1, nchar(ed)-5)
     df <- mutate(df, edition2 = ed)
     pricelist <- rbind(pricelist, df)
}

# Tidying Up Price List data frame
pricelist$edition2 <- factor(pricelist$edition2) # make edition a factor
names(pricelist) <- make.names(names(pricelist)) # tidy col names
pricelist <- pricelist[ ,-c(4, 7)]
rm(df,ed,i,pricepages,pricetable) # remove working variables

# Find matches between cards I have and price list
matches <- pmatch(x = mycards$Card.Name, table = pricelist$PRODUCT, duplicates.ok = TRUE)
matches2 <- matches[complete.cases(matches)]

# Create data frame of cards that I have and their prices (mycardsprices)
mycardsprices <- pricelist[matches2,]

# Create the master data frame of card that I have and their prices
mycardscomplete <- data.frame(mycards,mycardsprices)

# Clean up
rm(mycards,mycardsprices,pricelist,matches,matches2)

# convert market to numeric
mycardscomplete$price <- as.numeric(sub("$","",as.character(mycardscomplete$Market.Price),fixed=TRUE))

# For cards that don't have data for market price
# use the median price value for the cards that don't have a market price
noprice <- is.na(mycardscomplete$price)
#mycardscomplete$price[noprice] <- mycardscomplete$Median.Price[noprice]
# Remove the dollar sign and convert to numeric
mycardscomplete$price[noprice] <- as.numeric(sub("$","",as.character(mycardscomplete$Median.Price[noprice]),fixed=TRUE))
rm(noprice) # clean up

# sort by price
mycardscomplete <- arrange(mycardscomplete, desc(price))


# Summary Information
plot(mycardscomplete$price)

# sum of price
sum(mycardscomplete$price)

# Threshold Price
pricethres <- 0.75
myexpensivecards <- mycardscomplete[mycardscomplete$price > pricethres , ]
myrarecards <- mycardscomplete[mycardscomplete$Rarity == "R",]
myunccards <- mycardscomplete[mycardscomplete$Rarity == "U",]
plot(myexpensivecards$price)
sum(myexpensivecards$price)

# Write CSV output
write.csv(myexpensivecards, file = "expensive.csv")
write.csv(myrarecards, file = "rare.csv")

