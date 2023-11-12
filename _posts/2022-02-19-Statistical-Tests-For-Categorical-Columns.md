---
title: Statistical Tests for Categorical Columns
subtitle: by Phanindra Reddy Myakala
date: 2022-02-14 00:00:00
description: 
featured_image: '/images/demo/demo-square.webp'
author: Phanindra Reddy Myakala
categories: ml
---


Categorical columns, prevalent in many datasets, represent non-numeric data such as colors, brands, or categories. Understanding the intricate relationships and dependencies between these columns can offer invaluable insights. In this blog post, we will delve deeper into various statistical tests to determine correlation and dependency between categorical columns.

###  Introduction to Categorical Data

Categorical data is non-numeric and can be broadly categorized into two types:
   - **Ordinal Data**: These have a clear ordering. For instance, educational levels like high school, undergraduate, and postgraduate.
   - **Nominal Data**: These lack any specific ordering, such as colors (red, blue, green) or brands (Nike, Adidas, Puma).


### Introduction to Statistical Tests

- Statistical tests are a fundamental aspect of the field of statistics and are used to make inferences or decisions based on data. They provide a structured methodology to determine whether a particular hypothesis about a dataset is true, based on the evidence provided by the data itself.

### What are Statistical Tests?

- At their core, statistical tests evaluate hypotheses. These hypotheses are initial claims or beliefs about a dataset, and the tests help determine the validity of these claims. 
- For instance, a researcher might hypothesize that a new drug is more effective than existing treatments. A statistical test can then be used to evaluate this claim based on clinical trial data.
- Statistical tests work by comparing observed data to what we would expect under a specific hypothesis. If the observed data is significantly different from the expectation, the hypothesis might be rejected.

### Why Do We Need Statistical Tests?

- **Objective Decision Making**: Statistical tests provide an objective framework to make decisions about data. They help in determining if an observed effect or relationship in the data is statistically significant or if it could have occurred by random chance.
- **Validation of Hypotheses**: They allow researchers to validate or refute hypotheses based on empirical data. This is crucial in scientific research to draw valid conclusions.
- **Generalization**: By testing a sample, we can make inferences about the entire population. Statistical tests help determine the reliability of these inferences.
- **Control for Variability**: Data inherently has variability. Statistical tests help in distinguishing between natural variability and variability due to specific causes or interventions.
- **Quantification of Uncertainty**: They provide a measure of uncertainty, usually in the form of a p-value or confidence interval, which helps in understanding the range within which the true population parameter might lie.

 Let's delve deeper into the statistical tests specifically designed for categorical data.

###  Chi-Square Test of Independence

The Chi-Square test is a popular method to determine if there's a significant association between two categorical variables.
It's based on the difference between the expected frequencies and the observed frequencies in one or more categories of a contingency table.

#### Formula:
\\[ \chi^2 = \sum \frac{(O - E)^2}{E} \\]
  Where:
  - \( O \) represents the observed frequency.
  - \( E \) denotes the expected frequency under the assumption of independence.

#### When to use Chi-Square Test:
  - **Data Type**: The data should be frequencies or counts of cases rather than percentages or means. If you have data in percentages, you can convert it into frequencies for the test.
  - **Sample Size**: Each particular situation or category should have an expected frequency of at least 5. This is a rule of thumb to ensure the validity of the test.

#### Advantages:
  - **Versatility**: Can be used for more than two categories and variables.
  - **Non-parametric**: Doesn't assume a normal distribution of the data.

#### Limitations:
  - **Sample Size**: Not suitable for small sample sizes. If expected values are below 5, the test might not be valid.
  - **Data Level**: Requires categorical data. It's not suitable for continuous data unless the data has been categorized.

#### How to interpret the  $\chi^2$ metric:
  - **Calculate the P-value**: Along with the $\chi^2$ statistic, the test will return a P-value.
  - **Compare P-value to Significance Level**: Common choices for the significance level (alpha) are 0.05, 0.01, and 0.10. If the P-value is less than or equal to the chosen significance level, you reject the null hypothesis.
  - **Decision**:
       - *P-value <= alpha*: Reject the null hypothesis (H0), suggesting the observed and expected frequencies are significantly different, and there's an association between the categorical variables.
       - *P-value > alpha*: Fail to reject the null hypothesis (H0), suggesting no significant difference between the observed and expected frequencies.


```python
### Sample Code:

import scipy.stats as stats

# Sample data
data = [[30, 10], [5, 50]]
chi2, p, _, _ = stats.chi2_contingency(data)

print(f"Chi-Square Value = {chi2}")
print(f"P-Value = {p}")
```

```
Chi-Square Value = 40.44709821428572
P-Value = 2.0201225042690014e-10
```

The results indicate that there's a statistically significant relationship between the two categorical variables you tested, as the observed frequencies differ significantly from what would be expected if the variables were independent.

#### Use Case:
  Imagine a company wants to know if there's an association between gender (male, female) and product preference (Product A, Product B). The Chi-Square test can help determine if product preference is independent of gender.

###  Cramér's V

Cramér's V is a measure of association between two nominal variables. It's derived from the Chi-Square statistic and provides a value between 0 and 1, indicating the strength of the association. A value of 0 indicates no association, while a value of 1 indicates a perfect association.

#### Formula:
\\[ V = \sqrt{\frac{\chi^2}{n \times \min(k-1, r-1)}} \\]

   Where:

   - \\( n \\) is the total number of observations. 
   - \\(\chi^2\\) is the chi-square test statistic.
   - \\( k \\) and \\( r \\) are the number of categories for each variable.

#### When to use Cramér's V:
 - **Data Type**: The data should be categorical, specifically nominal. It's not suitable for ordinal or continuous data.
 - **Purpose**: When you want to measure the strength of association after having determined that there is a significant relationship using the Chi-Square test.

