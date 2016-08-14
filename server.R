
#load libraries
library(ggplot2)
library(shiny)
library(data.table)
library(scales)
library(shinythemes)

#load the data
salary.disp <- fread("dat/salary.dat")
salary.disp.new <- as.data.frame(salary.disp[1,])
salary.model.fit <- lm(sl ~ rk + yr + sx, data = salary.disp)

shinyServer(function(input,output){
        output$pair.plot <- renderPlot({ggplot(data = salary.disp, aes(x = yr, y = sl)) + geom_point(aes(color = sx, size = rk)) + scale_size_manual(values = c(1,2,3))})
        output$pred.sal <-  renderText({
                salary.disp.new[1,"sx"] <- input$gender
                salary.disp.new[1,"yr"] <- input$yr.rnk
                salary.disp.new[1,"rk"] <- input$rank
                
                salary.pred <- predict(salary.model.fit, newdata = salary.disp.new)
                paste("The predicted salary is: ", dollar(as.integer(salary.pred)), " dollars per year.")
                
        })      
})