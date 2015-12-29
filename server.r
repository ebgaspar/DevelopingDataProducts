library(shiny)

classe = 0

shinyServer(
    function(input, output) {

        data1 <- reactive({
            
            inFile <- input$file
            
            if ( is.null( inFile ) )
                return( NULL )
            
            dat <- read.csv( inFile$datapath,
                             header = input$header,
                             sep = input$sep,
                             quote = input$quote )#,
                             # row.names = as.integer( input$rownames ) )
            
        })
        
        output$contents <- renderDataTable({

            data1()

        })

        output$correlation <- renderTable({
            
                cor( data1() )

        })
        
        output$summary <- renderTable({

            summary( data1() )
            
        })
        
        output$dendrogram <- renderPlot({
            
            dat <- factanal( data1(), factors = input$factors,
                                 method = "mle", scores = input$scores )
            
            score <- dat$scores

            dendrogram = hclust( dist( score ), method = "ward.D2" )
            classe <<- cutree( dendrogram, k = input$ncluster )
            
            plot( dendrogram , hang = -1 )
            title( expression( "Dendrogram (Metodo Ward)" ), line = 1 )
            mtext( "Neighborhoods distributed by clusters",
                   side = 1, line = 2, col = "blue", cex = 1 )
            mtext( "Distance", side = 2, line = 2, col = "black", cex = 1 )
            rect.hclust( dendrogram, k = input$ncluster, border = "green" )
            
        })
        
        output$boxplot <- renderPlot({

            l <- list( which(classe == 1 ) )
            
            for ( i in 2:input$ncluster )
            {

                l[[i]] <- which( classe == i )

            }

            colr <- rainbow( length( l ) )
            
            boxplot( l, col = colr )
            mtext( "Clusters", side = 1, line = 2, col = "black", cex = 1 )

        })
})