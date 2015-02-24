# rCharts-sandbox
Experiments with reactive bindings of `rCharts` plots to data filters. 

With `renderChart2`, the entire plot is regenerated every time the filter values are updated. This is inefficient if only one series needs to be updated - see `line_plot.R` for an example. 

The goal is to develop a user-friendly way to reactively bind parts of an `rCharts` plot (i.e. one series) to a data filter. [Here](http://jsfiddle.net/7pzhdf70/2/) is an example of how this can be done in Highcharts with jQuery filters.

