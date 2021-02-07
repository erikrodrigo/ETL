library(rvest)
webq<-"https://www.amazon.com.mx/s?k=arroz&i=specialty-aps&srs=18073069011&__mk_es_MX=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=2TR2MJ5MDC66C&sprefix=arro%2Cspecialty-aps%2C201&ref=nb_sb_ss_ts-doa-p_1_4"
selectorx<-"#search > div.s-desktop-width-max.s-desktop-content.sg-row > div.sg-col-16-of-20.sg-col.sg-col-8-of-12.sg-col-12-of-16 > div > span:nth-child(4) > div.s-main-slot.s-result-list.s-search-results.sg-row > div:nth-child(1) > div > span > div > div > div:nth-child(3) > h2 > a"
paginax<-read_html(webq)
nodo<-html_node(paginax, selectorx)
nodo_text<-html_text(nodo)
nodo_link<-html_attr(nodo, "href")
nodo_link

urlamazon<-paste0("http://www.amazon.com.mx", nodo_link)
urlamazon

https://www.amazon.com.mx/s?i=grocery&rh=n%3A17724679011&page=5&qid=1610744493&rd=1&ref=sr_pg_5
https://www.amazon.com.mx/s?i=grocery&rh=n%3A17724679011&page=4&qid=1610744500&rd=1&ref=sr_pg_4

library(stringr)
paginacionsa<-"s?i=grocery&rh=n%3A17724679011&qid=1611080239&rd=1&ref=sr_pg_1"
contadora<-c(1:4)
pagoficiala<-str_replace(paginacionsa, "page=4", paste0("page=", contadora))
pagoficialaa<-str_replace(pagoficiala, "sr_pg_4", paste0("sr_pg_", contadora))
pagoficialaa

paginacionoficialamazon<-paste0("https://www.amazon.com.mx/", pagoficialaa)
paginacionoficialamazon

damelinkamz<-function(urla){
  selectora<-"div > div > div:nth-child(3) > h2 > a"
  paginaa<-read_html(urla)
  nodo_a<-html_nodes(paginaa, selectora)
  nodo_textaa<-html_text(nodo_a)
  nodo_linka<-html_attr(nodo_a, "href")
  nodo_linka
  
}

testamz<-damelinkamz(paginacionoficialamazon[2])
testamz
linksamazon<-sapply(paginacionoficialamazon, damelinkamz)
linksamazon

#Aqwui no se si el nrow se iguala a los 7 caracteres de petición en get articulo
z_mat<-matrix(unlist(linksamazon), nrow = 96)
z_mat


amzprersult<-paste0("https://www.amazon.com.mx", z_mat)
amzprersult


urlz<-"https://www.amazon.com.mx/Moderna-Golden-Harvest-Fusilli-Paquete/dp/B07TW1KFKM/ref=pd_sbs_6?pd_rd_w=0nXgc&pf_rd_p=af711615-ccc7-4a75-b160-7c074d817339&pf_rd_r=FY5DC8Z6PBF7GB8291MG&pd_rd_r=a96fb7d6-963c-4962-a816-c36c0e9704d0&pd_rd_wg=Z51ND&pd_rd_i=B07TW1KFKM&psc=1"
nombre<-"#productTitle"
pagina_online<-read_html(urlz)
nombre_nodo<-html_node(pagina_online, nombre)
nombre_texto<-html_text(nombre_nodo)
nombre_texto

precio<-"#priceblock_ourprice"
precio_nodo<-html_node(pagina_online, precio)
precio_texto<-html_text(precio_nodo)
precio_texto

acerca<-"#feature-bullets"
acerca_nodo<-html_node(pagina_online, acerca)
acerca_texto<-html_text(acerca_nodo)
acerca_texto

describir<-"#productDescription > p"
describir_nodo<-html_node(pagina_online, describir)
describir_texto<-html_text(describir_nodo)
describir_texto

tabla<-"#productDetails_techSpec_section_1"
tabla_nodo<-html_node(pagina_online, tabla)
tabla_tab<-html_table(tabla_nodo)
tabla_tab
class(tabla_tab)
val<-tabla_tab$X2
val
res_tabla<-data.frame(t(val))
res_tabla
tabla_name<-tabla_tab$X1
tabla_name
colnames(res_tabla)<-tabla_name
res_tabla
str(res_tabla)

resultado_arroz<-c(as.character(res_tabla$Marca), as.character(res_tabla$Ingredients), as.character(res_tabla$Porción), as.character(res_tabla$`País de origen`), as.character(res_tabla$`Peso del producto`), as.character(res_tabla$`Dimensiones del producto`), as.character(res_tabla$`Tipo de envase`))
resultado_arroz                   

