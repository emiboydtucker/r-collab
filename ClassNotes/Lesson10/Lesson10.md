Lesson10
================

``` r
install.packages("janitor", repos = "https://cloud.r-project.org")
```

    ## Installing package into 'C:/Users/emi.boyd-tucker/AppData/Local/R/win-library/4.6'
    ## (as 'lib' is unspecified)

    ## package 'janitor' successfully unpacked and MD5 sums checked
    ## 
    ## The downloaded binary packages are in
    ##  C:\Users\emi.boyd-tucker\AppData\Local\Temp\RtmpWsFM9h\downloaded_packages

``` r
# Attach packages
library(tidyverse)
```

    ## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ## ✔ dplyr     1.2.1     ✔ readr     2.2.0
    ## ✔ forcats   1.0.1     ✔ stringr   1.6.0
    ## ✔ ggplot2   4.0.3     ✔ tibble    3.3.1
    ## ✔ lubridate 1.9.5     ✔ tidyr     1.3.2
    ## ✔ purrr     1.2.2     
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()
    ## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
library(janitor)  ## install.packages("janitor")
```

    ## Warning: package 'janitor' was built under R version 4.6.1

    ## 
    ## Attaching package: 'janitor'
    ## 
    ## The following objects are masked from 'package:stats':
    ## 
    ##     chisq.test, fisher.test

Import datasets

``` r
lotr <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/lotr_tidy.csv")
```

    ## Rows: 18 Columns: 4
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (3): Film, Race, Gender
    ## dbl (1): Words
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
fship <- read.csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv")
```

``` r
ttow <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Two_Towers.csv")
```

    ## Rows: 3 Columns: 4
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (2): Film, Race
    ## dbl (2): Female, Male
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
rking <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Return_Of_The_King.csv")
```

    ## Rows: 3 Columns: 4
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (2): Film, Race
    ## dbl (2): Female, Male
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

\#gather these data

``` r
lotr_untidy <- bind_rows(fship, ttow, rking)
str(lotr_untidy)
```

    ## 'data.frame':    9 obs. of  4 variables:
    ##  $ Film  : chr  "The Fellowship Of The Ring" "The Fellowship Of The Ring" "The Fellowship Of The Ring" "The Two Towers" ...
    ##  $ Race  : chr  "Elf" "Hobbit" "Man" "Elf" ...
    ##  $ Female: num  1229 14 0 331 0 ...
    ##  $ Male  : num  971 3644 1995 513 2463 ...

\#tidy up the data by combining the gender columns

``` r
lotr_tidy <-
  pivot_longer(lotr_untidy, c(Male, Female), names_to = 'Gender', values_to = 'Words')

lotr_tidy
```

    ## # A tibble: 18 × 4
    ##    Film                       Race   Gender Words
    ##    <chr>                      <chr>  <chr>  <dbl>
    ##  1 The Fellowship Of The Ring Elf    Male     971
    ##  2 The Fellowship Of The Ring Elf    Female  1229
    ##  3 The Fellowship Of The Ring Hobbit Male    3644
    ##  4 The Fellowship Of The Ring Hobbit Female    14
    ##  5 The Fellowship Of The Ring Man    Male    1995
    ##  6 The Fellowship Of The Ring Man    Female     0
    ##  7 The Two Towers             Elf    Male     513
    ##  8 The Two Towers             Elf    Female   331
    ##  9 The Two Towers             Hobbit Male    2463
    ## 10 The Two Towers             Hobbit Female     0
    ## 11 The Two Towers             Man    Male    3589
    ## 12 The Two Towers             Man    Female   401
    ## 13 The Return Of The King     Elf    Male     510
    ## 14 The Return Of The King     Elf    Female   183
    ## 15 The Return Of The King     Hobbit Male    2673
    ## 16 The Return Of The King     Hobbit Female     2
    ## 17 The Return Of The King     Man    Male    2459
    ## 18 The Return Of The King     Man    Female   268

``` r
#4. Write the tidy data to a delimited file
#Now we write this multi-film, tidy dataset to file for use in various downstream scripts for further analysis and visualization.

