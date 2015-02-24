library(rCharts)
library(shiny)
source('data_to_json.R')

data_json_format <- data_to_json(iris, c('Sepal.Length', 'Sepal.Width'), c('x','y'))

server <- function(input, output){
  
  output$plot <- renderChart2({   
    
    #apply data filters
    ix <- with(iris, Sepal.Length >= input$sepal_length[1] & Sepal.Length <= input$sepal_length[2])   
    
    p <- Highcharts$new() 
    p$chart(type = "scatter")
    p$xAxis(title=list(text='Sepal Length'))
    p$yAxis(title=list(text='Sepal Width'), gridLineWidth=0, lineWidth=1) 
    p$series(data=data_json_format[ix], animation=FALSE)
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
      sliderInput('sepal_length', label = 'Sepal Length', min=min(iris$Sepal.Length), max=max(iris$Sepal.Length), value=c(min(iris$Sepal.Length),max(iris$Sepal.Length)), step = .1)
    )    
  )
)
)

shinyApp(ui = ui, server = server)

