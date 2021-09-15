# two-file-analysis_1.R

# Load packages from library ----

library(ggplot2)

# Read first file ----

lns <- readLines( "data/spacy_1.csv" )
lns <- lns[ -2 ] # remove the second line
connection <- textConnection( lns )
dta1 <- read.table( connection
                  , header = TRUE
                  , sep = ","
                  )
close( connection )

# Categorize points in first file

ybreak <- 0.98 * max( dta1$Y )
dta1$segment <- ifelse( ybreak < dta1$Y, "Horizontal", "Sloped" )

# View (output) first plot ----

ggplot( dta1, aes( x = X, y = Y ) ) +
  geom_point( size = 0.5, alpha = 0.3 ) +
  geom_vline( xintercept = 500, colour = "red" ) +
  geom_hline( yintercept = c( 500, 900 ), colour = c( "blue", "darkgreen" ) )

# Analyze first file ----

slope_fit <- lm( Y ~ X
               , data = dta1
               , subset = "Sloped" == segment
               )
slope_coefs <- coef( slope_fit )
Slope <- as.vector( slope_coefs[ "X" ] )
Offset <- as.vector( slope_coefs[ "(Intercept)" ] )
Mean <- mean( dta1$Y[ "Horizontal" == dta1$segment ] )
result1 <- data.frame( Slope = Slope, Offset = Offset, Mean = Mean )

# Read second file ----

lns <- readLines( "data/spacy_2.csv" )
lns <- lns[ -2 ] # remove the second line
connection <- textConnection( lns )
dta2 <- read.table( connection
                  , header = TRUE
                  , sep = ","
                  )
close( connection )

# Categorize points in first file

ybreak <- 0.98 * max( dta2$Y )
dta2$segment <- ifelse( ybreak < dta2$Y, "Horizontal", "Sloped" )

# Output second plot ----

ggplot( dta2, aes( x = X, y = Y ) ) +
  geom_point( size = 0.5, alpha = 0.3 ) +
  geom_vline( xintercept = 250, colour = "red" ) +
  geom_hline( yintercept = c( 500, 1050 ), colour = c( "blue", "darkgreen" ) )

# Analyze second file ----

slope_fit <- lm( Y ~ X
               , data = dta2
               , subset = "Sloped" == segment
               )
slope_coefs <- coef( slope_fit )
Slope <- as.vector( slope_coefs[ "X" ] )
Offset <- as.vector( slope_coefs[ "(Intercept)" ] )
Mean <- mean( dta2$Y[ "Horizontal" == dta2$segment ] )
result2 <- data.frame( Slope = Slope, Offset = Offset, Mean = Mean )

# Combine results ----

# Label individual result rows and combine them
results <- rbind( cbind( Source = "spacy_1.csv"
                       , result1
                       )
                , cbind( Source = "spacy_2.csv"
                       , result2
                       )
                )

# Output results file ----

write.csv( results
         , file = "two-file-results_1.csv"
         , row.names = FALSE
         , quote = FALSE
         )
