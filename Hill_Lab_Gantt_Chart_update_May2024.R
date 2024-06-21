# Started out with instructions from https://rpubs.com/mramos/ganttchart

setwd(".")

# Download and install plotrix package
install.packages("plotrix")
# Load the package
library(plotrix)
library(RColorBrewer)

convert <- function(x) {
        x[is.na(x)] <- "2038/12"
        as.POSIXct(strptime(paste(x, "/01", sep = ""), format = "%Y/%m/%d"))
}

# People names and  dates from common cv. Priorities will be categories of student.
# 1=PI, 2=technician , 3=postdoc, 4=MSc , 5=PhD, 6=Undergrad

labname <- "YourLab"
estyear <- 2010
thisyear <- 2024
thismonth <- "06"
info <- read.csv("data.csv", header = TRUE, sep = ",", na.strings = c("", "NA"))
names <- info$Name
starts <- convert(info$Start)
ends <- convert(info$End)
priorities <- as.integer(info$Type)

gantt.info <- list(labels = names, starts = starts, ends = ends, priorities = priorities)


vgridlab <- seq(estyear, thisyear, by = 1)
vgridpos <- convert(paste(vgridlab, '/01', sep = ""))

colfunc <- colorRampPalette(c("#762a83", "#af8dc3", "#e7d4e8", "#d9f0d3", "#7fbf7b", "#1b7837"))

timeframe <- convert(c(paste(estyear-2, "/01", sep = ""), paste(thisyear, "/12", sep = "")))


# Plot and save your Gantt chart into PDF form
gantt.chart(gantt.info,
        taskcolors = colfunc(6),
        xlim = timeframe,
        main = sprintf("We are the %s (est. %s)", labname, estyear),
        priority.legend = FALSE,
        vgridpos = vgridpos,
        vgridlab = vgridlab,
        hgrid = FALSE,
        half.height = 0.4,
        cylindrical = FALSE,
        border.col = "black",
        priority.label = "Type",
        priority.extremes = c("PI", "Undergrad"),
        time.axis = 1,
)

# add a legend
legend("bottomleft", 
        c("PI", "Technician", "Postdoc/Research Associate", "MSc", "PhD", "Undergrad"), 
        fill = colfunc(6),
        inset = .05,
        y.intersp = 2.0,
)

# get first occurrence of each name and start position
firsts <- sapply(unique(names), function(x) which(names == x)[1])
starts <- starts[firsts]
names <- names[firsts]

for (i in 1:length(unique(names))) {
        text(as.integer(starts[i])-10000000, length(names)-i+1, names[i], cex=1, pos=2, offset=-1)
}

# print chart as pdf
# width <- (thisyear - estyear) %/% 2
# height <- length(unique(names)) %/% 1
dev.copy(pdf, file = sprintf("%s_GanttChart_%s_%s.pdf", labname, thisyear, thismonth), width = 16, height = 9)
dev.off()
