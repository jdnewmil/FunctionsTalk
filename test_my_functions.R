# test_my_functions.R
library(testthat)
source( "my_functions.R" )

test_that( "my_rss2", {
  answer1 <- my_rss2( 1:4 )
  expect_equal( answer1, 5.477226, tolerance = 1e-5 )
})
test_that( "my_rss3", {
  answer1 <- my_rss3( 1:4 )
  expect_equal( answer1, 5.477226, tolerance = 1e-5 )
})
test_that( "my_spacy_reader", {
  dta1 <- my_spacy_reader( "data/spacy_1.csv" )
  expect_s3_class( dta1, "data.frame" )
  expect_equal( ncol( dta1 ), 2 )
  expect_equal( nrow( dta1 ), 1201 )
  expect_true( is.numeric( dta1[[ 1 ]] ) )
  expect_true( is.numeric( dta1[[ 2 ]] ) )
})