get_articulo<-function(urlz){
  print(urlz)
  nombre<-"#productTitle"
  pagina_online<-read_html(urlz)
  nombre_nodo<-html_node(pagina_online, nombre)
  nombre_texto<-html_text(nombre_nodo)
  nombre_texto
  
  precio<-"#priceblock_ourprice"
  precio_nodo<-html_node(pagina_online, precio)
  precio_texto<-html_text(precio_nodo)
  precio_texto
  
  acerca<-"#feature-bullets"
  acerca_nodo<-html_node(pagina_online, acerca)
  acerca_texto<-html_text(acerca_nodo)
  acerca_texto
  
  describir<-"#productDescription > p"
  describir_nodo<-html_node(pagina_online, describir)
  describir_texto<-html_text(describir_nodo)
  describir_texto
  
  tabla<-"#productDetails_techSpec_section_1"
  tabla_nodo<-html_node(pagina_online, tabla)
  if(!is.na(tabla_nodo)){
    tabla_tab<-html_table(tabla_nodo)
    tabla_tab
    class(tabla_tab)
    val<-tabla_tab$X2
    val
    res_tabla<-data.frame(t(val))
    res_tabla
    tabla_name<-tabla_tab$X1
    tabla_name
    colnames(res_tabla)<-tabla_name
    res_tabla
  }
  

  col<-c("Marca", "Ingredients", "Porción", "País de origen", "Peso del producto", "Dimensiones del producto", "Tipo de envase" )
  if(length(res_tabla)==0){
    #no hay detalles todo a -1
    mitab<-data.frame(colnames(col))
    mitab<-rbind(mitab, c("-1", "-1", "-1", "-1", "-1", "-1", "-1"))
    colnames(mitab)<-col
  }else{
    #evaluar cada uno de los atributos
    zero<-matrix("-1", ncol=7, nrow = 1)
    dfzero<-as.data.frame(zero)
    colnames(dfzero)<-col
    marca<-as.character(res_tabla$Marca)
    if(length(marca)==0) marca<- "1"
    ingredientes<-as.character(res_tabla$Ingredients)
    if(length(ingredientes)==0) ingredientes<- "1"
    porcion<-as.character(res_tabla$Porción)
    if(length(porcion)==0) porcion<- "1"
    pais<-as.character(res_tabla$`País de origen`)
    if(length(pais)==0) pais<- "1"
    peso<-as.character(res_tabla$`Peso del producto`)
    if(length(peso)==0) peso<- "1"
    dimension<-as.character(res_tabla$`Dimensiones del producto`)
    if(length(dimension)==0) dimension<- "1"
    envase<-as.character(res_tabla$`Tipo de envase`)
    if(length(envase)==0) envase<- "1"
    dfzero$Marca<-marca
    dfzero$Ingredients<-ingredientes
    dfzero$Porción<-porcion
    dfzero$`País de origen`<-pais
    dfzero$`Peso del producto`<-peso
    dfzero$`Dimensiones del producto`<-dimension
    dfzero$`Tipo de envase`<-envase
    mitab<-dfzero
    colnames(mitab)<-col
    
    
  }
  articulo<-c(nombre_texto, precio_texto, acerca_texto, describir_texto, as.character(res_tabla$Marca), as.character(res_tabla$Ingredients), as.character(res_tabla$Porción), as.character(res_tabla$`País de origen`), as.character(res_tabla$`Peso del producto`), as.character(res_tabla$`Dimensiones del producto`), as.character(res_tabla$`Tipo de envase`))
  articulo
}

resul<-get_articulo(amzprersult[67])
resul

resultadototalamazon<-sapply(amzprersult, get_articulo)
resultadototalamazon

class(resultadototalamazon)
dim(resultadototalamazon)
resy<-t(resultadototalamazon)
resy
View(resultadototalamazon)
dim(resultadototalamazon)

crearamatriz<-matrix(unlist(resultadototalamazon), ncol = 1)
crearamatriz
pre<-t(crearamatriz)
View(pre)
dim(pre)
archivo<-as.data.frame(pre)
archivo
colnames(pre)<-c(1:105)
rownames(pre)<-c('beneficios', 'descripción', 'precio', 'Marca', 'Ingredientes', 'Porción', 'País de origen', 'Peso del producto', 'Dimensiones del producto', 'Tipo de envase')
View(pre)