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


# Participant ID
participant <- c("CI205")

# Testing Session
# date <- c("preop")
# date <- c("1 mo")
# date <- c("3 mo")
date <- c("6 mo")
# date <- c("12 mo")

# Calendar date (ie. mm.dd.yyyy)
calDate <- "08.06.2024"



# Make each variable T if you want to run this script for it and F if you do not
# Vowel Task
Vowel <- F
# Consonant Task
Consonant <- F
# Prepare the MLST Task for scoring
MLST <- F
# Convert the nonword audio files into wav files
MLST_Convert_Audio <- F
# Prepare the Nonword Task for scoring
Nonword <- F
# Convert the nonword audio files into wav files
Nonword_Convert_Audio <- F
# Talker Discrimination Task
Talker_Discrimination <- F
# Lexical Decision
Lexical_Decision <- F
# Sentence Verification Task
SVT <- F
# Ravens Task
Ravens <- F
# Rhyme Judgment Task
Rhyme_Judgment <- F
# Retroactive Priming Task
Retroactive_Priming <- F
# Semantic Priming Task
Semantic_Priming <- F
# Preparing the CVC task for scoring
CVC <- F
# Preparing the HS task for scoring
HS <- F
# Preparing the HA task for scoring
HA <- F
# Preparing the PRESTO Task for scoring
PRESTO <- F 
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


if(Lexical_Decision){
  Lexical_Decision_Func(participant,date,calDate)
}
if(Consonant){
  Consonant_Func(participant,date,calDate)
}
if(Vowel){
  Vowel_Func(participant,date,calDate)
}
if(Rhyme_Judgment){
  Rhyme_Judgement_Func(participant,date,calDate)
}
if(CVC){
  CVC_Func(participant,date,calDate)
}
if(HS){
  HS_Func(participant,date,calDate)
}
if(HA){
  HA_Func(participant,date,calDate)
}
if(Inquisit){
  Inquisit_Func(participant,date,calDate)
}
if(Talker_Discrimination){
  Talker_Discrimination_Func(participant,date,calDate)
}
if(SVT){
  SVT_Func(participant,date,calDate)
}
if(Semantic_Priming){
  Semantic_Priming_Func(participant,date,calDate)
}
if(Ravens){
  Ravens_Func(participant,date,calDate)
}
if(PRESTO){
  PRESTO_Func(participant,date,calDate)
}
if(Nonword){
  Nonword_Func(participant,date,calDate)
}
if(Nonword_Convert_Audio){
  Nonword_Convert_Audio_Func(participant,date,calDate)
}
if(MLST){
  MLST_Func(participant,date,calDate)
}
if(MLST_Convert_Audio){
  MLST_Convert_Audio_Func(participant,date,calDate)
}
if(Retroactive_Priming){
  Retroactive_Priming_Func(participant,date,calDate)
}