library(tidyverse)
library(readxl)
library(Rcpp)
library(readxl)
library(writexl)
library(tidyverse)
library(dplyr)
library(purrr)
library(xlsx)
library(svDialogs)
library(stringr)
library(tibble)
library(stringdist)


# Path to One Drive
# origin <- "C:/Users/hughm/OneDrive - VUMC/"
origin <- "/Users/gizem/Library/CloudStorage/OneDrive-VUMC/"

# Participant ID
participant <- c("CI000")

# Testing Session
# date <- c("preop")
# date <- c("1 mo")
# date <- c("3 mo")
date <- c("6 mo")
# date <- c("12 mo")

# Calendar date (ie. mm.dd.yyyy)
calDate <- "09.05.2024"



# Make each variable T if you want to run this script for it and F if you do not
# Vowel Task
Vowel <- T

# Consonant Task
Consonant <- T

# Prepare the MLST Task for scoring
MLST <- T

# Convert the nonword audio files into wav files
# MLST_Convert_Audio <- T

# Prepare the Nonword Task for scoring
Nonword <- T

# Convert the nonword audio files into wav files
# Nonword_Convert_Audio <- T

# Talker Discrimination Task
Talker_Discrimination <- T

# Lexical Decision
Lexical_Decision <- T
# Sentence Verification Task
SVT <- T

# Ravens Task
Ravens <- T

# Rhyme Judgment Task
Rhyme_Judgment <- T

# Semantic Priming Task
Semantic_Priming <- T

# Retroactive Priming Task
Retroactive_Priming <- T

# Preparing the CVC task for scoring
CVC <- T

# Preparing the HS task for scoring
HS <- T

# Preparing the HA task for scoring
HA <- T

# Preparing the PRESTO Task for scoring
PRESTO <- T

# Inquisit Tasks
Inquisit <- T



















setwd("C:/Users/hughm/OneDrive - VUMC/General/R01+R21 Outcomes Studies/Analysis/Code/R01R21 Scripts/Combined Scripts/Functions")
source("Lexical_Decision_Func.R")
source("Consonant_Func.R")
source("Vowel_Func.R")
source("Rhyme_Judgement_Func.R")
source("CVC_Func.R")
source("HS_Func.R")
source("HA_Func.R")
source("Inquisit_Func.R")
source("Talker_Discrimination_Func.R")
source("SVT_Func.R")
source("Semantic_Priming_Func.R")
source("Ravens_Func.R")
source("PRESTO_Func.R")
source("Nonword_Func.R")
source("Nonword_Convert_Audio_Func.R")
source("MLST_Func.R")
source("MLST_Convert_Audio_Func.R")
source("Retroactive_Priming_Func.R")


if(Vowel){
  Vowel_Func(participant,date,calDate,origin)
}
if(Consonant){
  Consonant_Func(participant,date,calDate,origin)
}
if(MLST){
  MLST_Func(participant,date,calDate,origin)
}
if(MLST_Convert_Audio){
  MLST_Convert_Audio_Func(participant,date,calDate,origin)
}
if(Nonword){
  Nonword_Func(participant,date,calDate,origin)
}
if(Nonword_Convert_Audio){
  Nonword_Convert_Audio_Func(participant,date,calDate,origin)
}
if(Talker_Discrimination){
  Talker_Discrimination_Func(participant,date,calDate,origin)
}
if(Lexical_Decision){
  Lexical_Decision_Func(participant,date,calDate,origin)
}
if(SVT){
  SVT_Func(participant,date,calDate,origin)
}
if(Ravens){
  Ravens_Func(participant,date,calDate,origin)
}
if(Rhyme_Judgment){
  Rhyme_Judgement_Func(participant,date,calDate,origin)
}
if(Semantic_Priming){
  Semantic_Priming_Func(participant,date,calDate,origin)
}
if(Retroactive_Priming){
  Retroactive_Priming_Func(participant,date,calDate,origin)
}
if(CVC){
  CVC_Func(participant,date,calDate,origin)
}
if(HS){
  HS_Func(participant,date,calDate,origin)
}
if(HA){
  HA_Func(participant,date,calDate,origin)
}
if(PRESTO){
  PRESTO_Func(participant,date,calDate,origin)
}
if(Inquisit){
  Inquisit_Func(participant,date,calDate,origin)
}
