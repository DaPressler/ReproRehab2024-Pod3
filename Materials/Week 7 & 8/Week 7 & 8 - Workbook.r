rm(list=ls())

ReqdLibs = c("here","ggplot2","dplyr","tidyr","stringr","janitor","broom","emmeans")
invisible(lapply(ReqdLibs, library, character.only = TRUE))
#install.packages("janitor")
# here()
folder_path = getwd()
#folder_path

<<<<<<< HEAD
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
=======
# here()
folder_path = getwd()
# folder_path

subfolder_path = paste0(folder_path,'/data/')
# subfolder_path
# dir(subfolder_path)

file_list = list.files(subfolder_path)

file_list

file_list = list.files(subfolder_path)
file_list

file_path = paste0(subfolder_path,file_list[1])
# file_path
temp0 = read.delim(file_path)
# temp0
head(temp0,5)

new_names = paste(temp0[1,],temp0[4,])

colnames(temp0) = new_names

temp1 = temp0[-c(1:4),]
head(temp1,5)

file_list = list.files(subfolder_path)
file_list

new_names = paste(temp0[1,],temp0[4,])


data.all = data.frame(list())

for (i in 1:length(file_list)) {
    
file_path = paste0(subfolder_path,file_list[i])
    
    
temp = read.delim(file_path)    
colnames(temp) = paste(temp[1,],temp[4,])   
temp = temp[-c(1:4),]
    
temp = clean_names(temp)
colnames(temp)[1] = "perc_gait"
temp[,-1] = apply(temp[,-1],2,as.double)
    
temp$fileName = substr(file_list[i],1,nchar(file_list[i])-4)
     
data.all = rbind(data.all, temp)    
}

head(data.all,6)

data.all %>% 
separate(fileName,sep = "_", into = c("prefix","session","trial"), remove = FALSE) %>% 
select(!prefix) %>% 
{.->>data.clean}

head(data.clean)

data.clean %>% 
pivot_longer(cols = where(is.numeric), names_to = "measure", values_to = "value") %>% 
{.->> data.clean.longPlot}

data.clean.longPlot$perc_gait = as.double(data.clean.longPlot$perc_gait)
head(data.clean.longPlot)

thm = theme(plot.title = element_text(size = 40),
          legend.title = element_text(size = 25),
          legend.position = "top",
          legend.text = element_text(size = 20),
          strip.text = element_text(size = 35),
          axis.ticks.length = unit(0.3,"cm"),
          axis.line = element_line(colour = "black",linewidth = 1),
          axis.ticks = element_line(colour = "black",linewidth = 1),
          axis.text = element_text(colour = "black",size = 40),
          axis.text.x = element_text(lineheight = 1.1, margin = margin(t = 10)),
          axis.title.x = element_text(size=40, colour = "grey35", face = "plain",
                                     lineheight = 1.1, margin = margin(r = 10)),
          axis.title.y = element_text(size=40, colour = "grey35", face = "plain",
                                     lineheight = 1.1, margin = margin(r = 10)))

custom_colors <- c("#e41a1c", "#13388e", "#03ac13")

library("ggthemes")

options(repr.plot.width = 40, repr.plot.height = 40)
all_vars = 
ggplot(data.clean.longPlot, aes(x = perc_gait,y = value, 
                                group = session, col = session, fill = session)) + 
stat_summary(geom = "line", fun = mean, na.rm = TRUE) + 
stat_summary(geom = "ribbon",fun.data = mean_se, na.rm = TRUE,alpha=0.3) + 
  scale_color_manual(values = custom_colors) +
  scale_fill_manual(values = custom_colors) +
xlab("% gait cycle") + ylab("") + 
facet_wrap(~measure, scales = "free")  +
theme_clean() + thm
all_vars

# ggsave(file='all_vars.svg', plot=all_vars, width=35, height=35)








>>>>>>> 7d411586ae18fdf4bab8eaf380f02031bdb67c77

