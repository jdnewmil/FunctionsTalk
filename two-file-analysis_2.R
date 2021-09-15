# two-file-analysis_2.R

library(ggplot2)
source("two-file-analysis_funcs.R")

y_break_maxfrac <- 0.98

# First dataset ----
raw_dta_1 <- my_spacy_reader( "data/spacy_1.csv" )
labelled_dta_1 <- my_bent_qc( dta = raw_dta_1
                            , y_break_maxfrac = y_break_maxfrac
                            )
result_1 <- my_analysis( labelled_dta_1 )

# Second dataset ----
raw_dta_2 <- my_spacy_reader( "data/spacy_2.csv" )
labelled_dta_2 <- my_bent_qc( dta = raw_dta_2
                            , y_break_maxfrac = y_break_maxfrac
                            )
result_2 <- my_analysis( labelled_dta_2 )

# Combine results ----
results <- my_collect_results( result1 = result_1
                             , result_label1 = "spacy_1.csv"
                             , result2 = result_2
                             , result_label2 = "spacy_2.csv" )

# Write results to csv ----
my_write_results( results = results
                , file = "two-file-results_2.csv"
                )
