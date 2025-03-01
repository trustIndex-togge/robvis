
<!-- README.md is generated from README.Rmd. Please edit that file -->

# robvis <img src="man/figures/robvis_hex_box.png" align="right" width="18%" height="18%" />

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![CRAN
Badge.](https://www.r-pkg.org/badges/version-ago/robvis)](https://CRAN.R-project.org/package=robvis)
[![CRAN
Downloads.](https://cranlogs.r-pkg.org/badges/last-month/robvis)](https://CRAN.R-project.org/package=robvis)
<br> [![R build
status](https://github.com/mcguinlu/robvis/workflows/R-CMD-check/badge.svg)](https://github.com/mcguinlu/robvis/actions)
[![Codecov test
coverage](https://codecov.io/gh/mcguinlu/robvis/branch/master/graph/badge.svg)](https://codecov.io/gh/mcguinlu/robvis?branch=master)
<br>
[![DOI](https://img.shields.io/static/v1.svg?label=Publication&message=10.1002/jrsm.1411&color=informational)](https://doi.org/10.1002/jrsm.1411)
[![metaverse
Identifier](https://img.shields.io/static/v1.svg?label=Part%20of%20the&message=metaverse&color=informational)](https://www.github.com/rmetaverse/metaverse)

**UPDATE**: `robvis` now exists as a
[web-app](https://mcguinlu.shinyapps.io/robvis), aimed at those who are
not familiar with R or who want to explore the package’s functionality
before installing it locally.

## Description

The `robvis` package takes the summary table from risk-of-bias
assessments and produces plots formatted according to the assessment
tool used.

## Getting started

Install the development version which contains new functionality and a
range of bug fixes:

``` r
install.packages("devtools")
devtools::install_github("mcguinlu/robvis")
```

To update the package, run the `install_github("mcguinlu/robvis")`
command again.

If you wish to use the older CRAN version of the package, use the
following command:

``` r
install.packages("robvis")
```

### Load data

To load your own data from a .csv file:

``` r
mydata <- read.csv("path/to/mydata.csv", header = TRUE)
```

To help users explore `robvis`, we have included example datasets in the
package, one for each of the tool templates that currently exist within
the package. The `data_rob2` dataset ([view it
here](https://github.com/mcguinlu/robvis/blob/master/data_raw/data_rob2.csv)),
which contains example risk-of-bias assessments performed using the
RoB2.0 tool for randomized controlled trials, is used to create the
plots in subsequent sections.

### Create plots

The package contains two plotting functions:

#### 1\. rob\_summary()

Returns a ggplot object displaying a bar-chart of the risk of bias of
included studies across the domains of the specified tool. \[*Note: the
defaults used in this function have changed from their original
settings, so that a un-weighted barplot is now produced by default. See
the NEWS.md file for further information.*\]

``` r
summary_rob <- rob_summary(data = data_rob2, tool = "ROB2")

summary_rob
```

<div style="text-align:center">

<img src=man/figures/robplot1.png width="70%" height="70%"/>

</div>

#### 2\. rob\_traffic\_light()

Returns a ggplot object displaying a [“traffic light
plot”](https://handbook-5-1.cochrane.org/chapter_8/figure_8_6_c_example_of_a_risk_of_bias_summary_figure.htm),
displaying the risk of bias judgment in each domain for each study.

``` r
trafficlight_rob <- rob_traffic_light(data = data_rob2,
                                      tool = "ROB2",
                                      psize = 10)

trafficlight_rob
```

<div style="text-align:center">

<img src=man/figures/robplot2.png width="70%" height="70%"/>

</div>

### Other functions

#### rob\_save()

Pass the `robvis` to this function, along with a destination file, to
save your risk-of-bias plots using sensible defaults.

``` r
rob_save(trafficlight_rob, "rob_fig.png")
```

#### rob\_tools()

Outputs a list of the risk of bias assessment tools for which a template
currently exists in rob\_summary(). We expect this list to be updated in
the near future to include tools such as ROBIS (tool for assessing risk
of bias in systematic reviews).

``` r
rob_tools()
#> Note: the "ROB2-Cluster" template is only available for the rob_traffic_light() function.
#> [1] "ROB2"         "ROB2-Cluster" "ROBINS-I"     "ROBINS-E"     "QUADAS-2"    
#> [6] "QUIPS"        "Generic"
```

## Advanced usage

### Change the colour scheme

The `colour` argument of both plotting functions allows users to select
from two predefined colour schemes (“cochrane” or “colourblind”) or to
define their own palette by providing a vector of hex codes.

For example, to use the predefined “colourblind” palette:

``` r
rob_summary(data = data_rob2,
            tool = "ROB2",
            colour = "colourblind")
```

<div style="text-align:center">

<img src=man/figures/robplot3.png width="70%" height="70%"/>

</div>

And to define your own colour scheme:

``` r
rob_summary(
  data = data_rob2,
  tool = "ROB2",
  colour = c("#f442c8",
             "#bef441",
             "#000000",
             "#d16684")
)
```

<div style="text-align:center">

<img src=man/figures/robplot4.png width="70%" height="70%"/>

</div>

### No “Overall” judgement

By default, both functions include an “Overall” risk of bias domain. To
prevent this, remove the overall column from your dataset and set
`overall = FALSE`.

``` r
summary_rob <- rob_summary(data = data_rob2[1:6], tool = "ROB2", overall = FALSE)
summary_rob
```

<div style="text-align:center">

<img src=man/figures/robplot5.png width="70%" height="70%"/>

</div>

``` r
rob_traffic_light(data = data_rob2[1:6],
                  tool = "ROB2",
                  overall = FALSE)
```

<div style="text-align:center">

<img src=man/figures/robplot6.png width="70%" height="70%"/>

</div>

### Editing the plots

Finally, because the output (`summary_rob` and `trafficlight_rob` in the
examples above) is a ggplot2 object, it is easy to adjust the plot to
your own preferences.

For example, to add a title:

``` r
library(ggplot2)

rob_summary(data = data_rob2, tool = "ROB2") +
  ggtitle("Summary of RoB 2.0 assessments")
```

<div style="text-align:center">

<img src=man/figures/robplot7.png width="70%" height="70%"/>

</div>

## Examples of `robvis` in published papers

  - Perivoliotis, Konstantinos, et al. “[Comparing the efficacy and
    safety of laparoscopic and robotic adrenalectomy: a meta-analysis
    and trial sequential
    analysis.](https://link.springer.com/article/10.1007/s00423-020-01860-9)”
    Langenbeck’s Archives of Surgery (2020): 1-11.
  - Adile, Ashley A., et al. “[Salvage therapy for progressive,
    treatment-refractory or recurrent pediatric medulloblastoma: a
    systematic review
    protocol.](https://systematicreviewsjournal.biomedcentral.com/articles/10.1186/s13643-020-01307-8)”
    Systematic Reviews 9.1 (2020): 1-9.
  - Tanneru, Karthik, et al. “[Meta-analysis and systematic review of
    intermediate-term follow-up of prostatic urethral lift for benign
    prostatic
    hyperplasia.](https://link.springer.com/article/10.1007/s11255-020-02408-y)”
    International Urology and Nephrology (2020): 1-10.
  - Veloso, Andreia, et al.. “[Effectiveness of Cognitive Training for
    School-Aged Children and Adolescents With Attention
    Deficit/Hyperactivity Disorder: A Systematic
    Review.](https://www.frontiersin.org/articles/10.3389/fpsyg.2019.02983/full)”
    Frontiers in Psychology 10 (2020): 2983.
  - Simillis, Constantinos, et al. “[Postoperative chemotherapy improves
    survival in patients with resected high‐risk stage II colorectal
    cancer: results of a systematic review and
    meta‐analysis.](https://onlinelibrary.wiley.com/doi/pdf/10.1111/codi.14994)”
    Colorectal Disease (2020).
  - Habadi, Mohammed Ibrahim, et al. “[Prevalence of Panic Disorders in
    the Primary Health Care Setting: A Systematic Review and
    Meta-Analysis.](https://www.ecronicon.com/ecmi/pdf/prevalence-of-panic-disorders-in-the-primary-health-care-setting-a-systematic-review-and-meta-analysis.pdf)”
    EC Microbiology 16.1 (2019): 01-09.
  - Gibb, Kate, et al. “[The consistent burden in published estimates of
    delirium occurrence in medical inpatients over four decades: a
    systematic review and meta-analysis
    study.](https://www.medrxiv.org/content/medrxiv/early/2019/08/29/19005165.full.pdf)”
    medRxiv (2019): 19005165.

See more
[here](https://scholar.google.com/scholar?cites=12564214960529060925&as_sdt=2005&sciodt=0,5&hl=en).

## Code of conduct

Please note that the ‘robvis’ project is released with a [Contributor
Code of
Conduct](https://github.com/mcguinlu/robvis/blob/master/CODE_OF_CONDUCT.md).
By contributing to this project, you agree to abide by its terms.

## License

This project is licensed under the MIT License - see the
[LICENSE.md](https://github.com/mcguinlu/robvis/blob/master/LICENSE)
file for details.

## Acknowledgments

  - The `rob_summary()` function was based on code forwarded by a
    colleague. I recently discovered that this code was adapted from
    that presented in the wonderful “[Doing Meta-Analysis in
    R](https://bookdown.org/MathiasHarrer/Doing_Meta_Analysis_in_R/plotting-the-summary.html)”
    guide, so I would like to acknowledge the authors here.
  - [Emily Kothe](https://github.com/ekothe) for help in fixing
    `ggplot2` coding issues.
  - [Eliza Grames](https://github.com/elizagrames) for creating the
    `robvis` hex sticker.

### Research notice

Please note that this repository is participating in a study into
sustainability of open source projects. Data will be gathered about this
repository for approximately the next 12 months, starting from June
2021.

Data collected will include number of contributors, number of PRs, time
taken to close/merge these PRs, and issues closed.

For more information, please visit [the informational
page](https://sustainable-open-science-and-software.github.io/) or
download the [participant information
sheet](https://sustainable-open-science-and-software.github.io/assets/PIS_sustainable_software.pdf).
