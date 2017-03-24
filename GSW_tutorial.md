
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
![RStudio_diagram](https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/RStudio_diagram.jpg)




## ggplot2
* This system is widely used and flexible
* Easy to work with large datasets
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
    * 150 flowers
    * 3 types of Irises
    * Sepal Length, Sepal Width, Petal Length and Petal Width for each Iris type
    * A snapshot of the dataset is shown below
    * ![Iris_dataser])(https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/Iris_dataset.jpg)
  * See code below to generate first plot
 
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
* ![simple_plot](https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/Simple_plot.jpeg)
* We see the axes we set up with Species on the x-axis and Sepal Width on the y-axis but _no data_
* We need to add a layer to tell R what we want to represent our data
* Let's try this...
```
ggplot(iris, aes(x=Species, y=Sepal.Width)) +
  geom_point()
```

* Now we have some datapoints, but they're not necessarily what we would want to see
* Let's try a boxplot
```
ggplot(iris, aes(x=Species, y=Sepal.Width)) +
  geom_boxplot()
```

---
## More resources
* [Quick how-to's for graphing](http://www.cookbook-r.com/Graphs/)
* [Growth curve plotting tutorial by Brian Connelley](http://bconnelly.net/2014/04/analyzing-microbial-growth-with-r/)
* Follow Hadley Wickham on twitter! [@hadleywickham](https://twitter.com/hadleywickham)
* [ggplot2 help topics](http://docs.ggplot2.org/current/index.html)
* [Amazing ggplot2 examples](http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html)
