library(ggvis)

m <- list("Method1"="method1","Method2"="method2",
       "Method3"="method3","Method4"="method4",
       "Method5"="method5","Method6"="method6",
       "Method7"="method7","Method8"="method8",
       "Method9"="method9","Method10"="method10")

shinyUI(pageWithSidebar(
  div(),
  sidebarPanel(
    sliderInput("n", "Number of points", min = 1, max = 10,
                value = 5, step = 1),
    
    hr(),
    selectInput("method", "Method:",choices=m),

    hr(),
    helpText("Data Science Hw4 "),

    uiOutput("plot_ui")
  ),
  mainPanel(
    ggvisOutput("plot"),
    tableOutput("method_table")
  )
))
