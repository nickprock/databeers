list_of_packages <- c("shiny", "shinydashboard", "RColorBrewer", "plotly",
                      "data.table", "shinyalert", "shinyjs", "shinybusy")
new_packages <- list_of_packages[!(list_of_packages %in% installed.packages()[,"Package"])]

if (length(new_packages)>0){
  install.packages(new_packages)
  lapply(list_of_packages, library, character.only = TRUE)
} else {
  lapply(list_of_packages, library, character.only = TRUE) 
}

source(file = "script/functions.R")
source(file = "script/compareMyBeer.R")
load("data/beer_reviews.rda")
fix.encoding <- function(df, originalEncoding = "UTF-8") {
  numCols <- ncol(df)
  df <- data.frame(df)
  for (col in 1:numCols)
  {
    if(class(df[, col]) == "character"){
      Encoding(df[, col]) <- originalEncoding
    }
    
    if(class(df[, col]) == "factor"){
      Encoding(levels(df[, col])) <- originalEncoding
    }
  }
  return(as_data_frame(df))
}

data<-fix.encoding(data)

appCSS <- "
#loading-content {
  position: absolute;
  background: #ffffff;
  opacity: 0.9;
  z-index: 100;
  left: 0;
  right: 0;
  height: 100%;
  text-align: center;
  color: #fc8c03;
}
"


header <- dashboardHeader(
  #title =strong("DataBeers") 
  title = span(img(src = "https://www.svgrepo.com/show/108385/beer.svg", height = 50), "DataBeeRs",),
  titleWidth = 300,
  
  tags$li(actionLink("openModal", label = "Dati", icon = icon("info")),
          class = "dropdown")

)


#Sidebar content of the dashboard
sidebar <- dashboardSidebar(
  sidebarMenu(

    style = "position: fixed; overflow: visible;",
    menuItem("Home",tabName = "home",icon=icon("home")),
    menuItem("Birre", tabName = "beer", icon = icon("beer")),
    menuItem("Compara", tabName = "compara", icon = icon("beer")),
    menuItem("Scopri", tabName = "scopri", icon = icon("bullseye")),
    h1(),
    img(src="https://i.pinimg.com/originals/25/23/dd/2523dd121ef1db3e5d5c8612277de164.jpg",height = "200px",style="display: block; margin-left: auto; margin-right: auto;"),
    hr(),
    HTML(
      paste0(
        "<br><br><br>",
        "<p style = 'text-align: center;'><medium> - Marco Cortese  &  Nicola Procopio - <script>document.write(yyyy);</script></medium></p>"
      ),
      HTML(paste0("<table align='center'; style='margin-left:auto; margin-right:auto;'>",
                         "<tr>",
                         "<td style='padding: 5px;'><a href='https://www.linkedin.com/in/marco-cortese-kr23-mi08' target='_blank'><i class='fab fa-linkedin fa-lg'></i></a></td>",
                         "<td style='padding: 5px;'><a href='https://github.com/MarCortese' target='_blank'><i class='fab fa-github fa-lg'></i></a></td>",
                         "<td style='padding: 5px;'><a href='https://www.linkedin.com/in/nicolaprocopio/' target='_blank'><i class='fab fa-linkedin fa-lg'></i></a></td>",
                        "<td style='padding: 5px;'><a href='https://github.com/nickprock' target='_blank'><i class='fab fa-github fa-lg'></i></a></td>",
                        "</tr>",
                         "</table>"
                         )
      )),
    useShinyalert(),  # Set up shinyalert
    actionButton("preview", "", 
    style="color: #A66900; background-color: #A66900; border-color: #A66900")
  )
)


# fluidRow


