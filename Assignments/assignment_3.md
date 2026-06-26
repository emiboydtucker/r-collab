---
output:
  html_document: default
  pdf_document: default
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)
library(knitr)
library(kableExtra)
```

# **Exercise 1. Corruption and human development**

---  

This exercise explores a dataset containing the human development index (`HDI`) and corruption perception index (`CPI`) of 173 countries across 6 different regions around the world: Americas, Asia Pacific, Eastern Europe and Central Asia (`East EU Cemt`), Western Europe (`EU W. Europe`), Middle East and North Africa and Noth Africa (`MENA`), and Sub-Saharan Africa (`SSA`). (Note: the larger `CPI` is, the less corrupted the country is perceived to be.)

<br>

First, we load the data using the following code.
<br>

```{r}
economist_data <- read.csv("https://raw.githubusercontent.com/nt246/NTRES6940-data-science/master/datasets/EconomistData.csv")
```

<br><br>

**1.1 Show the first few rows of `economist_data`.**
<br>

```{r, echo=FALSE}

economist_data %>%
    head() %>%
    kable() %>%
    kable_styling(full_width = FALSE, bootstrap_options = c("striped", "bordered"))

```

<br><br>

**1.2 Expore the relationship between human development index (`HDI`) and corruption perception index (`CPI`) with a scatter plot as the following.**
<br>

```{r, echo=FALSE}

ggplot(data = economist_data) +
  geom_point(mapping = aes(x = CPI, y = HDI))

```

<br><br>

**1.3 Make the color of all points in the previous plot red**
<br>

```{r, echo=FALSE}

ggplot(data = economist_data) +
  geom_point(mapping = aes(x = CPI, y = HDI), color = "red")
```

<br><br>

**1.4 Color the points in the previous plot according to the `Region` variable, and set the size of points to 2.**
<br>

```{r, echo=FALSE}

ggplot(data = economist_data) +
  geom_point(mapping = aes(x = CPI, y = HDI, color = Region), size = 2)
```

<br><br>

**1.5 Set the size of the points proportional to `HDI.Rank`**
<br>

```{r, echo=FALSE}

ggplot(data = economist_data) +
  geom_point(mapping = aes(x = CPI, y = HDI, color = Region, size = HDI.Rank))+
  guides(
    color = guide_legend(order = 1),
    size = guide_legend(order = 2))
```

<br><br>

**1.6 Fit a smoothing line to all the data points in the scatter plot from Excercise 1.4**
<br>

```{r, echo=FALSE, message=FALSE}

ggplot(data = economist_data) +
  geom_point(mapping = aes(x = CPI, y = HDI, color = Region), size = 2) +
  geom_smooth(mapping = aes(x = CPI, y = HDI))
```

<br><br>

**1.7 Fit a separate straight line for each region instead, and turn off the confidence interval.**
<br>

```{r, echo=FALSE, message=FALSE}

ggplot(economist_data, aes(x = CPI, y = HDI, color = Region)) +
  geom_point(size = 2) +
  geom_smooth(method = "lm", se = F)
  
```

<br><br>

**1.8 Building on top of the previous plot, show each `Region` in a different facet.**
<br>

```{r, echo=FALSE, message=FALSE}

ggplot(economist_data, aes(x = CPI, y = HDI)) +
  geom_point(mapping = aes(color = Region), size = 2) +
  geom_smooth(mapping = aes(color = Region), method = "lm", se = F) +
  facet_wrap(~Region)
  
```

<br><br>

**1.9 Show the distribution of `HDI` in each region using density plot. Set the transparency to 0.5**
<br>

```{r, echo=FALSE, message=FALSE}

ggplot(economist_data) +
  geom_density(aes(fill = Region, x = HDI), alpha = 0.5)
```

<br><br>

**1.10 Show the distribution of `HDI` in each region using histogram and faceting.**
<br>

```{r, echo=FALSE, message=FALSE}

ggplot(economist_data) +
  geom_histogram(aes(fill = Region, x = HDI)) +
  facet_wrap(~Region)
```

<br><br>

**1.11 Show the distribution of `HDI` in each region using a box plot. Set the transparency of these boxes to 0.5. Also show data points for each country in the same plot. (Hint: `geom_jitter()` or `position_jitter()` might be useful.)**
<br>

```{r, echo=FALSE, message=FALSE}

ggplot(economist_data, aes(x = Region, y = HDI)) +
  geom_boxplot(aes(fill = Region, color = Region), alpha = 0.5, outliers = FALSE) +
  geom_jitter(aes(color = Region))
```

<br><br>

**1.12 Show the count of countries in each region using a bar plot.**
<br>

```{r, echo=FALSE, message=FALSE}
ggplot(economist_data) +
  geom_bar(aes(x = Region))
```

<br><br>

**1.13 You have now created a variety of different plots of the same dataset. Which of your plots do you think are the most informative? Describe briefly the major trends that you see in the data.**
<br>

Answer: The most informative plot is the boxplot because it shows you the range, quartiles, median, and plot points of the data correlating regions with their respective HDI's. The viewer is able to interpret the diversity of HDI's within and between regions.

<br><br><br>

# **Exercise 2. Unemployment in the US 1967-2015**

---  


This excercise uses the dataset `economics` from the ggplot2 package. It was produced from US economic time series data available from http://research.stlouisfed.org/fred2. It describes the number of unemployed persons (`unemploy`), among other variables, in the US from 1967 to 2015.
<br>

```{r, include=FALSE}

#View the data, it is already installed in ggplot2, so no need to load it.

View(economics)

```

```{r}

head(economics) %>% kable() %>%
    kable_styling(full_width = FALSE, bootstrap_options = c("striped", "bordered"))
```

<br><br>

**2.1 Plot the trend in number of unemployed persons (`unemploy`) though time using the economics dataset shown above. And for this question only, hide your code and only show the plot.**
<br>

```{r, echo=FALSE}

ggplot(economics, aes(x = date, y = unemploy)) +
  geom_line()
```

<br><br>

**2.2 Edit the plot title and axis labels of the previous plot appropriately. Make y axis start from 0. Change the background theme to what is shown below. (Hint: search for help online if needed)**
<br>

```{r, echo=FALSE}

ggplot(economics, aes(x = date, y = unemploy)) +
  geom_line() +
  labs(x = "Year", y = "Number of unemployed persons (in thousands)", title= "Unemployment in the US 1967-2015") +
  theme_minimal() +
   expand_limits(y = 0)
```

<br><br>
