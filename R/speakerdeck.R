#' @export
getInfo <- function(urls){
  require(rvest)
  res <- NULL
  for(u in urls){
    page <- html(u)
    title <- page %>% html_node("div#talk-details header h1") %>% html_text()
    name <- page %>% html_node("div#talk-details header h2 a") %>% html_text()
    date <- page %>% html_node("div#talk-details header p mark") %>% html_text()
    vs <- page %>% html_node("li.views span") %>% html_text()
    vs <- gsub(",|[[:space:]].+", "", vs) %>% as.numeric()
    tmp <- Sys.getlocale("LC_TIME")
    Sys.setlocale("LC_TIME", "C")
    date <- as.Date(date, "%B %d, %Y")
    Sys.setlocale("LC_TIME", tmp)
    res0 <- data.frame(title=title, name=name, date=date, views=vs, url=u, stringsAsFactors=FALSE)
    res <- rbind(res, res0)
  }
  return(res)
}