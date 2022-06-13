# 小学高年级及中学近视数据集
# 载入包和数据
library(tidyverse)
library(tableone)
library(readxl)
library(writexl)
library(rms)
library(haven)

df1<-read_xlsx('2020原始.xlsx')
eye<-df1 %>% 
  filter(grade==11|grade==12|grade==13|grade==04|grade==05|grade==06) %>% 
  select(id1,age,zser,zsel,myopia) 

df2<-read_sav('小学4-6问卷.sav')
highgrade<-df2%>% 
  select(ID1,A01,A02,A05,H401B,H401C,H401D,H02A,H402B,H04A,H04B,
         H04C,H05A,D031,D032,H06A) %>% 
  mutate(SLEEPHR=D031+D032/60)
  

df3<-read_sav('中学问卷.sav')
middle<-df3 %>% 
  filter(A01==11|A01==12|A01==13) %>% 
  select(ID1,A01,A02,A05,H401B,H401C,H401D,H02A,H402B,H04A,H04B,
         H04C,H05A,D031,D032,H06A) %>% 
  mutate(SLEEPHR=D031+D032/60)
  
qes<-bind_rows(highgrade,middle)
QES<-qes %>% 
  rename(id1=ID1,NATION=A05,grade=A01,gender=A02,SITEXCHANGE=H401B,
       DESKADJ=H401C,OCULAGYM=H401D,READHR=H02A,
       STUDYHR=H402B,TVHR=H04A,COMPHR=H04B,
       PHONEHR=H04C,SPORTHR=H05A)

myopia<-right_join(eye,QES,by="id1")
write_sav(myopia,"myopia_highandmiddle.sav")
