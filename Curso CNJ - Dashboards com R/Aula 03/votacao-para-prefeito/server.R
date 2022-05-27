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
    }
)

#-----------------------------------------------------------------------
