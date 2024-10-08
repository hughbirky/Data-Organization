Retroactive_Priming_Func <- function(participant, date, calDate, origin){
  move_to_analysis <- T
  
  # Setting paths
  path <- paste0(origin,"General/R01+R21 Outcomes Studies/Data Collection/Subject testing/Cochlear Implant")
  analysis <- paste0(origin,"General/R01+R21 Outcomes Studies/Analysis/Scoring/Completed scoring")
  
  
  for(d in 1:length(date)){
    # Setting the working path for data collection
    setwd(path)
    # Getting a list of all of the excel files
    files = list.files(full.names = T)
    # Getting rid of the ./
    files <- gsub(x = files, pattern = "./", replacement = "")
    # Getting the folder we need for the participant
    files <- files[grepl(participant, files)]
    # Writing the new path with the folder we just got
    path <- paste0(path,"/",files[1])
    # Setting the working directory to that
    setwd(path)
    # Getting a list of all of the folders
    files = list.files(full.names = T)
    # Getting rid of the ./
    files <- gsub(x = files, pattern = "./", replacement = "")
    # Getting the folder we need for the visit type
    files <- files[grepl(date[d], files)]
    # Writing our new path to the talker discrimination
    path <- paste0(path,"/",files[1],"/Matlab Tasks/Retroactive Priming")
    # Setting the new working directory
    setwd(path)
    
    
    
    
    
    # Setting the working path for analysis scoring
    setwd(analysis)
    # Getting a list of all of the excel files
    files1 = list.files(full.names = T)
    # Getting rid of the ./
    files1 <- gsub(x = files1, pattern = "./", replacement = "")
    # Getting the folder we need for the participant[p]
    files1 <- files1[grepl(participant, files1)]
    # Writing the new path with the folder we just got
    analysis <- paste0(analysis,"/",files1[1])
    # Setting the working directory to that
    setwd(analysis)
    # Getting a list of all of the folders
    files1 = list.files(full.names = T)
    # Getting rid of the ./
    files1 <- gsub(x = files1, pattern = "./", replacement = "")
    # Getting the folder we need for the visit type
    files1 <- files1[grepl(date[d], files1)]
    # Writing our new path to the talker discrimination
    analysis <- paste0(analysis,"/",files1[1],"/Matlab Tasks/Retroactive Priming")
    if(!dir.exists(analysis)){
      dir.create(analysis)
    }
    
    
    
    setwd(path)
    # Getting a list of all of the excel files
    files = list.files(full.names = T)
    # Getting rid of the ./
    files <- gsub(x = files, pattern = "./", replacement = "")
    
    
    # Import excel data
    Data1 <- read_excel(files[1])
    
    # Duplicating because I'm lazy
    Data2 <- Data1
    
    
    # Turing correct column into numbers
    for(c in 1:length(Data2$Correct)){
      if(Data2$Correct[c] == TRUE){
        Data2$Correct[c] <- 1
      } 
      if(Data2$Correct[c] == FALSE){
        Data2$Correct[c] <- 0
      }
    }
    
    # Sorting in alphabetical order
    Data2 <- Data2 %>% arrange(Prime)
    
    # Reading in the template
    template <- read_excel(paste0(origin,"General/R01+R21 Outcomes Studies/Analysis/Code/R01R21 Scripts/Retroactive Priming/RetroPriming_Template.xlsx"))
    
    # Adding in extra columns
    Data2$Noise <- template$Noise
    Data2$Condition <- template$Condition
    
    # Making scoring column
    Data2$REDCap <- NA
    Data2$Correct_Quiet_Unrelated <- NA
    Data2$RT_Quiet_Unrelated <- NA
    Data2$Correct_Quiet_Related <- NA
    Data2$RT_Quiet_Related <- NA
    Data2$Correct_Noise1_Unrelated <- NA
    Data2$RT_Noise1_Unrelated <- NA
    Data2$Correct_Noise1_Related <- NA
    Data2$RT_Noise1_Related <- NA
    Data2$Correct_Noise2_Unrelated <- NA
    Data2$RT_Noise2_Unrelated <- NA
    Data2$Correct_Noise2_Related <- NA
    Data2$RT_Noise2_Related <- NA
    Data2$Unknown <- NA
    
    
    # Filtering (p5 is quiet, zero is noise1, n5 is noise2)
    Quiet_Unrelated <- Data2 %>% 
      filter(Noise == "p5") %>%
      filter(Condition == "U")
    Quiet_Related <- Data2 %>% 
      filter(Noise == "p5") %>%
      filter(Condition == "R")
    Noise1_Unrelated <- Data2 %>% 
      filter(Noise == "zero") %>%
      filter(Condition == "U")
    Noise1_Related <- Data2 %>% 
      filter(Noise == "zero") %>%
      filter(Condition == "R")
    Noise2_Unrelated <- Data2 %>% 
      filter(Noise == "n5") %>%
      filter(Condition == "U")
    Noise2_Related <- Data2 %>% 
      filter(Noise == "n5") %>%
      filter(Condition == "R")
    
    
    # Scoring column
    Data2$Correct_Quiet_Unrelated[1] <- mean(Quiet_Unrelated$Correct)*100
    Data2$RT_Quiet_Unrelated[1] <- mean(Quiet_Unrelated$`Response time`)
    Data2$Correct_Quiet_Related[1] <- mean(Quiet_Related$Correct)*100
    Data2$RT_Quiet_Related[1] <- mean(Quiet_Related$`Response time`)
    Data2$Correct_Noise1_Unrelated[1] <- mean(Noise1_Unrelated$Correct)*100
    Data2$RT_Noise1_Unrelated[1] <- mean(Noise1_Unrelated$`Response time`)
    Data2$Correct_Noise1_Related[1] <- mean(Noise1_Related$Correct)*100
    Data2$RT_Noise1_Related[1] <- mean(Noise1_Related$`Response time`)
    Data2$Correct_Noise2_Unrelated[1] <- mean(Noise2_Unrelated$Correct)*100
    Data2$RT_Noise2_Unrelated[1] <- mean(Noise2_Unrelated$`Response time`)
    Data2$Correct_Noise2_Related[1] <- mean(Noise2_Related$Correct)*100
    Data2$RT_Noise2_Related[1] <- mean(Noise2_Related$`Response time`)
    
    
    # Making Totals
    Data2$Scoring_Logs <- NA
    Data2$Quiet_Score_Total <- NA
    Data2$Noise1_Score_Total <- NA
    Data2$Noise2_Score_Total <- NA
    Data2$Quiet_RT_Total <- NA
    Data2$Noise1_RT_Total <- NA
    Data2$Noise2_RT_Total <- NA
    Data2$Scoring_Logs <- NA
    Data2$Related_Score_Total <- NA
    Data2$Unrelated_Score_Total <- NA
    Data2$Related_RT_Total <- NA
    Data2$Unrelated_RT_Total <- NA
    Data2$Score_Total <- NA
    Data2$RT_Total <- NA
    
    
    # Assigning Scores
    Data2$Quiet_Score_Total[1] <- mean(c(Data2$Correct_Quiet_Related[1],Data2$Correct_Quiet_Unrelated[1]))
    Data2$Noise1_Score_Total[1] <- mean(c(Data2$Correct_Noise1_Related[1],Data2$Correct_Noise1_Unrelated[1]))
    Data2$Noise2_Score_Total[1] <- mean(c(Data2$Correct_Noise2_Related[1],Data2$Correct_Noise2_Unrelated[1]))
    Data2$Quiet_RT_Total[1] <- mean(c(Data2$RT_Quiet_Related[1],Data2$RT_Quiet_Unrelated[1]))
    Data2$Noise1_RT_Total[1] <- mean(c(Data2$RT_Noise1_Related[1],Data2$RT_Noise1_Unrelated[1]))
    Data2$Noise2_RT_Total[1] <- mean(c(Data2$RT_Noise2_Related[1],Data2$RT_Noise2_Unrelated[1]))
    Data2$Related_Score_Total[1] <- mean(c(Data2$Correct_Noise1_Related[1],Data2$Correct_Noise2_Related[1],Data2$Correct_Quiet_Related[1]))
    Data2$Unrelated_Score_Total[1] <- mean(c(Data2$Correct_Quiet_Unrelated[1],Data2$Correct_Noise1_Unrelated[1],Data2$Correct_Noise2_Unrelated[1]))
    Data2$Related_RT_Total[1] <- mean(c(Data2$RT_Quiet_Related[1],Data2$RT_Noise1_Related[1],Data2$RT_Noise2_Related[1]))
    Data2$Unrelated_RT_Total[1] <- mean(c(Data2$RT_Quiet_Unrelated[1],Data2$RT_Noise1_Unrelated[1],Data2$RT_Noise2_Unrelated[1]))
    Data2$Score_Total[1] <- mean(c(Data2$Quiet_Score_Total[1],Data2$Noise1_Score_Total[1],Data2$Noise2_Score_Total[1]))
    Data2$RT_Total[1] <- mean(c(Data2$Quiet_RT_Total[1],Data2$Noise1_RT_Total[1],Data2$Noise2_RT_Total[1]))
    
    
    
    
    
    setwd(analysis)
    write.xlsx(Data2, paste0(participant,"_",calDate,"_Retroactive_Priming.xlsx"),showNA = F)
    
    
    setwd(path)
    
    
    # Writing the new excel sheet to the other folder
    write.xlsx(Data2, paste0(participant,"_",calDate,"_Retroactive_Priming.xlsx"),showNA = F)
    
  }
}