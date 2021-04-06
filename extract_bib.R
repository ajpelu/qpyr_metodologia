library(dplyr)
library(stringr)

extract_bibkeys <- function(path){
  f <- readLines(path)
  raw <- stringr::str_extract_all(string = f, pattern = "\\@[a-zA-z0-9]*") %>%
    unlist() %>%
    str_remove_all("]") %>%
    data.frame()
  names(raw) <- "bibkey"
  return(raw)
}


o <- extract_bibkeys("/Users/ajpelu/Dropbox/phd/phd_repos/qpyr_dendro/man/ecosystems/ms_ecosystems.Rmd")


oo <- o %>% group_by(bibkey) %>% count()




file <- "/Users/ajpelu/Google Drive/_phd/01_metodologias/qp/zona-estudio.Rmd"
doc <- readLines(file)
the_entry <- yaml_front_matter(file)$bibliography # refs.bib


read_bib <- function(x) {
  if(str_starts(x, "`r ") == TRUE) {
    ht <- str_remove_all(the_entry, "`")
    ht <- str_remove(ht, "r ")

    ht <- bib2df(eval(parse(text=ht)))
    return(ht)
  } else {
    ht <- bib2df(the_entry)
    return(ht)
  }
}

cites <- c()

for(i in 1:length(doc)) {
  hold_this <- as.data.frame(str_match_all(doc[i], "@([[:alnum:]:&!~=_+-]+)")[[1]])
  cites <- bind_rows(cites, hold_this)
}
