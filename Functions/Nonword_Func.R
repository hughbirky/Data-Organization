Nonword_Func <- function(participant, date, calDate){

  
  # Finding who's computer we are on
  origin <- "C:/Users"
  # Setting the working path for data collection
  setwd(origin)
  # Getting a list of all of the excel files
  files = list.files(full.names = T)
  # Getting rid of the ./
  files <- gsub(x = files, pattern = "./", replacement = "")
  # Getting the folder we need for the participant
  files <- files[grepl("hughm", files)]
  
  if(files == "hughm"){
    path <- "C:/Users/hughm/OneDrive - VUMC/General/R01+R21 Outcomes Studies/Data Collection/Subject testing/Cochlear Implant"
  } else{
    path <- "f"
  }
  
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
  file.copy(from = "C:/Users/hughm/OneDrive - VUMC/General/R01+R21 Outcomes Studies/Data Collection/Scoring Templates/Nonword Recognition/NWR score sheet integrity check.xlsx", to = paste0(path,"/",participant,"_",calDate,"_Nonword.xlsx"))
  
  
  
  setwd("C:/Users/hughm")
}