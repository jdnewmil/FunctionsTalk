# setup.R

# used for generating the sample data for the presentation

suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(ggplot2)
  library(purrr)
})

#' Create a bent data profile
#' 
#' @param N Integer scalar, number of rows in output
#' @param m Numeric scalar, slope of line
#' @param mx Numeric scalar, clipping value
#' @param s Numeric scalar, standard deviation of additive noise
#' @param colname1 Character scalar, name of independent variable
#' @param colname2 Character scalar, name of dependent variable
make_bent_data <- function( x, m, mx, s, colname1, colname2 ) {
  y <- pmin( mx, x * m )
  y <- y + rnorm( length( x ), 0, s )
  DF <- data.frame( x = x
                  , y = y
                  )
  setNames( DF, c( colname1, colname2 ) )
}

write_spacy_csv <- function( DF, fname ) {
  con <- textConnection( "s", "w", local = TRUE )
  write.table( DF, file = con, sep = ",", row.names = FALSE, quote = FALSE )
  close( con )
  con <- file( fname, open = "w" )
  writeLines( c( s[ 1 ], "header info" ), con )
  writeLines( s[ -1 ], con )
  close( con )
}

x <- 0:1200
s <- 2
set.seed(42)
dta <- (   data.frame( fname = paste0( "spacy_", 1:2, ".csv" )
                     , m = 1:2
                     , mx = c( 900, 1050 )
                     )
       %>% rowwise()
       %>% mutate( data = list( make_bent_data( x
                                              , m = m
                                              , mx = mx
                                              , s = s
                                              , colname1 = "X"
                                              , colname2 = "Y"
                                              )
                              )
                 )
       %>% ungroup()
       )

(   dta
%>% unnest( cols = "data" )
%>% ggplot( aes( x = X, y = Y, colour = fname ) ) ) +
  geom_point()

(   dta
%>% select( fname, data )
%>% pwalk( function( fname, data ) {
              write_spacy_csv( data, file.path( "data", fname ) )
           }
         )
)

