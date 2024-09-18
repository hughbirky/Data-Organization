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

right = ""

# date <- c("preop")
date <- c("preop","1 mo","3 mo","6 mo","12 mo")
# date <- c("1 mo")
# date <- c("3 mo")
# date <- c("6 mo")
# date <- c("12 mo")


# Setting the path to the task oriented area
taskPath <- "C:/Users/hughm/OneDrive - VUMC/General/R01+R21 Outcomes Studies/Analysis/Scoring/Tasks Analysis"
analysis <- "C:/Users/hughm/OneDrive - VUMC/General/R01+R21 Outcomes Studies/Analysis/Scoring/Completed scoring"

# List of Tasks to be moved
# tasks <- c("/Matlab Tasks/Lexical Decision")
tasks <- c("/Matlab Tasks/Ravens")
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

d = 1
# Iterating through all of the folders to make a list of what files are current
for(d in 1:length(date)){
  for(p in 1:length(participant)) {
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
        # Grabbing the files present in these folders\
        setwd(final_analysis)
        # Getting a list of all of the folders
        scored_files = list.files(full.names = T)
        # Getting rid of the ./
        scored_files <- gsub(x = scored_files, pattern = "./", replacement = "")

        for(s in 1:length(scored_files)){
          final <- paste0(final_analysis,"/",scored_files[s])

          # Checking if the file actually exists
          if(file.exists(final)){
            # If this is the first path being added
            if(i == 0){
              # Adding the current path to our list
              total_tasks_path <- c(final)
              total_files <- c(scored_files[s])
              # Changing iterator
              i = 1
            } else {
              total_tasks_path <- c(total_tasks_path,final)
              total_files <- c(total_files,scored_files[s])

            }
          }
        }
      }
    }
  }
  print(total_files)
  print(total_tasks_path)
  
  
  
  # Setting the working path for the task folder
  setwd(taskPath)
  # Getting a list of all of the files
  task_folder = list.files(full.names = T)
  # Getting rid of the ./
  task_folder <- gsub(x = task_folder, pattern = "./", replacement = "")
  # Getting the task folder
  tasksAlone <- task_folder[grepl(tasksAlone, task_folder)]
  # Getting the task we are working on
  taskPath2 <- paste0(taskPath,"/",tasksAlone)
  # Setting the working path for the task folder
  setwd(taskPath2)
  # Getting a list of all of the files
  task_folder = list.files(full.names = T)
  # Getting rid of the ./
  task_folder <- gsub(x = task_folder, pattern = "./", replacement = "")
  # Getting the folder we need for the participant[p]
  task_folder <- task_folder[grepl(date[d], task_folder)]
  # Writing our new path to the task
  taskPath3 <- paste0(taskPath2,"/",task_folder[1])
  
  
  
  # Setting the working directory to the taskPath
  setwd(taskPath3)
  # Getting a list of all of the excel files
  full_name = list.files(full.names = T)
  # Getting rid of the ./
  full_name <- gsub(x = full_name, pattern = "./", replacement = "")
  # Only getting the template name
  full_name <- full_name[grepl("Combined", full_name)]
  
  # Reading in the full file name
  full <- ""
  
  # Getting the rest of the files
  files_combined = list.files(full.names = T)
  # Getting rid of the ./
  files_combined <- gsub(x = files_combined, pattern = "./", replacement = "")
  # Excluding full combined
  files_combined <- files_combined[!grepl("Combined", files_combined)]
  files_combined <- files_combined[!grepl("Old", files_combined)]
  
  # Checking to see if we have copied into this folder so far
  if(length(files_combined)){
    # Clearing out the number of files we have scanned so we aren't recopying files
    for(c in 1:length(files_combined)){
      total_tasks_path <- total_tasks_path[!grepl(files_combined[c], total_tasks_path)]
      total_files <- total_files[!grepl(files_combined[c], total_files)]
    }
  }
  
  
  # Copying the files we don't have in there yet
  for(c in 1:length(total_tasks_path)){
    file.copy(total_tasks_path[c],paste0(taskPath3,"/",total_files[c]))
  }
  
  # Resetting the variables
  total_tasks_path <- c()
  total_files <- c()
}

