
# R and ggplot2 
## Overarching Goal  
Understand how to make graphs in R 

## Learning Objectives
* Understand benefits of using R/ ggplot2
* Navigate RStudio
* Learn how to tidy data for plotting
* Make and adjust graphs in ggplot2

## Getting started
* Downloads
  * [R](https://www.r-project.org/)
  * [RStudio](https://www.rstudio.com/products/rstudio/)
  
---

## R and RStudio
[RStudio_diagram](https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/RStudio_diagram.jpg)




## ggplot2
* This system is widely used and flexible
* We can think of ggplot2 as a system of layers that all add to one another to make a final graph
* ggplot2 layers
    * data
    * aesthetic mapping
    * geometric object
    * statistical transformations
    * scales
    * coordinate system
    * position adjustments
    * faceting
 
 * We'll start with the basics: data and aesthetics
  * For this tutorial we will use the Iris dataset (comes with the R "datasets" package)
  * See code below
 
 ```
 #make sure you installed the required packates
install.packages("ggplot2")
install.packages("datasets")

#load required packages
library(ggplot2)
library(datasets)

#read in data (here we will use a dataset from R datasets)
data=read.delim(iris)

#let's make an easy plot
ggplot(iris, aes(x=Species, y=Sepal.Width))
```
* ![simple_plot](

* Helpful hint: we read code from inside out :) 
---
## More resources
* [Quick how-to's for graphing](http://www.cookbook-r.com/Graphs/)
* [Growth curve plotting tutorial by Brian Connelley](http://bconnelly.net/2014/04/analyzing-microbial-growth-with-r/)
* Follow Hadley Wickham on twitter! [@hadleywickham](https://twitter.com/hadleywickham)
* [ggplot2 help topics](http://docs.ggplot2.org/current/index.html)
* [Amazing ggplot2 examples](http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html)