#### Advantages:
 - **Range Bound**: Values are between 0 and 1, making interpretation straightforward.
 - **Versatility**: Can be used for more than two categories and variables.

#### Limitations:
 - **Data Level**: Requires nominal data. It's not suitable for ordinal or continuous data unless the data has been categorized.
 - **Dependence on Chi-Square**: The value of Cramér's V is derived from the Chi-Square statistic, so it carries the same assumptions and limitations.


```python
### Sample Code:
import pandas as pd
import numpy as np
def cramers_v(x, y):
    chi2 = stats.chi2_contingency(pd.crosstab(x, y))[0]
    n = len(x)
    return np.sqrt(chi2 / (n * min(len(np.unique(x)) - 1, len(np.unique(y)) - 1)))

# Sample data
data1 = ["A", "B", "A", "C"]
data2 = ["X", "Y", "Y", "X"]
print(cramers_v(data1, data2))
```

    0.7071067811865476
    

Based on the Cramér's V value of 0.7071, there's a strong association between the two categorical variables in the sample data. This means that the two variables are not independent of each other and have a significant relationship.

#### Use Case:
  A market researcher wants to understand the relationship between brand loyalty (loyal, not loyal) and purchase frequency (frequent, infrequent) using the Chi-square test. Cramér's V can quantify the strength of this relationship.

###  Fisher's Exact Test

Fisher's Exact Test is a statistical significance test used in the analysis of contingency tables. Although in practice it is employed when sample sizes are small, it is valid for all sample sizes. It's named after its inventor, Sir Ronald Fisher, and is an exact test method, meaning the results are not approximated but are computed exactly.

#### How It Works:

  The test is used to determine if there are nonrandom associations between the two categorical variables. The test essentially compares the observed distribution of data to the distribution we would expect if the two variables were independent.

  The test is based on the hypergeometric distribution. Given a 2x2 contingency table:

  | |Group 1|Group 2|
  |-|-|-|  
  |Outcome A|a|b|
  |Outcome B|c|d|

  The probability of observing this particular arrangement of data, assuming the given marginal totals, is:

$$P(X=a)=\frac{\binom{a+c}{a}\binom{a+b}{a}}{\binom{n}{a}}$$

  - Where: 
       
      -- $\binom{a+c}{a}$ is the number of ways to choose $a$ successes from $a+c$ trials.

      -- $n$ is the total number of observations.

#### When to Use:
     - **Small Sample Sizes**: Especially when the expected frequencies are small (less than 5). The Chi-Square test, in contrast, might not be accurate with small sample sizes.
     - **Exact P-values**: When you need to compute exact p-values, regardless of the sample size.
     - **2x2 Tables**: Fisher's Exact Test is typically used for 2x2 contingency tables. For larger tables, computational challenges arise, although there are generalizations of the test for larger tables.


```python
import scipy.stats as stats

# Sample data
data = [[8, 2], [1, 5]]
oddsratio, pvalue = stats.fisher_exact(data)

print(f"Odds Ratio = {oddsratio}")
print(f"P-Value = {pvalue}")
```

    Odds Ratio = 20.0
    P-Value = 0.03496503496503495
    

- Given the output, we can conclude that the treatment (or factor) being studied has a significant effect. The odds of the event of interest occurring in the treated group are 20 times higher than in the control group. The p-value further confirms the statistical significance of this finding, as it's less than the common threshold of 0.05.

#### Use Case:
  Imagine a medical study where researchers want to test the effectiveness of a new drug. They might set up a 2x2 table where one dimension is whether or not a patient took the drug, and the other is whether or not they recovered. If only a few patients participated in the trial, Fisher's Exact Test would be appropriate to determine if recovery is associated with taking the drug

###  Point-Biserial Correlation

The Point-Biserial Correlation is a correlation measure used to quantify the strength and direction of the linear relationship between a continuous variable and a binary categorical variable.The binary variable is often coded as 0 and 1.

#### Formula:
\\[ r_{pb} = \sqrt{\frac{t^2}{t^2 + df}} \\]

Where: 
- \\(t\\) is the t-statistic.
- \\(df\\) is the degree of freedom.
- The value of  $r_{pb}$ ranges between -1 and 1. A value close to 1 indicates a strong positive linear relationship, a value close to -1 indicates a strong negative linear relationship, and a value close to 0 indicates a weak or no linear relationship.

#### When to Use:

The Point-Biserial Correlation is used when you have one continuous variable and one binary categorical variable and you want to determine the strength and direction of their linear relationship.
- For instance, it can be used to determine the relationship between gender (male=1, female=0) and test scores.

```python
### Sample Code:

import scipy.stats as stats

# Sample data
continuous_data = [50, 55, 89, 56, 42, 78, 85, 90, 60, 72]
binary_data = [1, 0, 1, 1, 0, 0, 1, 1, 0, 1]  # 1 and 0 represent two categories of the binary variable.
r, p = stats.pointbiserialr(binary_data, continuous_data)

print(f"Point-Biserial Correlation = {r}")
print(f"P-Value = {p}")
```

```
Point-Biserial Correlation = 0.44422754603812475
P-Value = 0.19837665116170253
```    

While there is a moderate positive correlation of 0.4442 between the continuous and binary categorical variable, the p-value of 0.1984 suggests that this correlation is not statistically significant at the 0.05 level. Therefore, based on this sample data, we cannot confidently state that there's a significant relationship between the two variables.

###  Conclusion

Analyzing relationships between categorical columns is pivotal in data analysis. Tools like the Chi-Square test, Cramér's V, Fisher's Exact Test, and Point-Biserial Correlation provide robust methods to determine correlations and dependencies. By leveraging these tests, we can extract meaningful patterns from our data, leading to more informed decisions.