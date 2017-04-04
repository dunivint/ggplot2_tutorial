#much of this tutorial comes from Brian Connelly's tutorial
#(http://bconnelly.net/2014/04/analyzing-microbial-growth-with-r/)

library(reshape2)
library(dplyr)
library(ggplot2)

# Read in the raw data
rawdata <- read.csv("gc.rawdata.csv")

#read in platemap (created manually)
platemap <- read.csv("20160425_Platemap_High_MIC.csv")

#define well names
labels=c("Time", "A01", "A02", "A03", "A04", "A05", "A06", "A07", "A08", "A09", "A10", "A11", "A12", "B01", "B02", "B03", "B04", "B05", "B06", "B07", "B08", "B09", "B10", "B11", "B12", "C01", "C02", "C03", "C04", "C05", "C06", "C07", "C08", "C09", "C10", "C11", "C12", "D01", "D02", "D03", "D04", "D05", "D06", "D07", "D08", "D09", "D10", "D11", "D12", "E01", "E02", "E03", "E04", "E05", "E06", "E07", "E08", "E09", "E10", "E11", "E12", "F01", "F02", "F03", "F04", "F05", "F06", "F07", "F08", "F09", "F10", "F11", "F12", "G01", "G02", "G03", "G04", "G05", "G06", "G07", "G08", "G09", "G10", "G11", "G12", "H01", "H02", "H03", "H04", "H05", "H06", "H07", "H08", "H09", "H10", "H11", "H12")

#make well names column names
colnames(rawdata)=labels

#remove s from time column (this is probably unique to my gc output)
rawdata$Time=gsub('s', '', rawdata$Time)

# Tidy the data: move from wide (each well as a column)
# to long (one column with all wells)
reshaped <- melt(rawdata, id="Time", variable.name="Well",
                 value.name="OD590")

# Put plate map info next to each corresponding well
annotated <- inner_join(reshaped, platemap, by="Well")

#make OD590 a number
annotated$OD590=as.numeric(annotated$OD590)

#make time a number
annotated$Time=as.numeric(annotated$Time)

# Group the data by the different experimental variables and calculate the
# sample size, average OD590, and standard deviation around the mean.
stats=group_by(annotated, Strain, Concentration, Time) %>%
  summarise(N=length(OD590),
            Average=mean(OD590),
            SD=sd(OD590))

# Plot the average OD590 over time for each strain in each environment
ggplot(data=stats, aes(x=Time/3600, y=Average, color=Concentration, group=Concentration)) +
  geom_ribbon(aes(ymin=Average-SD, ymax=Average+SD, color=Concentration),
              color=NA, alpha=0.3) +
  geom_line(aes(color=Concentration)) +
  scale_color_gradientn(colours=rainbow(8)) +
  facet_wrap(~Strain, nrow=2) +
  labs(x="Time (Hours)", y="OD590")

##Let's start plotting from the beginning
#GC without faceting 
ggplot(data=stats, aes(x=Time, y=Average)) +
  geom_line() 

#faceting by arsenic concentration (grid v. wrap)
ggplot(data=stats, aes(x=Time, y=Average)) +
  geom_line() +
  facet_grid(~Concentration)

ggplot(data=stats, aes(x=Time, y=Average)) +
  geom_line() +
  facet_wrap(~Concentration)


#What if we facet by strain?
ggplot(data=stats, aes(x=Time, y=Average)) +
  geom_line() +
  facet_wrap(~Strain)

#add color to split variables further
ggplot(data=stats, aes(x=Time, y=Average, color=Strain)) +
  geom_line() +
  facet_wrap(~Concentration)

#try the same thing but facet by strain
ggplot(data=stats, aes(x=Time, y=Average, color=Concentration)) +
  geom_line() +
  facet_wrap(~Strain)

#For comparing concentrations, we need to group! 
#(think about our earlier groupings where we put
#strain ahead of concentration)
ggplot(data=stats, aes(x=Time, y=Average, color=Concentration, group=Concentration)) +
  geom_line() +
  facet_wrap(~Strain)

#improvements (color)
ggplot(data=stats, aes(x=Time, y=Average, color=Concentration, group=Concentration)) +
  geom_line() +
  facet_wrap(~Strain) +
  scale_color_gradientn(colours=rainbow(8)) 

#improvements (time)
ggplot(data=stats, aes(x=Time/3600, y=Average, color=Concentration, group=Concentration)) +
  geom_line() +
  facet_wrap(~Strain) +
  scale_color_gradientn(colours=rainbow(8)) 

#axes labels
ggplot(data=stats, aes(x=Time/3600, y=Average, color=Concentration, group=Concentration)) +
  geom_line() +
  facet_wrap(~Strain) +
  scale_color_gradientn(colours=rainbow(8)) +
  labs(x="Time (Hours)", y="OD590")

#errorbars
ggplot(data=stats, aes(x=Time/3600, y=Average, color=Concentration, group=Concentration)) +
  geom_ribbon(aes(ymin=Average-SD, ymax=Average+SD), color=NA, alpha=0.2) +
  geom_line() +
  facet_wrap(~Strain) +
  scale_color_gradientn(colours=rainbow(8)) +
  labs(x="Time (Hours)", y="OD590")

#themes
ggplot(data=stats, aes(x=Time/3600, y=Average, color=Concentration, group=Concentration)) +
  geom_ribbon(aes(ymin=Average-SD, ymax=Average+SD), color=NA, alpha=0.2) +
  geom_line() +
  facet_wrap(~Strain) +
  scale_color_gradientn(colours=rainbow(8)) +
  labs(x="Time (Hours)", y="OD590") +
  theme_minimal()

#fonts in themes
ggplot(data=stats, aes(x=Time/3600, y=Average, color=Concentration, group=Concentration)) +
  geom_ribbon(aes(ymin=Average-SD, ymax=Average+SD), color=NA, alpha=0.2) +
  geom_line() +
  facet_wrap(~Strain) +
  scale_color_gradientn(colours=rainbow(8)) +
  labs(x="Time (Hours)", y="OD590") +
theme_minimal(base_size = 11, base_family = "serif")

#other types of error bars
ggplot(data=stats, aes(x=Time/3600, y=Average, group=Concentration)) +
  geom_errorbar(aes(ymin=Average-SD, ymax=Average+SD)) +
  geom_point(aes(color=Concentration)) +
  facet_wrap(~Strain) +
  scale_color_gradientn(colours=rainbow(8)) +
  labs(x="Time (Hours)", y="OD590") +
  xlim(0,10)
