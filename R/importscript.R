library(readxl)
library(tidyverse)

load_survey_exact_data <- function(filename)
{
  survey_labels <- readxl::read_excel(filename, col_names = FALSE, sheet = 1) %>%
    dplyr::transmute(question_id = ..1,
                     value = ..2,
                     label = ..3)

  survey_variables <- readxl::read_excel(filename, col_names = TRUE, sheet = 2) %>%
    tidyr::extract(variableDescription,
                   c("category", "subcategory"),
                   "(.*) - (.*)",
                   remove = FALSE)

  survey_dataset <- readxl::read_excel(filename, col_names = TRUE, sheet = 3)

  survey_structure <- readxl::read_excel(filename, col_names = TRUE, sheet = 5)

  annotated_dataset <- survey_dataset
  comment(annotated_dataset) <- sprintf('Data loaded from the file "%s"', filename)

  question_ids <- survey_labels %>%
    dplyr::select(question_id) %>%
    unique()

  for (current_question_id in question_ids$question_id)
  {
    factor_levels <- survey_labels %>%
      dplyr::filter(question_id == current_question_id) %>%
      dplyr::mutate(modified_levels = sprintf('%.0f', value))

    annotated_dataset[, current_question_id] = factor(getElement(annotated_dataset, current_question_id),
                                                      levels = factor_levels$modified_levels,
                                                      labels = factor_levels$label)

    # This does not work at the moment. I would like to add the real variable name as
    # a comment to the column.
    # comment(annotated_dataset[, current_question_id]) <- get_variable_name(current_question_id)
  }

  list(survey_labels = survey_labels,
       survey_variables = survey_variables,
       survey_dataset = survey_dataset,
       survey_structure = survey_structure,
       data = annotated_dataset)
}


get_variable_name <- function(data, identifier1) {
  data$survey_variables %>%
    dplyr::filter(variableName == identifier1) %>%
    dplyr::pull(variableDescription)
}

get_variable_name_category <- function(data, identifier) {
  data$survey_variables %>%
    dplyr::filter(variableName == identifier) %>%
    dplyr::pull(category)
}

get_variable_name_subcategory <- function(data, identifier) {
  data$survey_variables %>%
    dplyr::filter(variableName == identifier) %>%
    dplyr::pull(subcategory)
}
