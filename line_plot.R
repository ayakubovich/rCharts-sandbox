# Example plot illustrating the use case for reactively binding a component of an rCharts plot to a shiny filter.
# This is a line plot with two series, one large, one small, but the data filters only affect the small series. 
# We should avoid regenerating the entire plot with renderChart2 every time the slider values are updated.

library(rCharts)
library(shiny)
source('data_to_json.R')

#generate two data series in json format
n<-3000 #num. points in large series
m<-50 #num. points in small series

set.seed(42)
lines <- data.frame(x=1:n, y=diffinv(rnorm(n-1)))
lines_json <- data_to_json(lines, c('x', 'y'), c('x','y'))

peaks <- lines[sample(n, m), ]
peaks_json <- data_to_json(peaks, c('x', 'y'), c('x','y'))

server <- function(input, output){
  
  output$plot <- renderChart2({   
    
    #skeleton of plot
    p <- Highcharts$new() 
    p$chart(type='line',  zoomType= 'x')     
    p$xAxis(title=list(text='x'))
    p$yAxis(title=list(text='y'), gridLineWidth=0, lineWidth=1) 
    
    #series 1 is static. It is expensive to render, and should not react to the slider.
    p$series(data=lines_json, 
             animation=FALSE, 
             marker=list(enabled=FALSE),
             turboThreshold=0,
             enableMouseTracking=FALSE,
             lineWidth = 1)
       
    #series 2 reacts to the data filters. It is the only part of the graph that should reactively bind to the slider.
    ix <- with(peaks, y >= input$y[1] & y <= input$y[2])     
    p$series(data=peaks_json[ix], 
             marker=list(enabled=TRUE, symbol="circle", lineColor="#FF8080", fillColor='#FF8080', radius=3),                     
             turboThreshold=0,
             animation = FALSE,               
             lineWidth = 0)
    p$legend()
    p
  })
}

ui <- shinyUI(fluidPage(  
  
  sidebarLayout(    
    mainPanel(      
      showOutput("plot", "highcharts")
    ),    
    sidebarPanel(      
      sliderInput('y', 'Filter the y-values to be highlighted:', min=min(peaks$y), max=max(peaks$y), value=c(min(peaks$y), max(peaks$y)))
      )    
  )
)
)

shinyApp(ui = ui, server = server)