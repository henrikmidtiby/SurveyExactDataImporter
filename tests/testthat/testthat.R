library(testthat)
library(SurveyExactDataImporter)

context("SurveyExactDataImporter")


test_that('Data can be loaded', {
  expect_is(load_survey_exact_data("data/dataset.xlsx"), 'list')
  expect_error(load_survey_exact_data("file_that_does_not_exist.xlsx"))
})

test_that('Variable descriptions can be reached', {
  data <- load_survey_exact_data("data/dataset.xlsx")
  expect_equal(get_variable_name(data, 's_6'),
               'Question battery - Element one')
  expect_equal(get_variable_name_category(data, 's_6'),
               'Question battery')
  expect_equal(get_variable_name_subcategory(data, 's_6'),
               'Element one')
})
