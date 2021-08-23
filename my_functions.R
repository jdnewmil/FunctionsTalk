# my_functions.R
my_rss2 <- function( x ) { # first added line with argument
  y <- x^2                 # untouched code
  y                        # untouched code
  ysum <- sum( y )         # untouched code
  ysum                     # untouched code
  result <- sqrt( ysum )   # untouched code
  result                   # untouched code
}                          # end of function body

my_rss3 <- function( x ) { # first added line with argument
  y <- x^2                 # untouched code
  ysum <- sum( y )         # untouched code
  sqrt( ysum )             # don't bother to put the result into a variable 
}                          # end of function body


my_spacy_reader <- function( fname ) {
  lns <- readLines( fname )
  lns <- lns[ -2 ]
  connection <- textConnection( lns )
  dta <- read.table( connection
                     , header = TRUE
                     , sep = ","
  )
  close( connection )
  dta  # have to return what we obtained after closing the connection
}
