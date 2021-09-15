# two-file-analysis_3.R

library(ggplot2)
source("two-file-analysis_funcs.R")

y_break_maxfrac <- 0.98

# First dataset ----
result_1 <- (   "data/spacy_1.csv"
            |> my_spacy_reader()
            |> my_bent_qc( y_break_maxfrac = y_break_maxfrac )
            |> my_analysis()
            )

# Second dataset ----
result_2 <- (   "data/spacy_1.csv"
            |> my_spacy_reader()
            |> my_bent_qc( y_break_maxfrac = y_break_maxfrac )
            |> my_analysis()
            )

# Combine results ----
results <- my_collect_results( result1 = result_1
                             , result_label1 = "spacy_1.csv"
                             , result2 = result_2
                             , result_label2 = "spacy_2.csv" )

# Write results to csv ----
my_write_results( results = results
                , file = "two-file-results_3.csv"
                )
