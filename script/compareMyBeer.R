options( warn = -1 )
compareMyBeer <- function(myBeer) {
  beer1 <- myBeer
  id <- detect_beerid(name = beer1)
  data$totalRev <- ((2*data$review_overall)+(data$review_aroma)+
                      (data$review_appearance)+ (data$review_palate)+
                      (data$review_taste))/5
  x <- data[data$beer_beerid == id,]
  reviewers <- unique(x$review_profilename[x$totalRev>4.8])
  if (length(reviewers)!=0){
    beer2_1 <- unique(data$beer_name[(data$review_profilename %in% reviewers)
                                     & data$review_overall>4.8])
    beer2_1 <- beer2_1[beer2_1!=beer1]
    if (length(beer2_1)>30){
      beer2_0 <- sort(table(data$beer_name[(data$review_profilename %in% reviewers)
                                           & data$review_overall>4.8]), decreasing = T)
      beer2_1 <- names(beer2_0)[1:31]
    }
    beer2_1 <- beer2_1[beer2_1!=beer1]
    if (length(beer2_1)!=0){
      lista <- data.frame(myBeer = character(length(beer2_1)), 
                          recommendedBeer = character(length(beer2_1)),
                          recommendedBeer_brewery = character(length(beer2_1)),
                          recommendedBeer_type = character(length(beer2_1)),
                          recommendedBeer_abv = character(length(beer2_1)),
                          recommendedBeer_rating = numeric(length(beer2_1)),
                          stringsAsFactors = F)
      lista$myBeer <- beer1
      lista$recommendedBeer <- beer2_1
      print("Il calcolo potrebbe richiedere anche 2 minuti")
      print("Ci scusiamo per il disagio")
      for (i in 1:length(beer2_1)){
        lista$recommendedBeer_brewery[i] <- unique(data$brewery_name[data$beer_name==beer2_1[i]])
        lista$recommendedBeer_type[i] <- unique(data$beer_style[data$beer_name==beer2_1[i]])
        lista$recommendedBeer_abv[i] <- unique(data$beer_abv[data$beer_name==beer2_1[i]])
        lista$recommendedBeer_rating[i] <- calc_similarity(beer1 = beer1, beer2 = beer2_1[i])
      }
      
      lista1 <- lista[order(lista$recommendedBeer_rating, decreasing = T),]
      lista1 <- lista1[1:10,-1]
      return(lista1)
    } else {
      print("Non ci sono revisioni per la tua birra")
      print("Ci scusiamo per il disagio")
    }
    
  } else{
    print("Non ci sono revisioni per la tua birra")
    print("Ci scusiamo per il disagio")
  }
}
