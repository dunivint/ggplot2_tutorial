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
stats=group_by(annotated, Strain, Concentration, time) %>%
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


#GC without faceting 
ggplot(data=stats, aes(x=time, y=Average)) +
  geom_line() 

#faceting by arsenic concentration (grid v. wrap)
ggplot(data=stats, aes(x=time, y=Average)) +
  geom_line() +
  facet_grid(~Concentration)

ggplot(data=stats, aes(x=time, y=Average)) +
  geom_line() +
  facet_wrap(~Concentration)


#faceting by arsenic concentration (try facet_wrap Concentration and strain)
ggplot(data=stats, aes(x=time, y=Average)) +
  geom_line() +
  facet_wrap(~Strain)

ggplot(data=stats, aes(x=time, y=Average)) +
  geom_line() +
  facet_wrap(~Concentration)

#add color to split variables further
ggplot(data=stats, aes(x=time/3600, y=Average, color=Strain)) +
  geom_line() +
  facet_wrap(~Concentration)

#add layer
ggplot(data=stats, aes(x=time, y=Average, color=Concentration)) +
  geom_line() +
  facet_wrap(~Strain)

#need to group!
ggplot(data=stats, aes(x=time, y=Average, color=Concentration, group=Concentration)) +
  geom_line() +
  facet_wrap(~Strain)

#improvements (color)
ggplot(data=stats, aes(x=time, y=Average, color=Concentration, group=Concentration)) +
  geom_line() +
  facet_wrap(~Strain) +
  scale_color_gradientn(colours=rainbow(8)) 

#improvements (time)
ggplot(data=stats, aes(x=time/3600, y=Average, color=Concentration, group=Concentration)) +
  geom_line() +
  facet_wrap(~Strain) +
  scale_color_gradientn(colours=rainbow(8)) 

#axes labels
ggplot(data=stats, aes(x=time/3600, y=Average, color=Concentration, group=Concentration)) +
  geom_line() +
  facet_wrap(~Strain) +
  scale_color_gradientn(colours=rainbow(8)) +
  labs(x="Time (Hours)", y="OD590")

#errorbars
ggplot(data=stats, aes(x=time/3600, y=Average, color=Concentration, group=Concentration)) +
  geom_ribbon(aes(ymin=Average-SD, ymax=Average+SD), color=NA, alpha=0.2) +
  geom_line() +
  facet_wrap(~Strain) +
  scale_color_gradientn(colours=rainbow(8)) +
  labs(x="Time (Hours)", y="OD590")

#themes
ggplot(data=stats, aes(x=time/3600, y=Average, color=Concentration, group=Concentration)) +
  geom_ribbon(aes(ymin=Average-SD, ymax=Average+SD), color=NA, alpha=0.2) +
  geom_line() +
  facet_wrap(~Strain) +
  scale_color_gradientn(colours=rainbow(8)) +
  labs(x="Time (Hours)", y="OD590") +
  theme_minimal()

#other types of error bars
ggplot(data=stats, aes(x=time/3600, y=Average, group=Concentration)) +
  geom_errorbar(aes(ymin=Average-SD, ymax=Average+SD)) +
  geom_point(aes(color=Concentration)) +
  facet_wrap(~Strain) +
  scale_color_gradientn(colours=rainbow(8)) +
  labs(x="Time (Hours)", y="OD590") +
  xlim(0,10) +
  theme_minimal(base_size = 11, base_family = "serif")