# frow1 <- fluidRow(
#   
#   useShinyjs(),
#   inlineCSS(appCSS),
#   
#   # Loading message
#   div(
#     id = "loading-content",
#     h2("Caricamento dati..."),
#     h3("...attendere 1 minuto...")
#   ),
#   
# 
#   hidden(
#     div(
#       id = "app-content",
#           column(6,
#           h3("Scegli la tua birra e leggi le recensioni")),
#           column(6,
#           img(src="https://freedesignfile.com/upload/2015/05/Beer-flat-style-background-vector-design-04.jpg",height = "200px",style="display: block; margin-left: auto; margin-right: auto;")
#           )
#     )
#   )
# )




frowhome<-fluidRow(
  tags$img(src="https://img.grouponcdn.com/iam/eq6coTtDPSqte1nedEWm/Sc-2048x1229/v1/c700x420.jpg",width="500",style="display: block; margin-left: auto; margin-right: auto;"),
  
  hr(),
  hr(),
  div(h2("La seguente app mostra i valori legati alle recensione di birra, inoltre sono stati sviluppati
         due algoritmi per comparare differenti birre e per consigliare le birre recensite con valori più analoghi alla tua preferita.",align="justify"),style = "color:brown"),
  
  br(),
  
  div(h2("Data la grande mole di dati bisogna attendere il messaggio di avvenuto caricamento dei dati, potrebbe richiedere alcuni minuti.",align="justify"),style = "color:brown"),
  # br(),
  # div(h3("•	Dataset completo, oltre 1.5 ML di recensioni, potrebbe richiedere alcuni minuti;
  #         ",align="justify"),style = "color:brown"),
  # div(h3("•	Dataset Ridotto1, considerate massimo 10 recensioni per birra;
  #         ",align="justify"),style = "color:brown"),
  # div(h3("•	Dataset Ridotto2, considerate massimo 2 recensioni per birra.
  #         ",align="justify"),style = "color:brown")
      )

# frowhome2<-fluidRow(
#   
#   radioButtons("SceltaDataset", label = h3(""),
#                choices = list("Totale" = 1, "Ridotto1" = 2, "Ridotto2" = 3), 
#                selected = 3, inline=T)
#   
# )


frow1 <- fluidRow(
  
  useShinyjs(),
  # inlineCSS(appCSS),
  # 
  # # Loading message
  # div(
  #   id = "loading-content",
  #   h2("Caricamento dati..."),
  #   h3("...attendere 1 minuto...")
  # ),
  # 
  # 
  # hidden(
  #   div(
  #     id = "app-content",
      column(6,
             h3("Scegli la tua birra e leggi le recensioni")),
      column(6,
             img(src="https://freedesignfile.com/upload/2015/05/Beer-flat-style-background-vector-design-04.jpg",height = "200px",style="display: block; margin-left: auto; margin-right: auto;")
      )
  #   )
  # )
)


frow2<-fluidRow(
  selectizeInput(
    'beer1', '',
    choices = unique(data$beer_name)
  ),
  tableOutput("tabella")
  
  
)

frow3<-fluidRow(
  selectizeInput(
    'compare_beer_1', '',
    choices = unique(data$beer_name)
  ),
  selectizeInput(
    'compare_beer_2', '',
    choices = unique(data$beer_name)
  ),
  tableOutput("similarita"),
  
)
frow4<-fluidRow(
  valueBoxOutput("nome_1",2),
  valueBoxOutput("stile_1",2),
  valueBoxOutput("palato_1",2),
  valueBoxOutput("gusto_1",2),
  valueBoxOutput("aspetto_1",2),
  valueBoxOutput("aroma_1",2)

)

frow5<-fluidRow(
  valueBoxOutput("nome_2",2),
  valueBoxOutput("stile_2",2),
  valueBoxOutput("palato_2",2),
  valueBoxOutput("gusto_2",2),
  valueBoxOutput("aspetto_2",2),
  valueBoxOutput("aroma_2",2)

)

frow6<-fluidRow(
  selectizeInput(
    'beer_recommended', '',
    choices = unique(data$beer_name)
  ),
  actionButton("run", "Esegui", icon("spinner"), 
                             style="color: #fff; background-color: #fc8c03; border-color: #fc8c03"),
  tableOutput("recommended_show"),
  

)



# combine the two fluid rows to make the body
body <- dashboardBody(

  tags$head(tags$style(HTML('
                                /* logo */
                                .skin-blue .main-header .logo {
                                background-color: #ffffff;
                                font-family: "Georgia", cursive;
                                font-weight: bold;
                                font-size: 24px;
                                color:#A66900;
                                }

                                /* logo when hovered */
                                .skin-blue .main-header .logo:hover {
                                background-color: #ffffff;
                                }

                                /* navbar (rest of the header) */
                                .skin-blue .main-header .navbar {
                                background-color: #ffffff;
                                font-family: "Georgia";
                                font-size: 14px;
                                color:#A66900;
                                }

                                /* main sidebar */
                                .skin-blue .main-sidebar {
                                background-color: #A66900;
                                }

                                /* active selected tab in the sidebarmenu */
                                .skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
                                background-color: #A66900;
                                }
                                
                                /* other links in the sidebarmenu when hovered */
                                .skin-blue .main-sidebar .sidebar .sidebar-menu a:hover{
                                background-color: #A66900;
                                }
                            

                            
                                /* other links in the sidebarmenu */
                                .skin-blue .main-sidebar .sidebar .sidebar-menu a{
                                background-color: #A66900;
                                color: #5f2d02;
                                }

                                /* toggle button when hovered  */
                                .skin-blue .main-header .navbar .sidebar-toggle:hover{
                                background-color: #A66900;
                                }'
                            # /* body */
                            # .content-wrapper, .right-side {
                            # background-color: #ffffff;
                            # }
                            
  ))),


  tabItems(tabItem(tabName="home",frowhome),#,frowhome2),
           tabItem(tabName = "beer",frow1,frow2),
           tabItem(tabName = "compara",frow3,frow4,frow5),
           tabItem(tabName = "scopri",frow6)))

#completing the ui part with dashboardPage
options(show.error.messages = FALSE)
ui <- dashboardPage(title = 'Data Beers', header, sidebar, body)#, skin='yellow')
server <- function(input, output,session) {
  options(show.error.messages = FALSE)
  observeEvent(!input$preview, {
    shinyalert("WOW!", "Dati caricati", type = "success")
  })


# hide(id = "loading-content", anim = TRUE, animType = "fade")    
# show("app-content")
  
  observeEvent(input$openModal, {
    showModal(
      modalDialog(title = "Dati",
                  p("I dati sono reperibili al seguente link:"),
                  p(h3(helpText(   a("Data set",     href="https://data.world/socialmediadata/beeradvocate")),align="center")))
    )
  })
  
  
  
  output$value <- renderPrint({ input$text })
  if(names(data)[13]=="beer_beerid."){
    names(data)[13]<-"beer_beerid"
  }
  data2<-data
  names(data2)<-c("id_birrificio","birrificio","tempo_recensione","punteggio","aroma","aspetto","nome_profilo","stile_birra","palato","gusto","nome","abv","id_birra")
  DT<-as.data.table(data2)
  DT_1<-as.data.table(data2)
  DT_2<-as.data.table(data2)
  DT_3<-as.data.frame(data2)
  
  
  beerchosen<-reactive({
    as.data.frame(DT[nome %like% input$beer1])
  })
  

  filtrataNomeShow<-reactive({
    if(nchar(as.character(input$beer1))>0){
      beerchosen()[,c(2,4,5.6,8,9,10,11,12)]
    }
  })
  
  output$tabella <- renderTable({ filtrataNomeShow() })
  
  
  
   calcolo<-reactive({
     calc_similarity(beer1 = input$compare_beer_1, 
                   beer2 = input$compare_beer_2)
    })
   
   output$similarita<-renderTable({
     calcolo()
   })
   
   beerchosen_comp_1<-reactive({
     as.data.frame(DT_1[nome %like% input$compare_beer_1][1])
   })
   beerchosen_comp_2<-reactive({
     as.data.frame(DT_2[nome %like% input$compare_beer_2][1])
   })
   
   filtrataNomeShow_comp_1<-reactive({
     if(nchar(as.character(input$compare_beer_1))>0){
       beerchosen_comp_1()[,c(2,4,5.6,8,9,10,11,12)]
     }
   })
   
   ########
   
   # valori birra 1
   output$nome_1 <- renderValueBox({
     valueBox(
       (paste0('Nome')%>%
          lapply(htmltools::HTML))
       ,paste0(beerchosen_comp_1()$nome)
       ,color = "orange")
   })
   output$palato_1 <- renderValueBox({
     valueBox(
       (paste0('Palato')%>%
          lapply(htmltools::HTML))
       ,paste0(beerchosen_comp_1()$palato)
       ,color = "orange")
   })
   output$aroma_1 <- renderValueBox({
     valueBox(
       (paste0('Aroma')%>%
          lapply(htmltools::HTML))
       ,paste0(beerchosen_comp_1()$aroma)
       ,color = "orange")
   })
   output$stile_1 <- renderValueBox({
     valueBox(
       (paste0('Stile')%>%
          lapply(htmltools::HTML))
       ,paste0(beerchosen_comp_1()$stile_birra)
       ,color = "orange")
   })
   output$gusto_1 <- renderValueBox({
     valueBox(
       (paste0('Gusto')%>%
          lapply(htmltools::HTML))
       ,paste0(beerchosen_comp_1()$gusto)
       ,color = "orange")
   })
   output$aspetto_1<- renderValueBox({
     valueBox(
       (paste0('Aspetto')%>%
          lapply(htmltools::HTML))
       ,paste0(beerchosen_comp_1()$aspetto)
       ,color = "orange")
   })
   
   ########
   
   # valori birra 2
   output$nome_2 <- renderValueBox({
     valueBox(
       (paste0('Nome')%>%
          lapply(htmltools::HTML))
       ,paste0(beerchosen_comp_2()$nome)
       ,color = "orange")
   })
   output$palato_2 <- renderValueBox({
     valueBox(
       (paste0('Palato')%>%
          lapply(htmltools::HTML))
       ,paste0(beerchosen_comp_2()$palato)
       ,color = "yellow")
   })
   output$aroma_2 <- renderValueBox({
     valueBox(
       (paste0('Aroma')%>%
          lapply(htmltools::HTML))
       ,paste0(beerchosen_comp_2()$aroma)
       ,color = "yellow")
     
   })
   output$stile_2 <- renderValueBox({
     valueBox(
       (paste0('Stile')%>%
          lapply(htmltools::HTML))
       ,paste0(beerchosen_comp_2()$stile_birra)
       ,color = "yellow")
   })
   output$gusto_2 <- renderValueBox({
     valueBox(
       (paste0('Gusto')%>%
          lapply(htmltools::HTML))
       ,paste0(beerchosen_comp_2()$gusto)
       ,color = "yellow")
   })
   output$aspetto_2 <- renderValueBox({
     valueBox(
       (paste0('Aspetto')%>%
          lapply(htmltools::HTML))
       ,paste0(beerchosen_comp_2()$aspetto)
       ,color = "yellow")
   })
   
   
   
   # previsione
   recommended_Beers <- eventReactive(input$run, {
     compareMyBeer(myBeer = input$beer_recommended)
   })
   
   options(show.error.messages = FALSE)
   observeEvent(input$run, {
     shinyalert("Attendere", "Il calcolo potrebbe richiedere alcuni minuti", type = "warning", timer=7000)
   })
   
   output$recommended_show <- renderTable({
     recommended_Beers()
   })
   

   
   
   
   
 

  
  
  
}

shinyApp(ui, server)




