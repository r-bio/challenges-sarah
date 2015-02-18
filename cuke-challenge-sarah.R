download.file("http://r-bio.github.io/data/holothuriidae-specimens.csv", "data/holothuriidae-specimens.csv")
download.file("http://r-bio.github.io/data/holothuriidae-nomina-valid.csv",
              "data/holothuriidae-nomina-valid.csv")
hol <- read.csv("data/holothuriidae-specimens.csv", stringsAsFactors=FALSE)
nom <- read.csv("data/holothuriidae-nomina-valid.csv", stringsAsFactors=FALSE)
## 1.) 
nrow(hol)
##2984

## 2.)
ins_code <- unique(hol$dwc.institutionCode)
length(ins_code)
##4

inst_plot <- factor(hol$dwc.institutionCode)
table(inst_plot)
barplot(table(inst_plot))

## 3.)
comp_hol_year <- hol[! is.na(hol$dwc.year), ]
comp_hol_year
min(comp_hol_year$dwc.year)
## 1... (1902...?)

hol_06to14 <- subset(hol, dwc.year == 2006:2014)
hol_06to14 ## 156
prod(156/2984) ## 0.05228

## 4.) 
hol_class <- nzchar(hol$dwc.class)
sum(hol_class == "FALSE")
## 50

hol_class_noFalse <- sub("", "Holothuridea", hol$dwc.class)
hol_class_noFalse
hol_class_noFalse_count <- nzchar(hol_class_noFalse)
sum(hol_class_noFalse_count == "FALSE") ## 0

#5 (to be completed soon)
#6 (to be completed soon)
