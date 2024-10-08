Rhyme_Judgement_Func <- function(participant, date, calDate, origin){
  
  # Setting paths
  path <- paste0(origin,"General/R01+R21 Outcomes Studies/Data Collection/Subject testing/Cochlear Implant")
  analysis <- paste0(origin,"General/R01+R21 Outcomes Studies/Analysis/Scoring/Completed scoring")
  
  # Grabbing the scoring template
  scoringTemplate <- paste0(origin,"General/R01+R21 Outcomes Studies/Analysis/Code/R01R21 Scripts/Rhyme_Judgement/0Rhyme Judgement scoresheet 8.23.23_updated.xlsx")
  
  
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
  files <- files[grepl(date, files)]
  # Writing our new path to the talker discrimination
  path <- paste0(path,"/",files[1],"/Matlab Tasks/RhymeJudgment")
  
  
  
  
  
  
  
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
  analysis <- paste0(analysis,"/",files1[1],"/Matlab Tasks/Rhyme Judgment")
  if(!dir.exists(analysis)){
    dir.create(analysis)
  }
  
  
  
  
  setwd(path)
  # Getting a list of all of the excel files
  files = list.files(full.names = T)
  # Getting rid of the ./
  files <- gsub(x = files, pattern = "./", replacement = "")
  
  ### Reading in the template
  template <- read_excel(scoringTemplate)
  # Finding length of the template
  lengthTemp <- length(template$`# TrialWord1`)
  # Import excel data
  Data1 <- read.csv(files[1])
  # Computing length of original column
  length <- length(Data1$X..TrialWord1)
  
  
  
  # Adding in extra rows to make it 160
  if(length < lengthTemp){
    for(z in 1:(lengthTemp - length)){
      Data1[nrow(Data1) + 1,] <- NA
    }
  }
  
  # Creating a copy of the data frame
  Data2 <- Data1
  
  i = 1
  # Reorganizing
  for (i in 1:length){
    # Getting the word to sort
    word <- Data1$X..TrialWord1[i]
    # Checking what row that is in the template
    row <- which(template==word,arr.ind=TRUE)
    row[1]
    
    Data2[row[1],] <- Data1[i,]
  }
    
    
  
  # Making rows blank otherwise
  for(f in 1:length(Data2$X..TrialWord1)){
    if(!is.na(Data2$X..TrialWord1[f])){
      if(template$`# TrialWord1`[f] != Data2$X..TrialWord1[f]){
        Data2[f,] <- NA
      }
    }
  }
  
  # Data2$Time..Seconds.
  
  
  # Rename Time
  Data2 <- Data2 %>% 
    rename("RT" = "Time..Seconds.")
  
  # Making Scoring Columns
  Data2$`R+ % correct` <- NA
  Data2$`R- % correct` <- NA
  Data2$`R+ Ave RT` <- NA
  Data2$`R- Ave RT` <- NA
  Data2$`Tot ave RT` <- NA
  Data2$`Tot %  correct` <- NA
  
  
  # Making Rplus list and Rminus list
  Rplus <- c(2,5,9,15,16,17,20,22,23,25,27,31,32,35:46,49:51,53,54,56,63,64,66,68,69,71,73,74,75,78,80,81,82,84,87,88,89,93,100,101)
  Rminus <- 1:101
  Rminus <- setdiff(Rminus,Rplus)
  Rminus <- setdiff(Rminus,93)
  
  # Filtering for reaction time below 3501
  Data4 <- Data2[Rplus,] %>% 
    filter(!is.na(`Correct`)) 
  # Making R+ and R- Scores
  Data2$`R+ % correct`[1] <- mean(Data4$Correct)*100
  
  Data4 <- Data2[Rminus,] %>% 
    filter(!is.na(`Correct`)) 
  Data2$`R- % correct`[1] <- mean(Data4$Correct)*100
  
  Data4 <- Data2 %>% 
    filter(!is.na(`Correct`)) 
  Data2$`Tot %  correct`[1] <- mean(Data4$Correct)*100
  
  
  Data4 <- Data2[setdiff(Rplus,93),] %>%
    filter(!is.na(`RT`))
  Data2$`R+ Ave RT`[1] <- mean(Data4$RT)
  
  Data4 <- Data2[setdiff(Rminus,93),] %>%
    filter(!is.na(`RT`))
  Data2$`R- Ave RT`[1] <- mean(Data4$RT)
  
  Data4 <- Data2[setdiff(1:101,93),] %>%
    filter(!is.na(`RT`))
  Data2$`Tot ave RT`[1] <- mean(Data4$RT)
  
  
  
  
  # Writing the new excel sheet to the other folder
  write.xlsx(Data2, paste0(participant,"_",calDate,"_Rhyme.xlsx"),showNA = F)
  
  setwd(analysis)
  write.xlsx(Data2, paste0(participant,"_",calDate,"_Rhyme.xlsx"),showNA = F)
}