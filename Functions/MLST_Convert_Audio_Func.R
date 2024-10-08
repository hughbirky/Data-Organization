MLST_Convert_Audio_Func <- function(participant, date, calDate, origin){

  done <- ""
  
  p = 1
  d = 1
  for(p in 1:length(participant)){
    for(d in 1:length(date)){
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
      files <- files[grepl(participant[p], files)]
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
      path <- paste0(path,"/",files[1],"/Gorilla Tasks/MLST/uploads")
      # Setting the new working directory
      if(!dir.exists(path)){
        next
      } else{
        done <- c(done,paste0(participant[p],"/",date[d]))
      }
      
      setwd(path)
      # Getting a list of all of the excel files
      files = list.files(full.names = T)
      # Getting rid of the ./
      files <- gsub(x = files, pattern = "./", replacement = "")
      
      
      # Creating storage directory
      dir.create("Wav_Files")
      
      # Creating our output path for our files
      outputPathCopy <- "C:/Users/hughm/Desktop/Scoring"
      
      
      # Copying our files to a folder that the command prompt can access
      for(i in 1:length(files)){
        file.copy(from = files[i], to = paste0(outputPathCopy,"/",files[i]))
      }
      
      # Setting the working directory to our output path
      setwd(paste0(outputPathCopy))
      
      # Converting every file
      for(i in 1:length(files)){
        # Creating a string of the path to the file to be converted
        input <- paste0(outputPathCopy,"/",files[i])
        # Creating a string of the path to where we want to export
        outputpath <- paste0(outputPathCopy,"/Wav_Files/", gsub(x = files[i], pattern = ".weba", replacement = ".wav"))
        # Creating command for command prompt and executing
        cmd <- sprintf("ffmpeg -i %s -vn %s", input, outputpath)
        # Calling the system command
        system(cmd)
      }
      
      # Setting the directory to the wav files directory 
      setwd(paste0(outputPathCopy, "/Wav_Files"))
      
      
      # Getting a list of all of the files
      files = list.files(full.names = T)
      # Getting rid of the ./
      files <- gsub(x = files, pattern = "./", replacement = "")
      
      # Copying the files to the original wav files folder and then deleting the file
      for(i in 1:length(files)){
        file.copy(from = files[i], to = paste0(path,"/Wav_Files/",files[i]))
        unlink(files[i])
      }
      
      # Setting working directory to original output path
      setwd(outputPathCopy)
      # Getting a list of all of the excel files
      files = list.files(full.names = T)
      # Getting rid of the ./
      files <- gsub(x = files, pattern = "./", replacement = "")
      
      # Deleting the rest of the files
      for(i in 1:length(files)){
        unlink(files[i])
      }
    }
  }
  
  
  
  
  
  
  
  
  
  
  setwd("C:/Users/hughm")
}