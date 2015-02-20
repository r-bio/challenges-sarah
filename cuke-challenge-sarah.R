##
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

#5 
nom_subgenus <- nom[c("Genus.current", "Subgenus.current")]
nom_sub <- tapply(nom_subgenus$Subgenus.current, nom_subgenus$Genus.current, unique)
nom_sub
## This is most likely not an ideal way of doing this, but it did work. The answer is Holothuria.

#6
genus_species_hol <- paste(hol$dwc.genus, hol$dwc.specificEpithet)
head(genus_species_hol) #to check if worked
hol <- cbind(hol, genusspecies=genus_species_hol)
head(hol)

genus_species_nom <- paste(nom$Genus.current, nom$species.current)
head(genus_species_nom)
nom <- cbind(nom, genusspecies=genus_species_nom)
head(nom)

hol_nom <- merge(hol, nom, all.x = TRUE)

hol_invalid  <- subset(hol_nom, is.na(hol_nom$Status))
hol_invalid_onlyColumns <- hol_invalid [c("idigbio.uuid",
                                                "dwc.genus",
                                                "dwc.specificEpithet",
                                                "dwc.institutionCode",
                                                "dwc.catalogNumber")]

write.csv(hol_invalid_onlyColumns, "data/holothuriidae-invalid.csv")

