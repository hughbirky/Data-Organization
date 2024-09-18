library(tidyverse)
library(readxl)
library(Rcpp)
library(readxl)
library(writexl)
library(tidyverse)
library(dplyr)
library(plyr)
library(purrr)
library(xlsx)

shell("cls")
# shell("clear")
# Clearing the environment of previous variables
rm(list=ls()) 


right = "Digit Span"

# date <- c("preop")
date <- c("preop","1 mo","3 mo","6 mo","12 mo")
# date <- c("3 mo")
# date <- c("6 mo")
# date <- c("12 mo")


# Setting the path to the task oriented area
taskPath <- "C:/Users/hughm/OneDrive - VUMC/General/R01+R21 Outcomes Studies/Analysis/Scoring/Tasks Analysis"
analysis <- "C:/Users/hughm/OneDrive - VUMC/General/R01+R21 Outcomes Studies/Analysis/Scoring/Completed scoring"

# List of Tasks to be moved
# tasks <- c("/Matlab Tasks/Lexical")
# tasks <- c("/Matlab Tasks/Ravens")
# tasks <- c("/Matlab Tasks/Retro")
# tasks <- c("/Matlab Tasks/Rhyme")
# tasks <- c("/Matlab Tasks/Semantic")
# tasks <- c("/Matlab Tasks/Sentence")
# tasks <- c("/Matlab Tasks/CVC")
# tasks <- c("/Matlab Tasks/HA")
# tasks <- c("/Matlab Tasks/HS")
# tasks <- c("/Matlab Tasks/PRESTO")
# tasks <- c("/Gorilla Tasks/Consonant")
# tasks <- c("/Gorilla Tasks/Vowel")
# tasks <- c("/Gorilla Tasks/Nonword")
# tasks <- c("/Gorilla Tasks/Talker")
# tasks <- c("/Gorilla Tasks/MLST")
# tasks <- c("/Inquisit Tasks/Stroop")
# tasks <- c("/Inquisit Tasks/Digit")


tasky <- 1

# Getting rid of the folder for new oragnization style
# tasksAlone <- gsub(x = tasks[tasky],pattern = "/Matlab Tasks",replacement = "")
# tasksAlone <- gsub(x = tasksAlone,pattern = "/Gorilla Tasks",replacement = "")
# tasksAlone <- gsub(x = tasksAlone,pattern = "/Inquisit Tasks",replacement = "")

tasksAlone <- gsub(x = tasks[tasky],pattern = "/Matlab Tasks/",replacement = "")
tasksAlone <- gsub(x = tasksAlone,pattern = "/Gorilla Tasks/",replacement = "")
tasksAlone <- gsub(x = tasksAlone,pattern = "/Inquisit Tasks/",replacement = "")

# Pulling which kind of task this is
typeAlone <- gsub(".*\\/(.*)\\/.*", "\\1", tasks[tasky])





# Setting working directory to analysis
setwd(analysis)

# Getting a list of all of the files
participant = list.files(full.names = T)
# Getting rid of the ./
participant <- gsub(x = participant, pattern = "./", replacement = "")
# Getting the folder we need for the visit type
participant <- participant[grepl("2", participant)]

# Iterator to check if they have been added
i = 0

p = 1
# Iterating through all of the folders to make a list of what files are current
d = 5
for(p in 1:length(participant)) {
  for(d in 1:length(date)){
    # Writing new path including the participant folder
    analysis_part <- paste0(analysis,"/",participant[p])
    setwd(analysis_part)
  
  # Doing this for each date
  
    # Getting a list of all of the folders
    date_folder = list.files(full.names = T)
    # Getting rid of the ./
    date_folder <- gsub(x = date_folder, pattern = "./", replacement = "")
    # Getting the folder we need for the visit type
    date_folder <- date_folder[grepl(date[d], date_folder)]
    
    
    # Adding this folder to the path along with the task wanted
    analysis_part <- paste0(analysis_part,"/",date_folder,"/",typeAlone)
    if(!dir.exists(analysis_part)){
      next
    }
    
    setwd(analysis_part)
    
    # Finding what tasks have been done within the task type
    # Getting a list of all of the folders
    task_folder = list.files(full.names = T)
    # Getting rid of the ./
    task_folder <- gsub(x = task_folder, pattern = "./", replacement = "")
    # Getting the folder we need for the visit type
    task_folder <- task_folder[grepl(tasksAlone, task_folder)]
    
    # Checking that the folder does exist
    if(length(task_folder) != 0){
      final_analysis <- paste0(analysis_part,"/",task_folder)
      
      # Choosing if we want to rename
      if(right != ""){
        if(task_folder != right){
          file.rename(final_analysis,paste0(analysis_part,"/",right))
          final_analysis <- paste0(analysis_part,"/",right)
        }
      }
        
      # Checking if the directory exists before recording the path
      if(dir.exists(final_analysis)){
        # If this is the first path being added
        if(i == 0){
          # Adding the current path to our list
          total_tasks <- c(final_analysis)
          # Changing iterator
          i = 1
        } else {
          total_tasks <- c(total_tasks,final_analysis)
        }
      }
    }
  }
}

print(total_tasks)