# structural diversity

To execute the tutorial, make sure you have Python 3, R/R-Studio and Jupyter installed.

To run R script in Jupyter, [IRkernel](https://github.com/IRkernel/IRkernel) is required. This package is available on CRAN and you can install it in R-Studio Console by:
```
install.packages('IRkernel')
IRkernel::installspec()  # to register the kernel in the current R installation
```

#### 1. Python implementation:
`k-clip.ipynb`,
`social_bridges.ipynb`

Main dependencies:
```
networkx
pandas
matplotlib
pygraphviz (if using graphviz_layout)
```

#### 2. R implementation:
`ols.ipynb`,
`psm.ipynb`,
`figs.ipynb`

Main dependencies:
```
dplyr
ggplot2
MatchIt
tableone
reshape2
scales
```
