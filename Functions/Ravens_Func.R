Ravens_Func <- function(participant, date, calDate, origin){

  # Setting paths
  path <- paste0(origin,"General/R01+R21 Outcomes Studies/Data Collection/Subject testing/Cochlear Implant")
  analysis <- paste0(origin,"General/R01+R21 Outcomes Studies/Analysis/Scoring/Completed scoring")
  
  
  
  # Setting the working path for datta collection
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
  files <- files[grepl(date, files)]
  # Writing our new path to the talker discrimination
  path <- paste0(path,"/",files[1],"/Matlab Tasks/RavensTask")
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
  files1 <- files1[grepl(date, files1)]
  # Writing our new path to the talker discrimination
  analysis <- paste0(analysis,"/",files1[1],"/Matlab Tasks/RavensTask")
  if(!dir.exists(analysis)){
    dir.create(analysis)
  }
  
  
  
  setwd(path)
  # Getting a list of all of the excel files
  files = list.files(full.names = T)
  # Getting rid of the ./
  files <- gsub(x = files, pattern = "./", replacement = "")
  
  
  # Import excel data
  Data <- read.csv(files[1])
  
  # Calculating length of the columns
  length <- 
  
  # Adding new columns
  Data$REDCap <- NA
  Data$Mean_RT <- NA
  Data$Number_Correct <- NA
  Data$Number_Answered <- NA
  Data$Scoring_Logs
  Data$Final_Score <- NA
  
  # Calculating mean response time
  Data$Mean_RT[1] <- mean(Data$Time)
  # Calculating number correct
  Data$Number_Correct[1] <- sum(Data$Correct)
  # Calculating number answered
  Data$Number_Answered[1] <- length(Data$Answer)
  # Calculating final score
  Data$Final_Score[1] <- mean(Data$Correct) * 100
  
  setwd(analysis)
  write.xlsx(Data, paste0(participant,"_",calDate,"_Ravens_Scored.xlsx"),showNA = F)
  
  
  setwd(path)
  
  
  # Writing the new excel sheet to the other folder
  write.xlsx(Data, paste0(participant,"_",calDate,"_Ravens_Scored.xlsx"),showNA = F)
}