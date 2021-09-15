# two-file-analysis_funcs.R

my_spacy_reader <- function( fname ) {
  lns <- readLines( fname )
  lns <- lns[ -2 ] # removes the second element
  connection <- textConnection( lns )
  dta <- read.table( connection
                     , header = TRUE
                     , sep = ","
  )
  close( connection )
  dta  # have to return what we obtained
  # after closing the connection
}


my_bent_qc <- function( dta, y_break_maxfrac ) {
  ybreak <- max( dta$Y ) * y_break_maxfrac
  dta$segment <- factor( ifelse( dta$Y < ybreak
                               , "Sloped"
                               , "Horizontal" )
                    , levels = c( "Sloped", "Horizontal" )
  )
  dta
}

my_analysis <- function( dta ) {
  slope_fit <- lm( Y ~ X
                 , data = dta
                 , subset = "Sloped" == segment
                 )
  slope_coefs <- coef( slope_fit )
  Slope <- as.vector( slope_coefs[ "X" ] )
  Offset <- as.vector( slope_coefs[ "(Intercept)" ] )
  Mean <- mean( dta$Y[ "Horizontal" == dta$segment ] )
  result <- data.frame( Slope = Slope
                      , Offset = Offset
                      , Mean = Mean
                      )
  result
}


my_collect_results <- function( result1, result_label1
                              , result2, result_label2 ) {
  results <- rbind( cbind( Source = result_label1
                         , result1
                         )
                  , cbind( Source = result_label2
                         , result2
                         )
                  )
  results
}


my_write_results <- function( results, file ) {
  write.csv( results
           , file = file
           , row.names = FALSE
           , quote = FALSE
  )
}
