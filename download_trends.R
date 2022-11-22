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
