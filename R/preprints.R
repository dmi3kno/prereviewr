#' Fetch one or multiple preprints
#'
#' @param search character search string
#' @param limit numeric limit results to. Default is 10
#' @param communities character string for name of community
#' @param filters other character string
#' @param tags character string for tags
#' @param ... other arguments passed to httr::GET
#'
#' @return list of preprints
#' @rdname preprint
#' @export
#'
#' @examples
get_preprints <- function(search=NULL, limit=10, communities=NULL, filters=NULL, tags=NULL,...){
  base_url <- paste0(getOption("prereviewr.apipath"), "/preprints")
  args <- c(search=search, limit=limit, communities=communities, filters=filters, tags=tags)
  url1 <- httr::modify_url(base_url,query = as.list(args))
  res <- fetch_prrwr_data(url1,...)
  tidy_prrwr_response(res)
}


#' @param pid doi or uuid of preprint
#'
#' @return list with a single preprint
#' @rdname preprint
#' @export
#'
#' @examples
get_preprint <- function(pid,...){
  base_url <- paste0(getOption("prereviewr.apipath"), "/preprints")
  id_non_url <- gsub("^.*doi.org/", "", pid)
  if(grepl("^10\\.\\d+\\/.+", id_non_url)) # this is doi
    id_non_url <- paste0("doi-",gsub("/","-", id_non_url, perl = TRUE))
  url1 <- paste0(base_url, "/", id_non_url)
  res <- fetch_prrwr_data(url1,...)
  tidy_prrwr_response(res)
}

