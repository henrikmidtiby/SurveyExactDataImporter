# SurveyExactDataImporter

The goal of SurveyExactDataImporter is to ...

## Installation

You can install the released version of SurveyExactDataImporter from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("SurveyExactDataImporter")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
data <- load('../testdata/dataset_1172477_20170127_356700854610526206.xlsx')

get_variable_name(data, 's_73')
get_variable_name_category(data, 's_73')
get_variable_name_subcategory(data, 's_73')

ggplot(data$data) + 
  geom_bar(aes(s_73)) + 
  scale_x_discrete(drop=FALSE) +
  coord_flip() + 
  labs(subtitle = get_variable_name(data, 's_73'), 
       x = "")
```

