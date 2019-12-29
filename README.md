# The strength of social context diversity in online social networks

To execute the tutorial, make sure you have Python 3, R/R-Studio and Jupyter installed.

To run R script in Jupyter, [IRkernel](https://github.com/IRkernel/IRkernel) is required. This package is available on CRAN and you can install it in R/R-Studio Console by:
```
install.packages('IRkernel')
IRkernel::installspec()  # to register the kernel in the current R installation; 
                         # if it doesn't work, you may enter R from your system terminal,
                         # then try this command again
```

#### 1. Python implementation:
`k-clip.ipynb`: illustration of k-clip decomposition

`social_bridges.ipynb`: illustration of social bridges

Main dependencies:
```
networkx
pandas
matplotlib
pygraphviz (if using graphviz_layout)
```

#### 2. R implementation:
`ols.ipynb`: ordinary least squares (OLS) regressions

`psm.ipynb`: propensity score matching (PSM)

`figs.ipynb`: figure reproduction

Main dependencies:
```
dplyr
ggplot2
MatchIt
tableone
reshape2
scales
```
