rm(list=ls())

ReqdLibs = c("here","ggplot2","dplyr","tidyr","stringr","janitor","broom","emmeans")
invisible(lapply(ReqdLibs, library, character.only = TRUE))
#install.packages("janitor")
# here()
folder_path = getwd()
#folder_path

subfolder_path = paste0(folder_path, '/data') #use paste 0 to get paste without a space
#subfolder_path
#dir(subfolder_path) #dir gives all the information not just the files
file_list = list.files(subfolder_path, pattern = ".txt") #getting just the files via list.files --> using pattern = allows you to only call in certain file types into your list (i.e. just csv or just txt etc)
file_list[1]

##IMPORTING THE DATA (Week 2 learning)
#paste0(subfolder_path,file_list[1 or i?])
file_path = paste0(subfolder_path, "/", file_list[1])
file_path
read.delim(file_path) #no file.txt, so when in doubt use delim files - can work for txt

length(file_list)
  
temp0 = read.delim(file_path) #if just ran this, we would only get the last file of the 11.
  colnames(temp0) #tells me the names of the columns
  temp0[1,] #indexing to get whole first row - all of the names
  temp0[4,] #indexing to get whole 4th row which is also useful information
  new_names = paste(temp0[1,],temp0[4,]) #concadinating all the data from row 1 and row 4 
  colnames(temp0) = new_names
  temp1 = temp0[-c(1:4),]
  head(temp1,5)

data.all = data.frame(list())

for(i in 1: length(file_list)){
  file_path = paste0(subfolder_path, "/", file_list[i])
  temp = read.delim(file_path)
  colnames(temp) = new_names
  temp = temp[-c(1:4),]
  data.all = rbind(temp)
}

