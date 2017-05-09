library(shiny)
library(ggvis)

sensitivity <- c()
specificity <- c()

for(i in c(1:10)){
  file <- paste0("method",toString(i),".csv")
  d <- read.csv(file, header=T,sep=",")
  tp <- sum(d$prediction == d$reference & d$prediction == "male")
  fp <- sum(d$prediction != d$reference & d$prediction == "male")
  fn <- sum(d$prediction != d$reference & d$prediction != "male")
  tn <- sum(d$prediction == d$reference & d$prediction != "male")

  sensitivity <- c(sensitivity, round(tp / (tp + fn),digits = 2))
  specificity <- c(specificity, 1 - round(tn / (fp + tn),digits = 2))
}

t <- data.frame(sensitivity, specificity, stringsAsFactors = F)


shinyServer(function(input, output, session) {
  # A reactive subset of mtcars
  mtc <- reactive({ t[1:input$n, ] })
  # A simple visualisation. In shiny apps, need to register observers and tell shiny where to put the controls
  mtc %>%
    ggvis(~specificity, ~sensitivity) %>%
    add_axis("x", title = "1 - specificity") %>%
    add_axis("y", title = "sensitivity") %>%
    layer_points() %>%
    bind_shiny("plot", "plot_ui")
  
  output$method_table <- renderTable({
    mtc()[, c("specificity", "sensitivity")]
    file <- paste0(input$method,".csv")
    d <- read.csv(file, header=T,sep=",")
    (d <- read.csv(file, header=T,sep=","))
  })
})
