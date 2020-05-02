# carica il dataset
source(file = "script/functions.R")
load("data/beer_reviews.rda")
# cerca la birra
getBeerList(letter = "Bush De No")
# recEngine
source(file = "script/compareMyBeer.R")
calc_similarity(beer1 = "Bush De Noël", 
                beer2 = "Bush De Noël Premium")
calc_similarity(beer1 = "Fat Tire Amber Ale", 
                beer2 = "Dale's Pale Ale")
recommended_Beers <- compareMyBeer(myBeer = "Corona Extra")
