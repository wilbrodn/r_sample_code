---
title : "Read_Me.md"
author: "wilbrodn"
date  : "22 March 2017"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## This is my first R Markdown file
### This is a tertially heading such as Intro

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r cars}
summary(cars)
```

### Including Plots

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.


### Including lists
* first item list
* second item list
* etc.

##Including code
This is an r code to confirm that dev tools package has been installed correctly and that r tools are present. result: TRUE

```library(devtools)```
```find_rtools() ```


