#' Fetch one or multiple reviews
#'
#' @param limit numeric limit results to. Default is 10
#' @param full logical. Should full reviews or only rapid reviews be fetched. Default is FALSE
#' @param ... other arguments passed to httr::GET
#'
#' @return list of preprints
#' @rdname reviews
#' @export
#'
#' @examples
get_reviews <- function(limit=10, full=FALSE,...){
  base_url <- paste0(getOption("prereviewr.apipath"), "/rapid-reviews")
  if(full)   base_url <- paste0(getOption("prereviewr.apipath"), "/full-reviews")
  args <- c(limit=limit)
  url1 <- httr::modify_url(base_url,query = as.list(args))
  res <- fetch_prrwr_data(url1,...)
  tidy_prrwr_response(res)
}


#' @param rid uuid of the review
#'
#' @return list with a single preprint
#' @rdname reviews
#' @export
#'
#' @examples
get_review <- function(rid, full=FALSE, ...){
  base_url <- paste0(getOption("prereviewr.apipath"), "/rapid-reviews")
  if(full)   base_url <- paste0(getOption("prereviewr.apipath"), "/full-reviews")
  url1 <- paste0(base_url, "/", rid)
  res <- fetch_prrwr_data(url1,...)
  if(!is.list(res)) return(NULL)
  tidy_prrwr_response(res)
}

#' @param pid doi or uuid of the preprint
#'
#' @return list with a single preprint
#' @rdname reviews
#' @export
#'
#' @examples
get_preprint_reviews <- function(pid, limit=10, full=FALSE, ...){
  id_non_url <- gsub("^.*doi.org/", "", pid)
  if(grepl("^10\\.\\d+\\/.+", id_non_url)) # this is doi
    id_non_url <- paste0("doi-",gsub("/","-", id_non_url, perl = TRUE))
  base_url <- paste0(getOption("prereviewr.apipath"),"/preprints/",id_non_url, "/rapid-reviews")
  if(full)   base_url <- paste0(getOption("prereviewr.apipath"),"/preprints/",id_non_url,"/full-reviews")
  args <- c(limit=limit)
  url1 <- httr::modify_url(base_url,query = as.list(args))
  res <- fetch_prrwr_data(url1,...)
  tidy_prrwr_response(res)
}
