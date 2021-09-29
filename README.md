
<!-- README.md is generated from README.Rmd. Please edit that file -->

# prereviewr <a href='https://dmi3kno.github.io/prereviewr'><img src='man/figures/logo.png' align="right" height="200" /></a>

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of prereviewr is to use the official API to access
(pre-)reviews from PREreview.org

> PREreview’s mission is to bring more equity and transparency to
> scholarly peer review by supporting and empowering communities of
> researchers, particularly those at early stages of their career (ECRs)
> and historically excluded, to review preprints in a process that is
> rewarding to them.

PREreview.org allows anyone to request a review for any published
preprint and submit reviews for preprints contributed by other users.
Because reviews are done prior to publication in an academic journal
they are called “(pre-)reviews”. Crowd-sourcing reviews prior to
publication enables “constructive feedback to preprints at a point in
time in which it is needed”
([PREreview.org](https://content.prereview.org/mission/)).

## Installation

You can install the development version of prereviewr from
[Github](https://github.com/dmi3kno/prereviewr) with:

``` r
# install.packages("remotes")
remotes::install_github("dmi3kno/prereviewr")
```

The package subscribes to [polite](https://github.com/dmi3kno/polite)
web-scraping principles and therefore the requests are made with
authentication and an explicit user-agent, requests are delayed,
responses are memoised. The permission to scrape is granted by [official
API](https://content.prereview.org/api/). The package only accesses the
endpoints allowed by the API and does not perform any scraping of
webpages.

## Authentication

Registration of API token on PREreview.org in free. If you are
submitting preprints or reviews to the platform, you already have an
account. Otherwise, go ahead and register. Then proceed to your [API
settings](https://prereview.org/settings/api). There you can create a
valid API key. Then you need to add the following two lines into your
`.Renviron` using `usethis::edit_r_environ()`

``` r
PREREVIEW_APP=YOURAPPNAME
PREREVIEW_KEY=YOUR-KEY-FOUR-PARTS
```

Restart R and you should be good to go.

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(prereviewr)
## basic example code
```

### Preprints

You can fetch 10 latest preprints submitted to PREreview.org. The
function returns a tibble with one row per preprint. There are some (so
far unparsed) list columns which contain information about reviews

``` r
get_preprints()
#> # A tibble: 10 × 17
#>    uuid   createdAt  updatedAt  handle title  authors  isPublished abstractText 
#>    <chr>  <chr>      <chr>      <chr>  <chr>  <chr>    <lgl>       <chr>        
#>  1 9d891… 2021-09-2… 2021-09-2… doi:1… Hybri… Dmytro … TRUE        "<p>This pap…
#>  2 ac0dc… 2021-09-1… 2021-09-1… doi:1… The t… Dmytro … TRUE        "<p>This pap…
#>  3 69b43… 2021-09-1… 2021-09-1… doi:1… A vir… Meetali… TRUE        "SARS-CoV-2 …
#>  4 ae3af… 2021-09-2… 2021-09-2… doi:1… Codin… Sami I.… TRUE        "The ability…
#>  5 2ff48… 2021-09-0… 2021-09-0… doi:1… Measu… Garcıa-… TRUE        "Reviewers d…
#>  6 40d04… 2021-09-0… 2021-09-0… doi:1… Coord… See-Yeu… TRUE        "Bacterial s…
#>  7 12728… 2021-08-2… 2021-08-2… doi:1… Precl… Manolo … TRUE        "The COVID-1…
#>  8 944f0… 2021-08-0… 2021-08-0… doi:1… Plasm… Denise … TRUE        "Early cance…
#>  9 a398c… 2021-08-1… 2021-08-1… doi:1… Influ… Lukasz … TRUE        "The SARS-Co…
#> 10 25e93… 2021-07-1… 2021-07-1… doi:1… Borgs… Basem A… TRUE        "Anaerobic m…
#> # … with 9 more variables: preprintServer <chr>, datePosted <chr>,
#> #   publication <chr>, url <chr>, requests <list>, contentEncoding <chr>,
#> #   contentUrl <chr>, rapidReviews <list>, fullReviews <list>
```

It is also possible to search

``` r
get_preprints("perepolkin")
#> # A tibble: 2 × 13
#>   uuid   createdAt  updatedAt  handle  title  authors  isPublished abstractText 
#>   <chr>  <chr>      <chr>      <chr>   <chr>  <chr>    <lgl>       <chr>        
#> 1 9d891… 2021-09-2… 2021-09-2… doi:10… Hybri… Dmytro … TRUE        "<p>This pap…
#> 2 ac0dc… 2021-09-1… 2021-09-1… doi:10… The t… Dmytro … TRUE        "<p>This pap…
#> # … with 5 more variables: preprintServer <chr>, datePosted <chr>,
#> #   publication <chr>, url <chr>, requests <list>
```

Individual preprint can be fetched with the following command. You can
use the preprint DOI or PREreview UUID.

``` r
#get_preprint("ac0dc5be-4e85-424c-8659-d9c588b7dbc5")
get_preprint("10.31219/osf.io/enzgs")
#> # A tibble: 1 × 13
#>   uuid   createdAt  updatedAt  handle  title  authors  isPublished abstractText 
#>   <chr>  <chr>      <chr>      <chr>   <chr>  <chr>    <lgl>       <chr>        
#> 1 ac0dc… 2021-09-1… 2021-09-1… doi:10… The t… Dmytro … TRUE        "<p>This pap…
#> # … with 5 more variables: preprintServer <chr>, datePosted <chr>,
#> #   publication <chr>, url <chr>, requests <list>
```

### Reviews

You can also fetch to latest (rapid) reviews

``` r
get_reviews()
#> # A tibble: 10 × 20
#>    uuid     createdAt   updatedAt  author preprint isPublished isFlagged ynNovel
#>    <chr>    <chr>       <chr>      <list> <list>   <lgl>       <lgl>     <chr>  
#>  1 c3e8220… 2021-09-28… 2021-09-2… <name… <named … FALSE       FALSE     yes    
#>  2 b36e04e… 2021-09-25… 2021-09-2… <name… <named … FALSE       FALSE     yes    
#>  3 afacd40… 2021-09-24… 2021-09-2… <name… <named … FALSE       FALSE     unsure 
#>  4 05bcbf9… 2021-09-23… 2021-09-2… <name… <named … FALSE       FALSE     yes    
#>  5 35b19fe… 2021-09-21… 2021-09-2… <name… <named … FALSE       FALSE     yes    
#>  6 88b6a89… 2021-09-18… 2021-09-1… <name… <named … FALSE       FALSE     yes    
#>  7 061c32b… 2021-09-17… 2021-09-1… <name… <named … FALSE       FALSE     yes    
#>  8 3ff9302… 2021-09-16… 2021-09-1… <name… <named … FALSE       FALSE     yes    
#>  9 9e7003d… 2021-09-13… 2021-09-1… <name… <named … FALSE       FALSE     N/A    
#> 10 aabc33f… 2021-09-06… 2021-09-0… <name… <named … FALSE       FALSE     yes    
#> # … with 12 more variables: ynFuture <chr>, ynReproducibility <chr>,
#> #   ynMethods <chr>, ynCoherent <chr>, ynLimitations <chr>, ynEthics <chr>,
#> #   ynNewData <chr>, ynRecommend <chr>, ynPeerReview <chr>,
#> #   ynAvailableCode <chr>, ynAvailableData <chr>, linkToData <chr>
```

Not all rapid reviews will be accompanied by a full review. The latest
full reviews can be fetched with

``` r
get_reviews(full=TRUE)
#> # A tibble: 10 × 9
#>    uuid  createdAt updatedAt isPublished isFlagged doi   drafts authors preprint
#>    <chr> <chr>     <chr>     <lgl>       <lgl>     <chr> <list> <list>  <list>  
#>  1 09b2… 2021-09-… 2021-09-… TRUE        FALSE     10.5… <list… <list … <named …
#>  2 da5c… 2021-09-… 2021-09-… FALSE       FALSE     <NA>  <list… <list … <named …
#>  3 7c54… 2021-09-… 2021-09-… FALSE       FALSE     <NA>  <list… <list … <named …
#>  4 1c36… 2021-09-… 2021-09-… FALSE       FALSE     <NA>  <list… <list … <named …
#>  5 f870… 2021-09-… 2021-09-… FALSE       FALSE     <NA>  <list… <list … <named …
#>  6 2733… 2021-09-… 2021-09-… TRUE        FALSE     10.5… <list… <list … <named …
#>  7 c249… 2021-09-… 2021-09-… TRUE        FALSE     10.5… <list… <list … <named …
#>  8 4794… 2021-09-… 2021-09-… TRUE        FALSE     10.5… <list… <list … <named …
#>  9 3973… 2021-08-… 2021-08-… TRUE        FALSE     10.5… <list… <list … <named …
#> 10 5dfa… 2021-08-… 2021-08-… TRUE        FALSE     <NA>  <list… <list … <named …
```

If you are eagerly waiting for reviews for a preprint of interest you
can check if any reviews have been recently submitted with

``` r
get_preprint_reviews("0043ad51-5bb9-4f67-9c70-617ca5e8efd9")
#> # A tibble: 1 × 20
#>   uuid     createdAt   updatedAt   author preprint isPublished isFlagged ynNovel
#>   <chr>    <chr>       <chr>       <list> <list>   <lgl>       <lgl>     <chr>  
#> 1 05bcbf9… 2021-09-23… 2021-09-23… <name… <named … FALSE       FALSE     yes    
#> # … with 12 more variables: ynFuture <chr>, ynReproducibility <chr>,
#> #   ynMethods <chr>, ynCoherent <chr>, ynLimitations <chr>, ynEthics <chr>,
#> #   ynNewData <chr>, ynRecommend <chr>, ynPeerReview <chr>,
#> #   ynAvailableCode <chr>, ynAvailableData <chr>, linkToData <chr>
```
