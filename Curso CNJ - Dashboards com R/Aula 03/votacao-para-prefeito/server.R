#-----------------------------------------------------------------------
#
#         Dashboards e relatórios dinâmicos com R
#
#                                            Prof. Dr. Walmes M. Zeviani
#                Department of Statistics · Federal University of Paraná
#                                       2022-mai-23 · Curitiba/PR/Brazil
#-----------------------------------------------------------------------

library(shiny)

shinyServer(
    function(input, output, session) {
      
      FILTERED_DATA <- reactive({
        filter_data(tb,
                    br_municipal,
                    unidade_federativa = input$UF,
                    ano_eleitoral = input$ANO)
      })
      
      output$BARPLOT <- renderPlot({
          make_barplot(tb_count = FILTERED_DATA()$tb_count,
                       unidade_federativa = isolate(input$UF),
                       ano_eleitoral = isolate(input$ANO))
        })
      
      output$MAP <- renderPlot({
        make_cloropleth(tb_estado = FILTERED_DATA()$tb_estado,
                     unidade_federativa = isolate(input$UF),
                     ano_eleitoral = isolate(input$ANO))
      })
      
      output$TABLE <- renderReactable({
        make_table(tb_estado = FILTERED_DATA()$tb_estado,
                   tb_count = FILTERED_DATA()$tb_count)
      })
      
      output$IB_ANO <- renderValueBox({
        valueBox(
          value = input$ANO,
          icon = "fa-calendar",
          color = "primary"
        )
      })
      output$IB_UF <- renderValueBox({
        valueBox(
          value = input$UF,
          icon = "fa-map",
          color = "primary"
        )
      })
      output$IB_TOT <- renderValueBox({
        valueBox(
          value = sum(FILTERED_DATA()$tb_count$n),
          icon = "fa-university",
          color = "success"
        )
      })
      output$IB_PERC <- renderValueBox({
        tb_count <- FILTERED_DATA()$tb_count
        valueBox(
          value = sprintf("%0.1f%%", 100*max(tb_count$n)/sum(tb_count$n)),
          caption = sprintf("de prefeituras com %s", tb_count$Partido[1]),
          icon = "fa-trophy",
          color = "warning"
        )
      })
    }
)

#-----------------------------------------------------------------------
