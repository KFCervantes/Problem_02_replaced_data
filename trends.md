Finding Trends
================
December 2, 2022

This file is for testing out `gtrendsR` and finding more trends to use.
First, the libraries are loaded.

``` r
library(tidyverse)
library(gtrendsR)
```

Now, the `gtrendsR` package includes a `categories` dataset that gives
the name of a trend category and its id.

``` r
head(categories)
```

                                  name   id
    1                   All categories    0
    3             Arts & Entertainment    3
    5 Celebrities & Entertainment News  184
    6               Comics & Animation  316
    8                   Animated Films 1104
    9                    Anime & Manga  317

Now two things I enjoy on a near-daily basis are coffee and podcasts. I
decided to search these in Google Trends. The results were stored in
`trend_data.csv`. This was done in a different R script to avoid having
it run whenever the document is rendered.

``` r
library(tidyverse)

# trends to search
c("podcast", "coffee") %>%
  
  gtrendsR::gtrends(
    
    # limit results to US only
    geo = "US",
    
    # only search trends for last hour
    time = "now 1-H",
    
    # only download interest data
    onlyInterest = TRUE
  )  %>%
  
  # the above returns a 1-item list
  # this extracts the first list element
  # this first element is a data frame
  `[[`(1) %>%
  
  # select columns and rename
  select(keyword, date, hits) %>%
  rename(
    type = keyword,
    close = hits
  ) %>%
  
  # save trend data
  write_csv("data/trend_data.csv")
```

This data is now previewed.

``` r
read_csv("data/trend_data.csv") %>%
  head()
```

    # A tibble: 6 × 3
      type    date                close
      <chr>   <dttm>              <dbl>
    1 podcast 2022-11-22 00:29:00    13
    2 podcast 2022-11-22 00:30:00    17
    3 podcast 2022-11-22 00:31:00    13
    4 podcast 2022-11-22 00:32:00    27
    5 podcast 2022-11-22 00:33:00    24
    6 podcast 2022-11-22 00:34:00    20
