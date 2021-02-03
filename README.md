# databeers: Esperimento di recommender engine sulle birre.
Databeers nasce dalla passione per la birra, la data science e la passione R di due amici. Iniziato come un esercizio per passare un fine settimana di pioggia si propone di diventare un sistema consultabile per scoprire nuove etichette.

Il repo è un passatempo non abbiamo nessuna intenzione commerciale quindi il codice potrebbe essere non ottimizzato.
*I feedback sono sempre ben accetti*, potete usare le issue per segnalarci bug o miglioramenti, potete usare il fork e fare un vostro progetto o aiutarci a risolvere criticità.

**#enjoy**

## Funzioni R
Nei primi mesi del 2018 sul blog di yhat.com ho letto un articolo su recommender system in R.  
Ho provato a ottimizzare il codice lavorando con dplyr.  
Il lavoro non è ancora finito. In particolare:  
- ho lavorato su quello che sta in functions.R  
- è rimasta in sospeso alla primissima versione la funzione compareMyBeer (spero di riuscire a lavorarci)  

In MAIN.R trovate un sempio su come funziona il sistema di raccomandazioni.  
Ringrazio in anticipo quanti lo scaricheranno, ci lavoreranno e forniranno feedback per migliorare sia il programma che il mio modo di lavorare.  
Vi lascio il link dell'esperimento originale: http://blog.yhat.com/posts/recommender-system-in-r.html

## Dataset
Per le limitazioni sul mio account free ho caricato solo un campione di dati, [il dataset originale potete trovarlo su data.world](https://data.world/socialmediadata/beeradvocate)

Successivamente sono riuscito a caricare l'intero dataset in formato .rda.

Nico

## Shiny App

Partendo dal lavoro descritto in precedenza è stata sviluppata una web app con [shiny](https://shiny.rstudio.com/) per rappresentare gli output.
In questa web app viene preso in considerazione l'intero dataset, circa 1.5MLN direcensioni su birre perciò il caricamento iniziale richiederà del tempo come mostra la prima schermata dell'app:

![caricamento](https://i.imgur.com/W8ukMjM.jpg)

Un messaggio informerà sull'avvenuto caricamento dei dati

![complete](https://i.imgur.com/Q6XMmb7.jpg)


L'app è suddivisa in 3 sezioni


* Birre 
* Compara
* Scopri

### Birre

In questa tab si scegli la birra per la quale si desidera vedere le recensioni.

![birre](https://i.imgur.com/90kEhYf.jpg)

### Compara

Attraverso una delle funzioni sviluppate da Nicola Procopio vengono comparate le birre, mettendo in risalto le informazioni attribuite a ciascuna birra.

![compara](https://i.imgur.com/CGUXLbN.jpg)

### Scopri

Nell'ultima tab si valuta il modello di raccomandazione che suggerisce le birre più simili alla tua scelta, qualora ve ne sia una che rispecchia il giusto confronto.

![scopri](https://i.imgur.com/QOvMdpi.jpg)

### Link
[Potete trovare l'app qui]()

Marco

# Citation
Se usi il mio codice nella tua ricerca, cita questo progetto.
```
@misc{databeers,
  author =       {Nicola Procopio, Marco Cortese},
  title =        {DataBeeRs},
  howpublished = {\url{https://github.com/nickprock/databeers/}},
  year =         {2018}
}
```

## License
Il codice in questo repository è rilaciato sotto licenza GPL v3.

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Licenza Creative Commons" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />Quest'opera è distribuita con Licenza <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribuzione 4.0 Internazionale</a>.
