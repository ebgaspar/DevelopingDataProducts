library(shiny)
library(rCharts)
 require(markdown)
library(markdown)

shinyUI(navbarPage("My Application",
                   tabPanel("Load Dataset",
                            sidebarLayout(
                                sidebarPanel(
                                    # choose local file input
                                    fileInput( 'file', 'Choose local CSV File',
                                               accept = c( 'text/csv', 'text/comma-separated-values,text/plain', '.csv' ) ),
                                    tags$hr(),
                                    checkboxInput( 'header', 'Header', T ),
                                    checkboxInput( 'rownames', 'Row Names', T ),
                                    radioButtons( 'sep', 'Separator', c( Comma = ',', Semicolon=';', Tab='\t' ), ','),
                                    radioButtons('quote', 'Quote', c(None = '', 'Double Quote'='"', 'Single Quote'="'"), '"' )
                                ),
                                mainPanel(
                                    dataTableOutput( "contents" )
                                    )
                                )
                            ), #CLose TabPanel
                    navbarMenu("Stats",
                              tabPanel( "Summary",
                                        tableOutput( "summary")
                                        ),
                               tabPanel("Correlation",
                                        tableOutput("correlation")
                                        )
                            ), # Close NavBarMenu
                    tabPanel( "Plots",
                                sidebarLayout(
                                    sidebarPanel(
                                        h3( 'Parameters', align = "center" ),
                                        h4( 'Factor Analysis', align = "center" ),
                                        sliderInput("factors",
                                                    "Number of factors:",
                                                    min = 1,
                                                    max = 5,
                                                    value = 2),
                                        radioButtons("scores", "Type of Scores",
                                                     c("Regression"="regression",
                                                       "Bartlett"="Bartlett")
                                        ),
                                        h4( 'Cluster Analysis', align = "center" ),
                                        sliderInput("ncluster",
                                                    "Number of clusters:",
                                                    min = 2,
                                                    max = 10,
                                                    value = 2)
                                      ), # Close SideBarPanel
                                    mainPanel(
                                        plotOutput( "dendrogram" ),
                                        plotOutput( "boxplot" )
                                    )
                                ) # Close SideBarLayout
                            ), # Close TabPanel Plots
                    tabPanel( "Help",
                           includeMarkdown("about.md")
                   ) # Close tabPanel Help
        ) # Close NAvBARPAGE
        
) # Close shinyUI
