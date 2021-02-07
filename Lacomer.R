library(rvest)
url<-"https://www.lacomer.com.mx/lacomer/doHome.action?dep=Harinas-Arroz-y-legumbres&key=Despensa&padreId=67&pasId=57&opcion=listaproductos&path=,67&pathPadre=&mov=1&subOpc=0&jsp=PasilloPadre.jsp&succId=287&succFmt=100&agruId=57"
selector<-"div.col-xs-6:nth-child(16) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > a:nth-child(1)"
pagina<-read_html(url)
nodo<-html_node(pagina, selector)
nodo_text<-html_text(nodo)
nodo_links<-html_attr(nodo, "href")
nodo_links

url_completa<-paste0("https://www.lacomer.com.mx/lacomer/", nodo_links)
url_completa

#Comparando url de paginación
https://www.lacomer.com.mx/lacomer/doHome.action?key=Despensa&succId=287&padreId=67&pasId=57&opcion=listaproductos&path=,67&pathPadre=0&jsp=PasilloPadre.jsp&noPagina=2&mov=1&subOpc=0&agruId=57&succFmt=100&dep=Harinas-Arroz-y-legumbres
https://www.lacomer.com.mx/lacomer/doHome.action?key=Despensa&succId=287&padreId=67&pasId=57&opcion=listaproductos&path=,67&pathPadre=0&jsp=PasilloPadre.jsp&noPagina=3&mov=1&subOpc=0&agruId=57&succFmt=100&dep=Harinas-Arroz-y-legumbres

#Stringr "Funsiona para transformar y generar string a partir de otros"

library(stringr)
lacomerpag<-"doHome.action?key=Despensa&succId=287&padreId=67&pasId=57&opcion=listaproductos&path=,67&pathPadre=0&jsp=PasilloPadre.jsp&noPagina=2&mov=1&subOpc=0&agruId=57&succFmt=100&dep=Harinas-Arroz-y-legumbres"
lista_paginas<-c(1:10)
lacomerpag<-str_replace(lacomerpag, "noPagina=2", paste0("noPagina=",lista_paginas))

paginacion<-paste0("https://lacomer.com.mx/lacomer/", lacomerpag)
paginacion

linksdepaginas<-function(url){
  selector<-"div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > a:nth-child(1)"
  pagina<-read_html(url)
  nodo<-html_nodes(pagina, selector)
  nodo_text<-html_text(nodo)
  nodo_links<-html_attr(nodo, "href")
  nodo_links
}

traerpagina<-linksdepaginas(paginacion[3])
traerpagina

linksasp<- sapply(paginacion, linksdepaginas)
linksasp
vlink<-as.vector(linksasp)
vlink

urlsfinal<-paste0("https://lacomer.com.mx/lacomer/", vlink)
urlsfinal

urllc<-"https://www.lacomer.com.mx/lacomer/doHome.action?key=ARROZ-DELGADO-&subdep=&dep=Harinas-Arroz-y-legumbres&marca=PATRON&succId=287&mov=1&subOpc=0&artEan=7501047650294&ver=detallearticulo&opcion=detarticulo&origen=artipasillo&padreId=67&path=,&pathPadre=0&jsp=PasilloPadre.jsp&pasId=57&noPagina=1&succFmt=100"
selectornamelc<-"div.container.main-container > div.row.product-detail-content > div.col-xs-12.col-md-7.product-detail-maring-left > div:nth-child(1) > div.col-xs-9.col-md-10.pl-0 > span"
pagina_weblc<-read_html(urllc)
nombre_nodolc<-html_node(pagina_weblc, selectornamelc)
nombre_textolc<-html_text(nombre_nodolc)
nombre_textolc

preciolc<-"div.container.main-container > div.row.product-detail-content > div.col-xs-12.col-md-7.product-detail-maring-left > div:nth-child(3) > span"
pagina_weblc<-read_html(urllc)
nombre_nodolc<-html_node(pagina_weblc, preciolc)
nombre_textolc<-html_text(nombre_nodolc)
nombre_textolc

namelc<-"div.container.main-container > div.row.product-detail-content > div.col-xs-12.col-md-7.product-detail-maring-left > div:nth-child(10) > div:nth-child(3) > div.col-xs-8.col-md-9.text-just"
pagina_weblc<-read_html(urllc)
nombre_nodolc<-html_node(pagina_weblc, namelc)
nombre_textolc<-html_text(nombre_nodolc)
nombre_textolc

descriptionlc<-"div.container.main-container > div.row.product-detail-content > div.col-xs-12.col-md-7.product-detail-maring-left > div:nth-child(10) > div:nth-child(4) > div.col-xs-8.col-md-9.text-just"
pagina_weblc<-read_html(urllc)
nombre_nodolc<-html_node(pagina_weblc, descriptionlc)
nombre_textolc<-html_text(nombre_nodolc)
nombre_textolc

