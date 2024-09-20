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

date <- c("preop")
# date <- c("preop","1 mo","3 mo","6 mo","12 mo")
# date <- c("1 mo")
# date <- c("3 mo")
# date <- c("6 mo")
# date <- c("12 mo")


# Setting the path to the task oriented area
taskPath <- "C:/Users/hughm/OneDrive - VUMC/General/R01+R21 Outcomes Studies/Analysis/Scoring/Tasks Analysis"
analysis <- "C:/Users/hughm/OneDrive - VUMC/General/R01+R21 Outcomes Studies/Analysis/Scoring/Completed scoring"

# List of Tasks to be moved
# tasks <- c("/Matlab Tasks/Lexical Decision")
# tasks <- c("/Matlab Tasks/Ravens")
# tasks <- c("/Matlab Tasks/Retro")
# tasks <- c("/Matlab Tasks/Rhyme")
# tasks <- c("/Matlab Tasks/Semantic")
# tasks <- c("/Matlab Tasks/Sentence")
# tasks <- c("/Matlab Tasks/CVC")
# tasks <- c("/Matlab Tasks/HA")
# tasks <- c("/Matlab Tasks/HS")
tasks <- c("/Matlab Tasks/PRESTO")
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
  # Resetting the variables
  total_tasks_path <- c()
  total_files <- c()
  
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

    # Checking that the folder do es exist
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

        # Getting rid of the old folder
        scored_files <- scored_files[!grepl("Old", scored_files)]
        # Fixing HA error
        scored_files <- scored_files[!grepl("HA_List 2", scored_files)]
        
        # Moving unwanted files to Old
        if(any(grepl("V2",scored_files))){
          # Creating storage directory
          if(!dir.exists("Old")){
            dir.create("Old")
          }
          
          # Getting rid of the old folder
          scored_files2 <- scored_files[!grepl("V2", scored_files)]
          scored_files <- scored_files[grepl("V2", scored_files)]
          
          # Moving files
          for(s in 1:length(scored_files)){
            file.copy(scored_files2[s],paste0("Old/",scored_files2[s]))
            file.remove(scored_files2[s])
          }
          
        }
        
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
  tasksAlone2 <- task_folder[grepl(tasksAlone, task_folder)]
  # Getting the task we are working on
  taskPath2 <- paste0(taskPath,"/",tasksAlone2)
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