#write_csv(lotr_tidy, path = "../datasets/lotr_tidy.csv")
#getting one variable per race
```

``` r
lotr_tidy %>%  
  pivot_wider(names_from = Race, values_from = Words)
```

    ## # A tibble: 6 × 5
    ##   Film                       Gender   Elf Hobbit   Man
    ##   <chr>                      <chr>  <dbl>  <dbl> <dbl>
    ## 1 The Fellowship Of The Ring Male     971   3644  1995
    ## 2 The Fellowship Of The Ring Female  1229     14     0
    ## 3 The Two Towers             Male     513   2463  3589
    ## 4 The Two Towers             Female   331      0   401
    ## 5 The Return Of The King     Male     510   2673  2459
    ## 6 The Return Of The King     Female   183      2   268

\#Separating gender columns

``` r
lotr_tidy %>% 
  pivot_wider(names_from = Gender, values_from = Words)
```

    ## # A tibble: 9 × 4
    ##   Film                       Race    Male Female
    ##   <chr>                      <chr>  <dbl>  <dbl>
    ## 1 The Fellowship Of The Ring Elf      971   1229
    ## 2 The Fellowship Of The Ring Hobbit  3644     14
    ## 3 The Fellowship Of The Ring Man     1995      0
    ## 4 The Two Towers             Elf      513    331
    ## 5 The Two Towers             Hobbit  2463      0
    ## 6 The Two Towers             Man     3589    401
    ## 7 The Return Of The King     Elf      510    183
    ## 8 The Return Of The King     Hobbit  2673      2
    ## 9 The Return Of The King     Man     2459    268

\#Unite gender and race columns

``` r
# let's get one variable per combo of Race and Gender
lotr_tidy %>% 
  unite(Race_Gender, Race, Gender) %>% 
  pivot_wider(names_from = Race_Gender, values_from = Words)
```

    ## # A tibble: 3 × 7
    ##   Film         Elf_Male Elf_Female Hobbit_Male Hobbit_Female Man_Male Man_Female
    ##   <chr>           <dbl>      <dbl>       <dbl>         <dbl>    <dbl>      <dbl>
    ## 1 The Fellows…      971       1229        3644            14     1995          0
    ## 2 The Two Tow…      513        331        2463             0     3589        401
    ## 3 The Return …      510        183        2673             2     2459        268

############################################################################## 

CORONAVIRUS

Applying this to our Coronavirus dataset \####Let’s now return to our
Coronavirus dataset. Let’s remind ourselves of it’s structure

``` r
coronavirus <- read_csv('https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv', col_types = cols(province = col_character()))

coronavirus
```

    ## # A tibble: 919,308 × 15
    ##    date       province country   lat  long type    cases   uid iso2  iso3  code3
    ##    <date>     <chr>    <chr>   <dbl> <dbl> <chr>   <dbl> <dbl> <chr> <chr> <dbl>
    ##  1 2020-01-22 Alberta  Canada   53.9 -117. confir…     0 12401 CA    CAN     124
    ##  2 2020-01-23 Alberta  Canada   53.9 -117. confir…     0 12401 CA    CAN     124
    ##  3 2020-01-24 Alberta  Canada   53.9 -117. confir…     0 12401 CA    CAN     124
    ##  4 2020-01-25 Alberta  Canada   53.9 -117. confir…     0 12401 CA    CAN     124
    ##  5 2020-01-26 Alberta  Canada   53.9 -117. confir…     0 12401 CA    CAN     124
    ##  6 2020-01-27 Alberta  Canada   53.9 -117. confir…     0 12401 CA    CAN     124
    ##  7 2020-01-28 Alberta  Canada   53.9 -117. confir…     0 12401 CA    CAN     124
    ##  8 2020-01-29 Alberta  Canada   53.9 -117. confir…     0 12401 CA    CAN     124
    ##  9 2020-01-30 Alberta  Canada   53.9 -117. confir…     0 12401 CA    CAN     124
    ## 10 2020-01-31 Alberta  Canada   53.9 -117. confir…     0 12401 CA    CAN     124
    ## # ℹ 919,298 more rows
    ## # ℹ 4 more variables: combined_key <chr>, population <dbl>,
    ## #   continent_name <chr>, continent_code <chr>

\###Last class, we visualized the global case counts date

``` r
coronavirus %>% 
  group_by(date, type) %>% filter(cases > 0) %>%
  summarize(cases = sum(cases)) %>%
  ggplot() +
  geom_col(aes(x = date, y = cases, fill = type))
