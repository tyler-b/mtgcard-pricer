# mtgcard-pricer

## Introduction

I desired to search for the values of some Magic: the Gathering cards that I have. I realized there is no tool to do a batch search of card values. So I cataloged all of the cards I had in a "Magic Cards.csv" input file. I found price list information on "shop.tcgplayer.com/price-guide/magic" and downloaded the html files to a /Price Lists/ directory. I then wrote the Magic Cards.R code file that imports the csv file and the html files and matches the cards based on name. The data is sorted from high to low value. Then the code outputs a csv file of the expensive cards as the output.

## How to Use

* Create a 'Magic Cards.csv' input file
* Obtain price list information and place in /Price Lists/ directory
* Copy Magic Cards.R file in the same location as the /Price Lists/ directory
* Set working directory to location of Magic Cards.R
* Run the Magic Cards.R file

## Prerequisits

* R https://cran.r-project.org/
* RStudio (recommended) https://www.rstudio.com/
* XML library for R https://cran.r-project.org/web/packages/XML/index.html
* dplyr library for R https://cran.r-project.org/web/packages/dplyr/index.html

## Files

### "Magic Cards.R"

The R code to be run

### "Magic Cards.csv" input file

An example of an input file. This displays the necessary input format. A csv file is created with all of the cards that the user wants to find the value of. Four columns are included as shown below. The first line of this csv file must have the column headers. Below an example of a set of 3 cards is shown. This could be used as an input file.

```
Card Name,Page in my Book,Copyright Yr,Edition
Carrion Ants,1,1995,4th Edition
Winter Orb,1,1995,4th Edition
Lifelace,1,1995,4th Edition
```

### "/Price Lists/" directory

A directory that needs to be filled with the appropriate price list infomation. A good source of price guide information is "http://shop.tcgplayer.com/price-guide/magic". A user must select the correct product line and the correct set. After the web page is updated, the user needs to save the resulting html file in the /Price Lists/ directory. In Chrome this is done by: options -> more tools -> save page as -> webpage, html only.

## Future Possible Improvements

* search for ebay auction prices
* search for price information from multiple sources and output a value confidence interval
* Include searching by more than just card name, like adding edition to the matching criteria.
