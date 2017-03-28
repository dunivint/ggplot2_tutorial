
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
<img src="https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/RStudio_diagram.jpg" height="300" width="500">


[tidy_data](http://vita.had.co.nz/papers/tidy-data.pdf)


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
    * position adjustments
    * faceting
 
### The basics
  * For this tutorial we will use the Iris dataset (comes with the R "datasets" package)
    * 150 flowers
    * 3 types of Irises
    * Sepal Length, Sepal Width, Petal Length and Petal Width for each Iris type
    * A snapshot of the dataset is shown below
    * <img src="https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/Iris_dataset.jpg" height="500">
  * Here are the basic steps
    * we will call on ggplot2 by saying ```ggplot2()```
    * within the parentheses, we will specify the data first then add a comma then add basic aesthetics (x=, y=) ```ggplot2(data, aes(x= xname, y=yname))```
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
* <img src="https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/Simple_plot.jpeg" height="300">
* We see the axes we set up with Species on the x-axis and Sepal Width on the y-axis but _no data_
* We need to add a layer to tell R what we want to represent our data
  * This layer is "geom"
  * To call on geom, we will add a line to our original code (```ggplot(data, aes(x=xname, y=yname))```)
  * There are all kinds of geometric objects in R. To explore, start typing ```geom``` in RStudio and hit tab. R will give a list of possibilities
  * If you are using the same x and y you described in ```aes()```, you can leave the ```()``` blank
* Let's try some geometric objects...
```
ggplot(iris, aes(x=Species, y=Sepal.Width)) +
  geom_point()
```
* <img src="https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/simple_point.jpeg" height="300">

* Now we have some datapoints, but they're not necessarily what we would want to see. What if datapoints are overlapping?
```
ggplot(iris, aes(x=Species, y=Sepal.Width)) +
  geom_count()
```
* <img src="https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/simple_count.jpeg" height="300">

* Here we get a better picture of where the points are, but a boxplot might still be better to visualize the data
```
ggplot(iris, aes(x=Species, y=Sepal.Width)) +
  geom_boxplot()
```
* <img src="https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/simple_boxplot.jpeg" height="300">

* R calculates all of the information required for boxplots for you! Woo!
* Perhaps you prefer to see probability distributions through violin plots
```
ggplot(iris, aes(x=Species, y=Sepal.Width)) +
  geom_violin()
```
* <img src="https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/simple_violin.jpeg" height="300">

* Hopefully now you get the point of how easy it is to plot your data in different ways in ggplot2! 


### Statistics and other data adjustments
* First we'll look at statistical transformations... like histograms
* R will do the calculations from our original iris dataset, so we don't need to speciy a y value
* Lets look at sepal width counts in the dataset
```
ggplot(iris, aes(x=Sepal.Width)) +
  geom_histogram()
```
![histo](https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/histo.jpeg)

* We can do more with this by selecting our binwidth
```
ggplot(iris, aes(x=Sepal.Width)) +
  geom_histogram(binwidth=0.2)
```
* Below are two images with only binwidth changed from 0.2 and 0.02
![bins](https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/bins.jpg)

* We know that there are three types of flowers in these sepal width counts... how do we visualize those?
 * We can use ```fill``` which is an aesthetic, so it will go in the () of ```aes()```
 * Fill gives the inside color; color gives the outside color
```
ggplot(iris, aes(x=Sepal.Width, fill=Species)) +
  geom_histogram(binwidth=0.2)
```
![histo_color](https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/histo.color.jpeg)

 * What if we wanted to add black around each color so it's easier to see separations. Let's use ```color```
 * We will add ```color``` to the ```geom_histogram``` since that is what we want to outline in black
```
ggplot(iris, aes(x=Sepal.Width, fill=Species)) +
  geom_histogram(binwidth=0.2, color="black")
```
![histo_colorblack](https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/histo.black.color.jpeg)

### Data labeling
* Lets start thinking about sepal length and sepal width
```
ggplot(iris, aes(x=Sepal.Width, y=Sepal.Length, color=Species)) +
  geom_point()
```
* BUT we have data for three separate flowers... we can fix this by labeling the flower types with color
```
ggplot(iris, aes(x=Sepal.Width, y=Sepal.Length, color=Species)) +
  geom_point()
```
* We can also label them with shapes!
```
ggplot(iris, aes(x=Sepal.Width, y=Sepal.Length, shape=Species)) +
  geom_point()
```
---
## More resources
* [Quick how-to's for graphing](http://www.cookbook-r.com/Graphs/)
* [Growth curve plotting tutorial by Brian Connelley](http://bconnelly.net/2014/04/analyzing-microbial-growth-with-r/)
* Follow Hadley Wickham on twitter! [@hadleywickham](https://twitter.com/hadleywickham)
* [ggplot2 help topics](http://docs.ggplot2.org/current/index.html)
* [Amazing ggplot2 examples](http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html)
* [Tutorials with R data](https://www.mailman.columbia.edu/sites/default/files/media/fdawg_ggplot2.html)