```

    ## `summarise()` has regrouped the output.
    ## ℹ Summaries were computed grouped by date and type.
    ## ℹ Output is grouped by date.
    ## ℹ Use `summarise(.groups = "drop_last")` to silence this message.
    ## ℹ Use `summarise(.by = c(date, type))` for per-operation grouping
    ##   (`?dplyr::dplyr_by`) instead.

![](Lesson10_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->

\###Let’s see how we would do that if the data had been in a wider
format. \####Your turn \####Convert the coronavirus dataset to a wider
format where the confirmed cases, deaths and recovered cases are shown
in separate columns.

``` r
corona_wide <- coronavirus %>% filter(cases > 0) %>%
  pivot_wider(names_from = type, values_from = cases)
```

\####Now how do we reproduce the barchart of total cases per day broken
down by type?

\####And how would we plot the daily counts of different case types
within a country? With the long format this is easy:

``` r
coronavirus %>% filter(cases > 0) %>%
  filter(country == "US") %>% 
  ggplot() +
  geom_line(aes(x = date, y = cases, color = type))
```

![](Lesson10_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

\####How would we do this with the coronavirus_wide format? That would
be much more difficult

\####As mentioned above, however, there are plot types where the wide
format provides the best \####input. For example, in Slack, I showed the
example of plotting the total death count per \####country against the
total count of confirmed cases. It would be cumbersome to pull these out
of \####the long format because in ggplot we are mapping variables to
aesthetics and now we want to map \####different levels of a variable to
different aesthetics. So let’s make those different levels \####separate
variables by widening the data.

``` r
coronavirus_ttd <- coronavirus %>% 
  group_by(country, type) %>%
  summarize(total_cases = sum(cases)) %>%
  pivot_wider(names_from = type, values_from = total_cases)
```

    ## `summarise()` has regrouped the output.
    ## ℹ Summaries were computed grouped by country and type.
    ## ℹ Output is grouped by country.
    ## ℹ Use `summarise(.groups = "drop_last")` to silence this message.
    ## ℹ Use `summarise(.by = c(country, type))` for per-operation grouping
    ##   (`?dplyr::dplyr_by`) instead.

``` r
# Now we can plot this easily
ggplot(coronavirus_ttd) +
  geom_label(mapping = aes(x = confirmed, y = death, label = country))
```

![](Lesson10_files/figure-gfm/unnamed-chunk-17-1.png)<!-- --> \###Using
janitor::clean_names()

\####We’ve noticed in the coronavirus dataset that the variable names
have a very inconsistent format. It’s not a problem per se for our
ability to work with this dataframe, but it’s a bit annoying to look at.

``` r
colnames(coronavirus)
```

    ##  [1] "date"           "province"       "country"        "lat"           
    ##  [5] "long"           "type"           "cases"          "uid"           
    ##  [9] "iso2"           "iso3"           "code3"          "combined_key"  
    ## [13] "population"     "continent_name" "continent_code"

\#If we wanted to then use these columns (which we probably would, since
we created them), we could clean the names to get them into more
coder-friendly lower_snake_case with janitor::clean_names():

``` r
coronavirus <- coronavirus %>% 
  clean_names()

names(coronavirus)
```

    ##  [1] "date"           "province"       "country"        "lat"           
    ##  [5] "long"           "type"           "cases"          "uid"           
    ##  [9] "iso2"           "iso3"           "code3"          "combined_key"  
    ## [13] "population"     "continent_name" "continent_code"

\###And there are other case options in clean_names(), like:

###### “snake” produces snake_case (the default)

##### “lower_camel” or “small_camel” produces lowerCamel

##### “upper_camel” or “big_camel” produces UpperCamel

##### “screaming_snake” or “all_caps” produces ALL_CAPS

##### “lower_upper” produces lowerUPPER

##### “upper_lower” produces UPPERlower
