
# R and ggplot2 
## Overarching Goal  
Understand how to make graphs in R 

## Learning Objectives
* Understand benefits of using R/ ggplot2
* Navigate RStudio
* Learn how to tidy data for plotting
* Make and adjust graphs in ggplot2

## Table of contents
* [R and RStudio](https://github.com/dunivint/ggplot2_tutorial/blob/master/GSW_tutorial.md#r-and-rstudio)
* [ggplot2](https://github.com/dunivint/ggplot2_tutorial/blob/master/GSW_tutorial.md#ggplot2)
 * [The basics](https://github.com/dunivint/ggplot2_tutorial/blob/master/GSW_tutorial.md#the-basics)
 * [Data labeling](https://github.com/dunivint/ggplot2_tutorial/blob/master/GSW_tutorial.md#data-labeling)
 * [Faceting/Growth curves](https://github.com/dunivint/ggplot2_tutorial/blob/master/GSW_tutorial.md#facetinggrowth-curve-analysis)
 * [Statistics and other data adjustments](https://github.com/dunivint/ggplot2_tutorial/blob/master/GSW_tutorial.md#statistics-and-other-data-adjustments)
* [More resources](https://github.com/dunivint/ggplot2_tutorial/blob/master/GSW_tutorial.md#more-resources)
## Getting started
* Downloads
  * [R](https://www.r-project.org/)
  * [RStudio](https://www.rstudio.com/products/rstudio/)
  
---

## R and RStudio
* RStudio is a user interface for R which makes coding simpler and plot visualization easier
* Image (below) shows RStudio interface
<img src="https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/RStudio_diagram.jpg" height="300" width="500">

* Top left: Markdown
  * Always write/ work in this section
  * Run code from this section (code is sent to console) 
  * Easy to adjust and save scripts

* Bottom left: Console
  * Where code is run/ calculations take place
  * Shows errors, outputs, etc
  * Code _can_ be typed here (but this makes corrections/ data-keeping more difficult) 

* Top right: Environment/ history
  * Environment: Shows objects you have created 
  * History: Shows your coding history

* Bottom right:
  * Files: Your working directory (what folder you're in on your own computer) 
  * Plot: view, export plots
  * Packages: all your stored packages and which are active (checked)
  * Help: shows manuals for all R packages

* R has many packages useful for Biologists
  
  __1. Data tidying__
   - [tidyr](https://cran.r-project.org/web/packages/tidyr/tidyr.pdf)
   - plyr and [dplyr](https://cran.r-project.org/web/packages/dplyr/dplyr.pdf)
   - reshape and [reshape2](https://cran.r-project.org/web/packages/reshape2/reshape2.pdf)
   
  __2. Phylogenetic trees__
   - [ape](https://cran.r-project.org/web/packages/ape/ape.pdf): phylogenetic analysis, general
   - [phytools](https://cran.r-project.org/web/packages/phytools/phytools.pdf): phylogenetic analysis, general
   - [geiger](https://cran.r-project.org/web/packages/geiger/geiger.pdf): fitting macroevolutionary models to phylo trees
   - [ggtree](https://bioconductor.org/packages/devel/bioc/manuals/ggtree/man/ggtree.pdf): visualizing phylogenetic trees
   
  __3. Growth curve analysis__
   - [Grofit](https://cran.r-project.org/web/packages/grofit/grofit.pdf): fit growth curves, calculate growth parameters
   - [nlme](https://cran.r-project.org/web/packages/nlme/nlme.pdf): fit and compare Gaussian linear and nonlinear mixed-effects models
   
  __4. Statistics__
   - [stats](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/00Index.html): so many statistics! (correlations, clustering, t tests, anova, standard deviation, and more)
   - [psych](https://cran.r-project.org/web/packages/psych/psych.pdf): psychological tests but also correlations
   - [vegan](https://cran.r-project.org/web/packages/vegan/vegan.pdf): ordinations, diversity analysis
   - [pvclust](https://cran.r-project.org/web/packages/pvclust/pvclust.pdf): Hierarchical clustering
   
  __5. Microarray/ dif gene expression analysis__
   - [Affy](https://www.bioconductor.org/packages/devel/bioc/manuals/affy/man/affy.pdf): analysis of affy microarrays
   - [limma](https://www.bioconductor.org/packages/devel/bioc/manuals/limma/man/limma.pdf): linear models/ microarray analysis
   - [oligo](https://www.bioconductor.org/packages/devel/bioc/manuals/oligo/man/oligo.pdf): another array analysis tool
   - [annotate](https://www.bioconductor.org/packages/devel/bioc/manuals/annotate/man/annotate.pdf): annotation
   
  __6. And so much more!__
   - [survival](https://cran.r-project.org/web/packages/survival/survival.pdf): Survival analysis
   - [qpcR](https://cran.r-project.org/web/packages/qpcR/qpcR.pdf): qPCR analysis
   - [Other available packages](https://cran.r-project.org/web/packages/available_packages_by_name.html#available-packages-B)

  
 * To install a package, there is a simple function
  ```
  install.packages("packagename")
  ```
 * Just because a package is installed does not mean it is active. To activate...
 ```
 library(packagename)
 ```

## Tidy data
Tidy data is a specific data format that helps to distinguish between variables and observations. Tidy data is easy to manipulate for data visualization/ analysis. Tidy data is the current compilation of years of data tidying study. For more information on its history and applications, see [Tidy data](http://vita.had.co.nz/papers/tidy-data.pdf) by Hadley Wickham, creator of ggplot2.

* Datasets start off in any format, but a clean or "tidy" dataset has only one style 
* Variables => columns
  * identity variables (ex: well A1 on a 96 well plate, time)
  * measured variables (ex: optical density) 
* Observations => rows
  * the complete information from one sample 
  * considers all identity and measured variables together
  * example: OD of well A1 at time 0
* The image below shows the difference between messy and tidy data (modified from [Tidy data](http://vita.had.co.nz/papers/tidy-data.pdf))
  <img src="https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/datatypes.png" height="200">
* Tidy data is in "long" format rather than "wide"
* Here is a quick example of data tidying in R
  * For this tutorial we will use the Iris dataset (comes with the R "datasets" package)
    * 150 flowers
    * 3 types of Irises
    * Sepal Length, Sepal Width, Petal Length and Petal Width for each Iris type
    * A snapshot of the dataset is shown below
    * <img src="https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/Iris_dataset.jpg" height="500">

First we will install the required packages. Reshape2 will be used to tidy the data. We will use datasets to get an example dataset (Iris). 
```
#installed the required packates
install.packages("reshape2")
install.packages("datasets")

#load required packages
library(reshape2)
library(datasets)
```
Now that we have our required packages, we will read in our data. Note: R can read many data types (.csv, .delim, .txt); the read functions are all very similar (```read.csv```, ```read.delim```, ```read.table```)
```
#read in data (here we will use a dataset from R datasets)
data=read.delim(iris)

#visualize the data (head shows first several rows in dataset; print would show whole dataset; tail shows bottom rows)
head(data)
```
We can see here that our data is currently wide, not long. We have multiple measured variables in separate columns. We can change that with the ```melt()``` function. 
    * we will call on melt by saying ```melt()```
    * within the parentheses, we will specify the data first then add more information. If you are unsure about what to add, the tab key will bring up what typically goes inside that function. Here we will specify id.vars (what variable is our sample ID), variable.name (what you want to call your variable), and value.name (the name of your measured variable) ```id.vars="Species", variable.name = "Identity", value.name="Size")```
```
#tidy the data using melt
tidydata=melt(data, id.vars="Species", variable.name = "Identity", value.name="Size")

#visualize the differences in the data
head(tidydata)
```
Now our data is tidy (long)! Note: tidying data can get more complicated with messier datasets which is why packages such as dplyr exist. Reshape2 can also work with more complex (semi-clean) datasets. For example, if you had more than one identity variable (such as species and treatment), you could incorporate that as follows: ```tidydata=melt(data, id.vars=c("Species", "Treatment"), variable.name = "Identity", value.name="Size")```

Now that we know the basics of tidy data, lets get to plotting!


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


We all probably use bar plots a lot. To make them in R we use ```geom_bar()```, but there is one extra step here. ```geom_bar()``` is actually a count function which will give a bar graph with count on the y-axis. If we want the bars to represent a measured y-value, we have to specify ```stat="identity"```

```
ggplot(iris, aes(x=Species, y=Sepal.Width)) +
  geom_bar(stat="identity")
```
* <img src="https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/bar.jpeg" height="300">

What if we wanted to make a boxplot that included individual datapoints? We can add another layer. We will use ```geom_jitter()``` rather than ```geom_point()``` because we want to spread out the data

```
ggplot(iris, aes(x=Species, y=Sepal.Width)) +
  geom_boxplot() + 
  geom_jitter()
```
* <img src="https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/boxdot.jpeg" height="300">


* Hopefully now you get the point of how easy it is to plot your data in different ways in ggplot2! 

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
* We can also label them with shapes! See more about shape options [here](http://sape.inf.usi.ch/quick-reference/ggplot2/shape)
```
ggplot(iris, aes(x=Sepal.Width, y=Sepal.Length, shape=Species)) +
  geom_point()
```

### Faceting/Growth curve analysis
Credit where credit is due: a lot of my growth curve analysis comes from [Brian Connelly](http://bconnelly.net/)
In this tutorial we will use some of my gc data from multiple different strains with multiple different arsenic treatments
 * The .R script can be found in this repository along with raw data and my platemap
First we will read and tidy growth curve data
* Most growth curve outputs will allow time in one column and well in every other column, so we will use this as an example
 * Most can also be exported as .csv
 * If you can only export into excel, excel can convert to .csv files easily
* We will include an information file that contains info per well
 * I usually make this by hand
 * Each row has all metadata for a single well
 
 ```
library(reshape2)
library(dplyr)
library(ggplot2)

# Read in the raw data and the platemap. You may need to first change your
# working directory with the setwd command.
rawdata <- read.csv("gc.rawdata.csv")

#read in platemap (created manually)
platemap <- read.csv("20160425_Platemap_High_MIC.csv")

#define well names
labels=c("Time", "A01", "A02", "A03", "A04", "A05", "A06", "A07", "A08", "A09", "A10", "A11", "A12", "B01", "B02", "B03", "B04", "B05", "B06", "B07", "B08", "B09", "B10", "B11", "B12", "C01", "C02", "C03", "C04", "C05", "C06", "C07", "C08", "C09", "C10", "C11", "C12", "D01", "D02", "D03", "D04", "D05", "D06", "D07", "D08", "D09", "D10", "D11", "D12", "E01", "E02", "E03", "E04", "E05", "E06", "E07", "E08", "E09", "E10", "E11", "E12", "F01", "F02", "F03", "F04", "F05", "F06", "F07", "F08", "F09", "F10", "F11", "F12", "G01", "G02", "G03", "G04", "G05", "G06", "G07", "G08", "G09", "G10", "G11", "G12", "H01", "H02", "H03", "H04", "H05", "H06", "H07", "H08", "H09", "H10", "H11", "H12")

#make well names column names
colnames(rawdata)=labels

#remove s from time column
rawdata$Time=gsub('s', '', rawdata$Time)

# Reshape the data. Instead of rows containing the Time, Temperature,
# and readings for each Well, rows will contain the Time, Temperature, a
# Well ID, and the reading at that Well.
reshaped <- melt(rawdata, id="Time", variable.name="Well",
                 value.name="OD590")

# Add information about the experiment from the plate map. For each Well
# defined in both the reshaped data and the platemap, each resulting row
# will contain the absorbance measurement as well as the additional columns
# and values from the platemap.
annotated <- inner_join(reshaped, platemap, by="Well")

#write function to give confidence intervals
conf_int95 <- function(data) {
  n <- length(data)
  error <- qt(0.975, df=n-1) * sd(data)/sqrt(n)
  return(error)
}

#make OD590 a number
annotated$OD590=as.numeric(annotated$OD590)

#make time a number
annotated$time=as.numeric(annotated$Time)

# Group the data by the different experimental variables and calculate the
# sample size, average OD600, and standard deviation around the mean.
  group_by(Strain, Concentration, time) %>%
  summarise(N=length(OD590),
            Average=mean(OD590),
            SD=sd(OD590))
            
# Plot the average OD600 over time for each strain in each environment
ggplot(data=stats, aes(x=time/3600, y=Average, color=Concentration, group=Concentration)) +
  geom_ribbon(aes(ymin=Average-SD, ymax=Average+SD, color=Concentration),
              color=NA, alpha=0.3) +
  geom_line(aes(color=Concentration)) +
  scale_color_gradientn(colours=rainbow(8)) +
  facet_wrap(~Strain, nrow=2) +
  labs(x="Time (Hours)", y="Optical Density 590 nm")
```
A quick note on errorbars: above we use geom_ribbon to get a smooth errorbar, but R has a neat function ```geom_errorbar()``` which will give typical errorbars. See below 

```
ggplot(data=stats, aes(x=time/3600, y=Average, group=Concentration)) +
     geom_errorbar(aes(ymin=Average-SD, ymax=Average+SD), size=0.1) +
     geom_point(aes(color=Concentration)) +
     scale_color_gradientn(colours=rainbow(8)) +
     facet_wrap(~Strain, nrow=2) +
     labs(x="Time (Hours)", y="Optical Density 590 nm")
```

### Statistics and other data adjustments
* First we'll look at statistical transformations... like histograms
* R will do the calculations from our original iris dataset, so we don't need to speciy a y value
* Lets look at sepal width counts in the dataset
```
ggplot(iris, aes(x=Sepal.Width)) +
  geom_histogram()
```
 <img src="https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/histo.jpeg" height="300">


* We can do more with this by selecting our binwidth
```
ggplot(iris, aes(x=Sepal.Width)) +
  geom_histogram(binwidth=0.2)
```
* Below are two images with only binwidth changed from 0.2 and 0.02
 <img src="https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/bins.jpg" height="300">


* We know that there are three types of flowers in these sepal width counts... how do we visualize those?
 * We can use ```fill``` which is an aesthetic, so it will go in the () of ```aes()```
 * Fill gives the inside color; color gives the outside color
```
ggplot(iris, aes(x=Sepal.Width, fill=Species)) +
  geom_histogram(binwidth=0.2)
```
 <img src="https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/histo.color.jpeg" height="300">


 * What if we wanted to add black around each color so it's easier to see separations. Let's use ```color```
 * We will add ```color``` to the ```geom_histogram``` since that is what we want to outline in black
```
ggplot(iris, aes(x=Sepal.Width, fill=Species)) +
  geom_histogram(binwidth=0.2, color="black")
```
 <img src="https://github.com/dunivint/ggplot2_tutorial/blob/master/Images/histo.black.color.jpeg" height="300">


---
## More resources
* [Quick how-to's for graphing](http://www.cookbook-r.com/Graphs/)
* [Growth curve plotting tutorial by Brian Connelley](http://bconnelly.net/2014/04/analyzing-microbial-growth-with-r/)
* Follow Hadley Wickham on twitter! [@hadleywickham](https://twitter.com/hadleywickham)
* [ggplot2 help topics](http://docs.ggplot2.org/current/index.html)
* [Amazing ggplot2 examples](http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html)
* [Tutorials with R data](https://www.mailman.columbia.edu/sites/default/files/media/fdawg_ggplot2.html)
* [Coloring ggplot2 graphs](http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/)
