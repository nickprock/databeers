source(file = "script/functions.R")
data <- loadBeerReviews()


length(unique(data$beer_name))
nomi<-unique(data$beer_name)
data_fil<-data.frame()

for( i in 1:length(nomi)){
    print(paste0("letta birra ",i))
    d<-data[data$beer_name==nomi[i],]
    if(nrow(d)>5){
      d<-d[1:5,]
    }
    data_fil<-rbind(data_fil,d)
    print(paste0("inserita birra: ",i))
}      

write.csv(data_fil,"data/beer_reviews_fil_Marco.csv",row.names = F,col.names = T, quote=F)

c<-read.csv("beer_reviews_fil_Marco.csv",sep=",",dec=".",header=T, stringsAsFactors = F)
