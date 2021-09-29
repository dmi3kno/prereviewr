#remotes::install_github("dmi3kno/polite")
#polite::use_manners()

validate_authentication <- function(){
  if(getOption("prereviewr.apiname")=="" ||
     getOption("prereviewr.apikey")=="")
    stop(paste("Error! Valid API key is not found!",
               "\nPlease go to https://prereview.org/settings/api and",
               "register your API key. Then open .Renviron",
               "using usethis::edit_r_environ() and add these",
               "two lines (without quotes):\n",
               "PREREVIEW_APP=<yourappname>\n",
               "PREREVIEW_KEY=<yourkey>\n",
               "Then restart your R session and try again."))
  invisible(return(TRUE))
}
#' @importFrom httr GET
polite_get <- function(url, user_agent, delay, ...){
  Sys.sleep(delay)
  res <- httr::GET(url, c( httr::user_agent(user_agent),
                                   httr::accept_json(), httr::content_type_json(),
                                   httr::add_headers(.headers = c(
                                     "X-API-App"=getOption("prereviewr.apiname"),
                                     "X-API-Key"= getOption("prereviewr.apikey")))
  ), ...)
}

#' @importFrom memoise  memoise
mem_polite_get <- memoise::memoise(polite_get)

#' @importFrom httr user_agent accept_json content_type_json add_headers stop_for_status content
fetch_prrwr_data <- function(request_url,..., delay=getOption("prereviewr.delay"), authenticate=FALSE){
 user_agent <- paste("polite", getOption("HTTPUserAgent"), "bot")
  res <- mem_polite_get(request_url, user_agent, delay, ...)
 #  options("HTTPUserAgent"= old_ua)
 httr::stop_for_status(res,task = "fetching the data")
 httr::content(res)
 }

#' @importFrom tibble tibble
#' @importFrom tidyr unnest_wider
tidy_prrwr_response <- function(res){
  if(!is.list(res)) return(NULL)
  tidyr::unnest_wider(tibble::tibble(res_lst=res[["data"]]), "res_lst")
}

