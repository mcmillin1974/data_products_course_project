library(shinythemes)
library(data.table)
salary.disp <- fread("salary.dat", header = TRUE)

shinyUI(fluidPage(
        
        titlePanel("Small College Salary Predictor"),
        sidebarLayout(
                sidebarPanel(
                        h5("About this app: This application predicts a tenured professor's salary for a small college.  This data (from S. Weisberg's book: Applied Linear Regression) is based on the salary informatoin for 52 tenured professors at a small college."),
                        h5("To following variables are the most significant in the database, making up nearly 86% of the response variable variation).  Please select the profile of your professor and the application will display the updated salary information after each successive change."),
                        selectInput("rank", label = "Current rank:", choices = unique(salary.disp$rk), selected = "full"),
                     sliderInput("yr.rnk", label = "Years in current rank:", min = min(salary.disp$yr), max = (salary.disp$yr), value = 0, step = 1),
                     selectInput("gender", label = "Gender:", choices = c("male","female"), selected = "female"),
                     #selectInput("degree", label = "Highest Degree", choices = unique(salary.disp$dg), selected = "doctorate")
                     h6("Source:  Reference: S. Weisberg (1985). Applied Linear Regression, Second Edition. New York: John Wiley and Sons. Page 194."),
                     h6("The source files (ui.R and server.R) may be found here: "),
                     a(href="http://github.com/mcmillin1974/data_products_course_project/", "LINK TO THE GITHUB REPO ")
                     
                ),
                mainPanel(
                        h4("The following plot graphically shows the relationship between the three most significant variables and salary:"),
                        plotOutput("pair.plot"),
                        column(12,
                        h4("The following was generated using the R 'predict' function and the inputs from the side panel:"),
                        h3(textOutput("pred.sal"))
                        )
                )
        )
))