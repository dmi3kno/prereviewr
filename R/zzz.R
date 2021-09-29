.onLoad <- function(libname, pkgname) {
  options(prereviewr.apipath='https://prereview.org/api/v2',
          prereviewr.apiname=Sys.getenv("PREREVIEW_APP"),
          prereviewr.apikey=Sys.getenv("PREREVIEW_KEY"),
          prereviewr.delay=3)
  validate_authentication()
}
