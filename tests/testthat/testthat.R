library(testthat)
library(SurveyExactDataImporter)

context("SurveyExactDataImporter")
# test_check("SurveyExactDataImporter")


# Load example dataset
data <- load_survey_exact_data("../../data/dataset_1488637_20180512_1825827966544069436.xlsx")

