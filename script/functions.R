library(dplyr)
library(readr)
library(stringr)
# carica il file con le recensioni
loadBeerReviews <- function(){
  read_csv("dati/beer_reviews.csv")
}
# data almeno una lettera restituisce la lista delle birre che iniziano con questa stringa
getBeerList<- function(letter){
  x <- data %>%
    distinct(beer_name) %>%
    filter(str_detect(pattern = paste0("^",letter), string = beer_name)) %>%
    arrange(desc(beer_name))
  return(x)
}
# trova l'id di una data birra
detect_beerid <- function(name){
  beer_lookup <- data %>%
    select(beer_beerid, beer_name) %>%
    distinct() %>%
    filter(beer_name == name) %>%
    select(beer_beerid)
  return(beer_lookup[[1]])
}
# serve per trovare i revisori comuni di due birre
common_reviewers <- function(beer1, beer2) {
  beer1 <- detect_beerid(beer1)
  beer2 <- detect_beerid(beer2)
  reviews1 <- data %>%
    filter(beer_beerid==beer1) %>%
    select(review_profilename)
  reviews2 <- data %>%
    filter(beer_beerid==beer2) %>%
    select(review_profilename)
  reviewers_sameset <- intersect(reviews1,reviews2)
  if (length(reviewers_sameset)==0) {
    NA
  } else {
    return(reviewers_sameset[[1]])
  }
}
# estrae le revisioni che sono contenute in features
# per renderlo human friendly beer è il nome della birra non beerid
get_review_metrics <- function(beer, userset) {
  beer.data <- data %>%
    filter(beer_beerid==detect_beerid(beer), review_profilename %in% userset) %>%
    arrange(review_profilename) %>%
    distinct(review_profilename, .keep_all = T) %>%
    select(review_overall, review_aroma, review_palate, review_taste)
  return(beer.data)
}
# calcolo della similarità
calc_similarity <- function(beer1, beer2) {
  common_users <- common_reviewers(beer1, beer2)
  if (length(common_users)==0) {
    return (NA)
  }
  beer1.reviews <- get_review_metrics(beer1, common_users)
  beer2.reviews <- get_review_metrics(beer2, common_users)
  weights <- c(2, 1, 1, 1)
  corrs <- sapply(names(beer1.reviews), function(metric) {
    cor(beer1.reviews[metric], beer2.reviews[metric])
  })
  calc_similarity <- sum(corrs * weights, na.rm=TRUE)
  return(calc_similarity)
}