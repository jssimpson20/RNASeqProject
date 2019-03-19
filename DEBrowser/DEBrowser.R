# Installation instructions:
# 1. Install DEBrowser and its dependencies by running the lines below
# in R or RStudio.

if (!requireNamespace("BiocManager", quietly=TRUE))
  install.packages("BiocManager")
BiocManager::install("debrowser")

# 2. Load the library

library(debrowser)

if (!require("tidyverse")) install.packages("tidyverse"); library(tidyverse)

genefilelist <- list.files(path="SARTools", pattern="*.genes.tsv", full.names=T)
print(genefilelist)
genefiles <- lapply(genefilelist, read_tsv)

samplenames <- gsub("SARTools/S2_DRSC_CG8144_", "", genefilelist)
samplenames <- gsub("SARTools/S2_DRSC_","", samplenames)
samplenames <- gsub(".genes.tsv", "", samplenames)
samplenames <- gsub("-","_", samplenames) # DEBrowser doesn't like -
samplenames

genefiles
genefiles %>%
  bind_cols() %>%
  select(Name, starts_with("NumReads")) -> genetable

colnames(genetable)[2:7] <- as.list(samplenames)

head(genetable)
write_tsv(genetable, path="genetable.tsv")



# 3. Start DEBrowser

startDEBrowser()