#$#######################################################################################################################
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




  # Changing the ones for Lists in CVC, HS, HA, PRESTO
  if(grepl("CVC",tasksAlone,ignore.case = FALSE) || grepl("HS",tasksAlone,ignore.case = FALSE) || grepl("HA",tasksAlone,ignore.case = FALSE) || grepl("PRESTO",tasksAlone,ignore.case = FALSE)){
    # Iterating through the files
    # Pulling the name of the list
    # list_check <- sub(".*List ([0-9]+).*", "\\1", total_tasks_path[1])
    if(grepl("List ",total_tasks_path[1])){
      list_check <- str_extract(total_tasks_path[1], "List\\s\\d+")
      list_check <- as.numeric(str_extract(list_check, "\\d+"))
    } else if(grepl("List",total_tasks_path[1])){
      # list_check <- sub(".*list([0-9]+).*", "\\1", total_tasks_path[1])
      list_check <- str_extract(total_tasks_path[1], "List\\d+")
      list_check <- as.numeric(str_extract(list_check, "\\d+"))
    } else if(grepl("list ",total_tasks_path[1])){
      # list_check <- sub(".*list([0-9]+).*", "\\1", total_tasks_path[1])
      list_check <- str_extract(total_tasks_path[1], "list\\s\\d+")
      list_check <- as.numeric(str_extract(list_check, "\\d+"))
    } else if(grepl("list",total_tasks_path[1])){
      # list_check <- sub(".*list([0-9]+).*", "\\1", total_tasks_path[1])
      list_check <- str_extract(total_tasks_path[1], "list\\d+")
      list_check <- as.numeric(str_extract(list_check, "\\d+"))
    }


    for(c in 1:length(total_tasks_path)){
      # Checking what list it is
      # Pulling the name of the list
      # list <- sub(".*List ([0-9]+).*", "\\1", total_tasks_path[c])
      if(grepl("List ",total_tasks_path[c])){
        list <- str_extract(total_tasks_path[c], "List\\s\\d+")
        list <- as.numeric(str_extract(list, "\\d+"))
      } else if(grepl("List",total_tasks_path[c])){
        # list <- sub(".*list([0-9]+).*", "\\1", total_tasks_path[c])
        list <- str_extract(total_tasks_path[c], "List\\d+")
        list <- as.numeric(str_extract(list, "\\d+"))
      } else if(grepl("list ",total_tasks_path[c])){
        # list <- sub(".*list([0-9]+).*", "\\1", total_tasks_path[c])
        list <- str_extract(total_tasks_path[c], "list\\s\\d+")
        list <- as.numeric(str_extract(list, "\\d+"))
      } else if(grepl("list",total_tasks_path[c])){
        # list <- sub(".*list([0-9]+).*", "\\1", total_tasks_path[c])
        list <- str_extract(total_tasks_path[c], "list\\d+")
        list <- as.numeric(str_extract(list, "\\d+"))
      }
      
      
      
      # Creating the list directory
      if(!dir.exists(paste0("List ",list))){
        dir.create(paste0("List ",list))
      }

#################################################################################################

      # Making the second path for the different list
      if(list != list_check){
        if(i != 1000){
          taskPath4 <- paste0(taskPath3,"/List ",list)
          i = 1000
        }

      }

      file.copy(total_tasks_path[c],paste0(taskPath3,"/List ",list,"/",total_files[c]))
    }

    # Making the new taskPath3 for the first list
    taskPath3 <- paste0(taskPath3,"/List ",list_check)
    setwd(taskPath3)


    # Combining the files


    # Getting a list of all of the excel files
    full_name = list.files(full.names = T)
    # Getting rid of the ./
    full_name <- gsub(x = full_name, pattern = "./", replacement = "")
    # Only getting the template name
    full_name <- full_name[grepl("Combined", full_name)]

    # Reading in the full file name
    full <- ""

    # Getting the rest of the files
    files = list.files(full.names = T)
    # Getting rid of the ./
    files <- gsub(x = files, pattern = "./", replacement = "")
    # Excluding full combined
    files <- files[!grepl("Combined", files)]
    files <- files[!grepl("Old", files)]
    files <- files[!grepl("NA", files)]
    # files <- files[!grepl("List", files)]


    i = 2
    if(grepl("Talker",tasks[tasky])){
      files <- files[grepl("Best_",files)]
    }

    for(i in 1:length(files)){
      # Reading the excel file
      scored <- read_excel(files[i])

      # Pulling the name of the participant
      participant2 <- str_extract(files[i],"CI2\\d{2}")

      scored <- cbind(ID = participant2, scored)










      # Renaming bad columns
      if("Acc 1 or 0" %in% colnames(scored)){
        scored <- scored %>%
          dplyr::rename("Correct" = "Acc 1 or 0")
      }
      if("X.TrialNumber" %in% colnames(scored)){
        scored <- scored %>%
          dplyr::rename("#TrialNumber" = "X.TrialNumber")
      }
      if("X..TrialWord1" %in% colnames(scored)){
        scored <- scored %>%
          dplyr::rename("# TrialWord1" = "X..TrialWord1")
      }
      if("Time..Seconds." %in% colnames(scored)){
        scored <- scored %>%
          dplyr::rename("Time (Seconds)" = "Time..Seconds.")
      }
      if("Presentation Number" %in% colnames(scored)){
        scored <- scored %>%
          dplyr::rename("Presentation Order" = "Presentation Number")
      }
      if("New Name" %in% colnames(scored)){
        scored <- scored %>%
          dplyr::rename("File" = "New Name")
      }
      if("talker" %in% colnames(scored)){
        scored <- scored %>%
          dplyr::rename("Talker" = "talker")
      }
      if("ANSWER" %in% colnames(scored)){
        scored <- scored %>%
          dplyr::rename("Answer" = "ANSWER")
      }
      if("c2 correct" %in% colnames(scored)){
        scored <- scored %>%
          dplyr::rename("C2 correct" = "c2 correct")
      }

      if("...2" %in% colnames(scored)){
        scored <- scored %>%
          dplyr::rename("File" = "...2")
      }
      if("Item Number" %in% colnames(scored)){
        scored <- scored %>%
          dplyr::rename("Item #" = "Item Number")
      }






      # Removing the REDCap column
      if("REDCap" %in% colnames(scored)){
        scored <- scored[,!names(scored) %in% "REDCap"]
      }
      # Removing the Scoring Logs column
      if("Scoring_Log" %in% colnames(scored)){
        scored <- scored[,!names(scored) %in% "Scoring_Log"]
      }
      # Removing the Scoring Logs column
      if("Scoring_Logs" %in% colnames(scored)){
        scored <- scored[,!names(scored) %in% "Scoring_Logs"]
      }
      # Removing the Scoring Logs column
      if("Scoring Logs" %in% colnames(scored)){
        scored <- scored[,!names(scored) %in% "Scoring Logs"]
      }
      # Removing the REDCap column
      if("Unknown" %in% colnames(scored)){
        scored <- scored[,!names(scored) %in% "Unknown"]
      }


      if(i == 1){
        full <- scored
      } else{

        # full <- bind_rows(full,map2_df(scored, map(full,class), ~{class(.x) <- .y;.x}))
        full <- rbind.fill(full,scored)
      }
    }

    # Doing this for CI in Talker disc
    if(grepl("Talker",tasks[tasky])){
      # Getting the rest of the files
      files = list.files(full.names = T)
      # Getting rid of the ./
      files <- gsub(x = files, pattern = "./", replacement = "")
      # Excluding full combined
      files <- files[!grepl("Combined", files)]
      files <- files[!grepl("Old", files)]

      full2 <- ""
      files <- files[grepl("CI_",files)]
      if(length(files) > 0){
        for(i in 1:length(files)){
          scored <- read_excel(files[i])
          if(i == 1){
            full2 <- scored
          } else{
            # full2 <- bind_rows(full2,map2_df(scored, map(full2,class), ~{class(.x) <- .y;.x}))
            full2 <- rbind.fill(full2,scored)

          }
        }
        write.xlsx(full2,"Combined_CI_Only_Scoring.xlsx",showNA = F)
      }
    }

    # Export excel data
    write.xlsx(full,paste0("Combined_Scoring_",tasksAlone,"_",date[d],".xlsx"),showNA = F)

    # Changing the directory
    taskPath3 <- taskPath4
    setwd(taskPath3)


  } else {
    # Copying the files we don't have in there yet
    for(c in 1:length(total_tasks_path)){
      file.copy(total_tasks_path[c],paste0(taskPath3,"/",total_files[c]))
    }
  }





  # Combining the files


  # Getting a list of all of the excel files
  full_name = list.files(full.names = T)
  # Getting rid of the ./
  full_name <- gsub(x = full_name, pattern = "./", replacement = "")
  # Only getting the template name
  full_name <- full_name[grepl("Combined", full_name)]

  # Reading in the full file name
  full <- ""

  # Getting the rest of the files
  files = list.files(full.names = T)
  # Getting rid of the ./
  files <- gsub(x = files, pattern = "./", replacement = "")
  # Excluding full combined
  files <- files[!grepl("Combined", files)]
  files <- files[!grepl("Old", files)]
  files <- files[!grepl("NA", files)]
  files <- files[!grepl("NA", files)]


  i = 2
  if(grepl("Talker",tasks[tasky])){
    files <- files[grepl("Best_",files)]
  }

  for(i in 1:length(files)){
    # Reading the excel file
    scored <- read_excel(files[i])

    # Pulling the name of the participant
    participant2 <- str_extract(files[i],"CI2\\d{2}")

    scored <- cbind(ID = participant2, scored)










    # Renaming bad columns
    if("Acc 1 or 0" %in% colnames(scored)){
      scored <- scored %>%
        dplyr::rename("Correct" = "Acc 1 or 0")
    }
    if("X.TrialNumber" %in% colnames(scored)){
      scored <- scored %>%
        dplyr::rename("#TrialNumber" = "X.TrialNumber")
    }
    if("X..TrialWord1" %in% colnames(scored)){
      scored <- scored %>%
        dplyr::rename("# TrialWord1" = "X..TrialWord1")
    }
    if("Time..Seconds." %in% colnames(scored)){
      scored <- scored %>%
        dplyr::rename("Time (Seconds)" = "Time..Seconds.")
    }
    if("Presentation Number" %in% colnames(scored)){
      scored <- scored %>%
        dplyr::rename("Presentation Order" = "Presentation Number")
    }
    if("New Name" %in% colnames(scored)){
      scored <- scored %>%
        dplyr::rename("File" = "New Name")
    }
    if("talker" %in% colnames(scored)){
      scored <- scored %>%
        dplyr::rename("Talker" = "talker")
    }
    if("ANSWER" %in% colnames(scored)){
      scored <- scored %>%
        dplyr::rename("Answer" = "ANSWER")
    }
    if("c2 correct" %in% colnames(scored)){
      scored <- scored %>%
        dplyr::rename("C2 correct" = "c2 correct")
    }








    # Removing the REDCap column
    if("REDCap" %in% colnames(scored)){
      scored <- scored[,!names(scored) %in% "REDCap"]
    }
    # Removing the Scoring Logs column
    if("Scoring_Log" %in% colnames(scored)){
      scored <- scored[,!names(scored) %in% "Scoring_Log"]
    }
    # Removing the Scoring Logs column
    if("Scoring_Logs" %in% colnames(scored)){
      scored <- scored[,!names(scored) %in% "Scoring_Logs"]
    }
    # Removing the Scoring Logs column
    if("Scoring Logs" %in% colnames(scored)){
      scored <- scored[,!names(scored) %in% "Scoring Logs"]
    }
    # Removing the REDCap column
    if("Unknown" %in% colnames(scored)){
      scored <- scored[,!names(scored) %in% "Unknown"]
    }


    if(i == 1){
      full <- scored
    } else{

      # full <- bind_rows(full,map2_df(scored, map(full,class), ~{class(.x) <- .y;.x}))
      full <- rbind.fill(full,scored)
    }
  }

  # Doing this for CI in Talker disc
  if(grepl("Talker",tasks[tasky])){
    # Getting the rest of the files
    files = list.files(full.names = T)
    # Getting rid of the ./
    files <- gsub(x = files, pattern = "./", replacement = "")
    # Excluding full combined
    files <- files[!grepl("Combined", files)]
    files <- files[!grepl("Old", files)]

    full2 <- ""
    files <- files[grepl("CI_",files)]
    if(length(files) > 0){
      for(i in 1:length(files)){
        scored <- read_excel(files[i])
        if(i == 1){
          full2 <- scored
        } else{
          # full2 <- bind_rows(full2,map2_df(scored, map(full2,class), ~{class(.x) <- .y;.x}))
          full2 <- rbind.fill(full2,scored)

        }
      }
      write.xlsx(full2,"Combined_CI_Only_Scoring.xlsx",showNA = F)
    }
  }

  # Export excel data
  write.xlsx(full,paste0("Combined_Scoring_",tasksAlone,"_",date[d],".xlsx"),showNA = F)





}








