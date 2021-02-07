library(rvest)
web<-"https://www.chedraui.com.mx/Departamentos/S%C3%BAper/Despensa/Arroz%2C-frijol-y-especias/c/MC210503?q=%3Arelevance&page=0&pageSize=24"
selector<-"li.js-plp-product-click:nth-child(1) > a:nth-child(19)"
pagina<-read_html(web)
nodox<-html_node(pagina, selector)
nodox_text<-html_text(nodox)
nodox_link<-html_attr(nodox, "href")
nodox_link

urlsuperche<-paste0("http://chedraui.com.mx", nodox_link)
urlsuperche

https://www.chedraui.com.mx/Departamentos/S%C3%BAper/Despensa/Arroz%2C-frijol-y-especias/c/MC210503?q=%3Arelevance&page=0&pageSize=24

library(stringr)
contched<-"/Departamentos/S%C3%BAper/Despensa/Arroz%2C-frijol-y-especias/c/MC210503?q=%3Arelevance&page=0&pageSize=24"
chedaralist<-c(0:6)
contched<-str_replace(contched, "page=0", paste0("page=",chedaralist))
paginacionesched<-paste0("https://chedraui.com.mx", contched)
paginacionesched

finallinks<-function(web){
  selector<-"a:nth-child(19)"
  pagina<-read_html(web)
  nodox<-html_nodes(pagina, selector)
  nodox_text<-html_text(nodox)
  nodox_link<-html_attr(nodox, "href")
  nodox_link
  
}

traermelinks<-finallinks(paginacionesched[7])
traermelinks

#Funciones apply son funciones que permiten aplicar una funsión a un conjunto de datos.

resultado<-sapply(paginacionesched, finallinks)
chedalink<-as.matrix(resultado)
chedalink


chedalinkproductos<-paste0("https://chedraui.com.mx", resultado)
chedalinkproductos

detallesweb<-"https://www.chedraui.com.mx/Departamentos/S%C3%BAper/Despensa/Arroz%2C-frijol-y-especias/Semillas/Garbanzo-La-Merced-500-g/p/000000000003008472?siteName=Sitio+de+Chedraui"
nombre<-"div > div.product-details.page-title > div.product-details-name.name"
pagina_web<-read_html(detallesweb)
nombre_nodo<-html_node(pagina_web, nombre)
nombre_texto<-html_text(nombre_nodo)
nombre_texto

description<-"div > div.row.js-pdp-product-click > div.product-main-info-container.col-sm-6.col-lg-8 > div > div > div.col-lg-5 > div > div.description > div.description-body > p:nth-child(1)"
pagina_web<-read_html(detallesweb)
nombre_nodo<-html_node(pagina_web, description)
nombre_texto<-html_text(nombre_nodo)
nombre_texto

precio<-"div > div.row.js-pdp-product-click > div.product-main-info-container.col-sm-6.col-lg-8 > div > div > div.add-to-cart-container.col-lg-7 > p"
pagina_web<-read_html(detallesweb)
nombre_nodo<-html_node(pagina_web, precio)
nombre_texto<-html_text(nombre_nodo)
nombre_texto

beneficios<-"div > div.row.js-pdp-product-click > div.product-main-info-container.col-sm-6.col-lg-8 > div > div > div.col-lg-5 > div > div.description > div.description-body > ul"
pagina_web<-read_html(detallesweb)
nombre_nodo<-html_node(pagina_web, beneficios)
nombre_texto<-html_text(nombre_nodo)
nombre_texto







