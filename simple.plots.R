#make sure you installed the required packates
install.packages("ggplot2")
install.packages("datasets")

#load required packages
library(ggplot2)
library(datasets)

#read in data (here we will use a dataset from R datasets)
data=data.frame(iris)

#tidy the data using melt
tidydata=melt(data, id.vars="Species", variable.name = "Identity", value.name="Size")

#let's make an easy plot
ggplot(iris, aes(x=Species, y=Sepal.Width))

##add data points
#add simple data points
ggplot(iris, aes(x=Species, y=Sepal.Width)) +
  geom_point()

#try geom_count
ggplot(iris, aes(x=Species, y=Sepal.Width)) +
  geom_count()

#make boxplot
ggplot(iris, aes(x=Species, y=Sepal.Width)) +
  geom_boxplot()

#make violin plot
ggplot(iris, aes(x=Species, y=Sepal.Width)) +
  geom_violin()

#bar graph
ggplot(iris, aes(x=Species, y=Sepal.Width)) +
  geom_bar(stat="identity")

#add a jitter layer
ggplot(iris, aes(x=Species, y=Sepal.Width)) +
  geom_boxplot() + 
  geom_jitter()

##data labeling
#start thinking about sepal length and width
ggplot(iris, aes(x=Sepal.Width, y=Sepal.Length)) +
  geom_point()

#but we know these points are from different flower species: let's label them
ggplot(iris, aes(x=Sepal.Width, y=Sepal.Length, color=Species)) +
  geom_point()

#We could label with shapes too
ggplot(iris, aes(x=Sepal.Width, y=Sepal.Length, shape=Species)) +
  geom_point()

#or both!
ggplot(iris, aes(x=Sepal.Width, y=Sepal.Length, shape=Species, color=Species)) +
  geom_point()

###TIDY DATA ex 
#tidy iris dataset
ggplot(tidydata, aes(x=Species, y=Size, fill=Identity)) +
  geom_boxplot() 

#geombar stacked
ggplot(tidydata, aes(x=Species, y=Size, fill=Identity)) +
  geom_bar(stat="identity")

#geombar separate
ggplot(tidydata, aes(x=Species, y=Size, fill=Identity)) +
  geom_bar(stat="identity", position="dodge")

