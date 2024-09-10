Nonword_Func <- function(participant, date, calDate, origin){

  
  # Setting paths
  path <- paste0(origin,"General/R01+R21 Outcomes Studies/Data Collection/Subject testing/Cochlear Implant")
  analysis <- paste0(origin,"General/R01+R21 Outcomes Studies/Analysis/Scoring/Completed scoring")
  
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
  # Writing our new path to the nonword
  path <- paste0(path,"/",files[1],"/Gorilla Tasks/Nonword")
  
  
  # Copying files over
  file.copy(from = paste0(origin,"General/R01+R21 Outcomes Studies/Data Collection/Scoring Templates/Nonword Recognition/NWR score sheet integrity check.xlsx"), to = paste0(path,"/",participant,"_",calDate,"_Nonword.xlsx"))
  
  
  
  # setwd("C:/Users/hughm")
}