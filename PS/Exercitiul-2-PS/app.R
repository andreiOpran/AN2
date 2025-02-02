library(shiny)
library(bslib)

thematic::thematic_shiny()

ui <- page_sidebar(
    
    theme = bs_theme(preset = "darkly"),
    
    title = "Exercitiul 2 - Reprezentare grafica a functiilor de repartitie",
    
    sidebar = sidebar(
        card(
            card_header("Selectati distributia si parametrii"),
            
            # alegere distributie
            selectInput(
                inputId = "distributie",
                label = "Distributie:",
                choices = list("Normala (0, 1)", "Normala (μ, σ²)", "Exponentiala", "Poisson", "Binomiala"),
                selected = 1
            ),
            
            numericInput(inputId = "n", label = "Numar generari (n):", value = 100, min = 1),
            
            # afisare conditionata formular in functie de ce distributie a fost aleasa
            conditionalPanel(
                condition = "input.distributie == 'Normala (0, 1)'",
                tags$ul(
                    tags$li("Media (μ): 0"),
                    tags$li("Varianta (σ²): 1")
                )
            ),
            conditionalPanel(
                condition = "input.distributie == 'Normala (μ, σ²)'",
                numericInput(inputId = "mu", label = "Media (μ):", value = 0),
                numericInput(inputId = "sigma", label = "Varianta (σ²):", value = 0.1, min = 0.1)
            ),
            conditionalPanel(
                condition = "input.distributie == 'Exponentiala'",
                numericInput(inputId = "lambda_exponentiala", label = "Rata distributiei (λ):", value = 0.1, min = 0.1)
            ),
            conditionalPanel(
                condition = "input.distributie == 'Poisson'",
                numericInput(inputId = "lambda_poisson", label = "Rata distributiei (λ):", value = 0.1, min = 0.1)
            ),
            conditionalPanel(
                condition = "input.distributie == 'Binomiala'",
                numericInput(inputId = "r", label = "Numar experimente (r):", value = 1, min = 1),
                numericInput(inputId = "p", label = "Probabilitatea de succes (p):", value = 0, min = 0, max = 1)
            )
        )
        
    ),
    
    # afisare conditionata a navbar-ului pentru alegerea unei anumite variabile aleatoare, conform cerintei
    conditionalPanel(
        condition = "input.distributie == 'Normala (0, 1)'",
        navset_card_underline(
            nav_panel("X", plotOutput("normala1Plot1")),
            nav_panel("3 + 2X", plotOutput("normala1Plot2")),
            nav_panel("X²", plotOutput("normala1Plot3")),
            nav_panel("∑(i = 1 → n)(Xᵢ)²", plotOutput("normala1Plot4"))
        )
    ),
    conditionalPanel(
        condition = "input.distributie == 'Normala (μ, σ²)'",
        navset_card_underline(
            nav_panel("X", plotOutput("normala2Plot1")),
            nav_panel("3 + 2X", plotOutput("normala2Plot2")),
            nav_panel("X²", plotOutput("normala2Plot3")),
            nav_panel("∑(i = 1 → n)(Xᵢ)²", plotOutput("normala2Plot4"))
        )
    ),
    conditionalPanel(
        condition = "input.distributie == 'Exponentiala'",
        navset_card_underline(
            nav_panel("X", plotOutput("exponentialaPlot1")),
            nav_panel("2 - 5X", plotOutput("exponentialaPlot2")),
            nav_panel("X²", plotOutput("exponentialaPlot3")),
            nav_panel("∑(i = 1 → n)Xᵢ", plotOutput("exponentialaPlot4"))
        )
    ),
    conditionalPanel(
        condition = "input.distributie == 'Poisson'",
        navset_card_underline(
            nav_panel("X", plotOutput("PoissonPlot1")),
            nav_panel("3 + 2X", plotOutput("PoissonPlot2")),
            nav_panel("X²", plotOutput("PoissonPlot3")),
            nav_panel("∑(i = 1 → n)Xᵢ", plotOutput("PoissonPlot4"))
        )
    ),
    conditionalPanel(
        condition = "input.distributie == 'Binomiala'",
        navset_card_underline(
            nav_panel("X", plotOutput("BinomialaPlot1")),
            nav_panel("5X + 4", plotOutput("BinomialaPlot2")),
            nav_panel("X²", plotOutput("BinomialaPlot3")),
            nav_panel("∑(i = 1 → n)Xᵢ", plotOutput("BinomialaPlot4"))
        )
    )
)

server <- function(input, output) {
    
    # prin intermediul Design Pattern-ului Observer, de fiecare data cand se schimba distributia, se apeleaza codul acesta din server
    observeEvent(input$distributie, {
        if (input$distributie == "Normala (0, 1)")
        {
            output$normala1Plot1 <- renderPlot({
                X1 = rnorm(input$n, mean = 0, sd = 1) # generam n valori aleatoare din distributia normala N(0, 1)
                X1 = X1 # adaptare conform cerintei
                cdfEmpiric = ecdf(X1) # folosim repartitia empirica pentru a analiza setul de date aleator
                plot(cdfEmpiric, col = "#00bc83", lwd = 2, ylab = "F(x)", xlab = "x", main = "Functia de repartitie pentru variabila aleatoare X distribuita normal N(0, 1)")
                grid() # facilitarea citirii plot-ului
            })
            output$normala1Plot2 <- renderPlot({
                X2 = rnorm(input$n, mean = 0, sd = 1)
                X2 = 3 + 2 * X2 # adaptare conform cerintei
                cdfEmpiric = ecdf(X2)
                plot(cdfEmpiric, col = "#00bc83", lwd = 2, ylab = "F(x)", xlab = "x", main = "Functia de repartitie pentru variabila aleatoare 3 + 2X distribuita normal N(0, 1)")
                grid()
            })
            output$normala1Plot3 <- renderPlot({
                X3 = rnorm(input$n, mean = 0, sd = 1)
                X3 = X3 * X3
                cdfEmpiric = ecdf(X3)
                plot(cdfEmpiric, col = "#00bc83", lwd = 2, ylab = "F(x)", xlab = "x", main = "Functia de repartitie pentru variabila aleatoare X² distribuita normal N(0, 1)")
                grid()
            })
            output$normala1Plot4 <- renderPlot({
                X4 = rnorm(input$n, mean = 0, sd = 1)
                X4 = X4 * X4
                X4 = cumsum(X4)
                cdfEmpiric = ecdf(X4)
                plot(cdfEmpiric, col = "#00bc83", lwd = 2, ylab = "F(x)", xlab = "x", main = "Functia de repartitie pentru variabila aleatoare ∑(i = 1 → n)(Xᵢ)² distribuita normal N(0, 1)")
                grid()
            })
        }
        else if(input$distributie == "Normala (μ, σ²)")
        {
            output$normala2Plot1 <- renderPlot({
                X5 = rnorm(input$n, mean = input$mu, sd = sqrt(input$sigma)) 
                X5 = X5
                cdfEmpiric = ecdf(X5)
                plot(cdfEmpiric, col = "#00bc83", lwd = 2, ylab = "F(x)", xlab = "x", main = paste0("Functia de repartitie pentru variabila aleatoare X distribuita normal N(μ = ", input$mu, ", σ² = ", input$sigma, ")"))
                grid()
            })
            output$normala2Plot2 <- renderPlot({
                X6 = rnorm(input$n, mean = input$mu, sd = sqrt(input$sigma))
                X6 = 3 + 2 * X6
                cdfEmpiric = ecdf(X6)
                plot(cdfEmpiric, col = "#00bc83", lwd = 2, ylab = "F(x)", xlab = "x", main = paste0("Functia de repartitie pentru variabila aleatoare 3 + 2X distribuita normal N(μ = ", input$mu, ", σ² = ", input$sigma, ")"))
                grid()
            })
            output$normala2Plot3 <- renderPlot({
                X7 = rnorm(input$n, mean = input$mu, sd = sqrt(input$sigma)) 
                X7 = X7 * X7
                cdfEmpiric = ecdf(X7)
                plot(cdfEmpiric, col = "#00bc83", lwd = 2, ylab = "F(x)", xlab = "x", main = paste0("Functia de repartitie pentru variabila aleatoare X² distribuita normal N(μ = ", input$mu, ", σ² = ", input$sigma, ")"))
                grid()
            })
            output$normala2Plot4 <- renderPlot({
                X8 = rnorm(input$n, mean = input$mu, sd = sqrt(input$sigma)) 
                X8 = X8 * X8
                x8 = cumsum(X8)
                cdfEmpiric = ecdf(X8)
                plot(cdfEmpiric, col = "#00bc83", lwd = 2, ylab = "F(x)", xlab = "x", main = paste0("Functia de repartitie pentru variabila aleatoare ∑(i = 1 → n)(Xᵢ)² distribuita normal N(μ = ", input$mu, ", σ² = ", input$sigma, ")"))
                grid()
            })
        }
        else if(input$distributie == "Exponentiala")
        {
            output$exponentialaPlot1 <- renderPlot({
                X9 = rexp(input$n, rate = input$lambda_exponentiala)
                X9 = X9
                cdfEmpiric = ecdf(X9)
                plot(cdfEmpiric, col = "#00bc83", lwd = 2, ylab = "F(x)", xlab = "x", main = paste0("Functia de repartitie pentru variabila aleatoare X distribuita exponential Exp(λ = ", input$lambda_exponentiala, ")"))
                grid()
            })
            output$exponentialaPlot2 <- renderPlot({
                X10 = rexp(input$n, rate = input$lambda_exponentiala)
                X10 = 2 - 5 * X10
                cdfEmpiric = ecdf(X10)
                plot(cdfEmpiric, col = "#00bc83", lwd = 2, ylab = "F(x)", xlab = "x", main = paste0("Functia de repartitie pentru variabila aleatoare 2 - 5X distribuita exponential Exp(λ = ", input$lambda_exponentiala, ")"))
                grid()
            })
            output$exponentialaPlot3 <- renderPlot({
                X11 = rexp(input$n, rate = input$lambda_exponentiala)
                X11 = X11 * X11
                cdfEmpiric = ecdf(X11)
                plot(cdfEmpiric, col = "#00bc83", lwd = 2, ylab = "F(x)", xlab = "x", main = paste0("Functia de repartitie pentru variabila aleatoare X² distribuita exponential Exp(λ = ", input$lambda_exponentiala, ")"))
                grid()
            })
            output$exponentialaPlot4 <- renderPlot({
                X12 = rexp(input$n, rate = input$lambda_exponentiala)
                X12 = cumsum(X12)
                cdfEmpiric = ecdf(X12)
                plot(cdfEmpiric, col = "#00bc83", lwd = 2, ylab = "F(x)", xlab = "x", main = paste0("Functia de repartitie pentru variabila aleatoare ∑(i = 1 → n)Xᵢ distribuita exponential Exp(λ = ", input$lambda_exponentiala, ")"))
                grid()
            })
        }
        else if(input$distributie == "Poisson")
        {
            output$PoissonPlot1 <- renderPlot({
                X13 = rpois(input$n, lambda = input$lambda_poisson)
                X13 = X13
                cdfEmpiric = ecdf(X13)
                plot(cdfEmpiric, col = "#00bc83", lwd = 2, ylab = "F(x)", xlab = "x", main = paste0("Functia de repartitie pentru variabila aleatoare X distribuita Poisson Pois(λ = ", input$lambda_poisson, ")"))
                grid()
            })
            output$PoissonPlot2 <- renderPlot({
                X14 = rpois(input$n, lambda = input$lambda_poisson)
                X14 = 3 + 2 * X14
                cdfEmpiric = ecdf(X14)
                plot(cdfEmpiric, col = "#00bc83", lwd = 2, ylab = "F(x)", xlab = "x", main = paste0("Functia de repartitie pentru variabila aleatoare 3 + 2X distribuita Poisson Pois(λ = ", input$lambda_poisson, ")"))
                grid()
            })
            output$PoissonPlot3 <- renderPlot({
                X15 = rpois(input$n, lambda = input$lambda_poisson)
                X15 = X15 * X15
                cdfEmpiric = ecdf(X15)
                plot(cdfEmpiric, col = "#00bc83", lwd = 2, ylab = "F(x)", xlab = "x", main = paste0("Functia de repartitie pentru variabila aleatoare X² distribuita Poisson Pois(λ = ", input$lambda_poisson, ")"))
                grid()
            })
            output$PoissonPlot4 <- renderPlot({
                X16 = rpois(input$n, lambda = input$lambda_poisson)
                X16 = cumsum(X16)
                cdfEmpiric = ecdf(X16)
                plot(cdfEmpiric, col = "#00bc83", lwd = 2, ylab = "F(x)", xlab = "x", main = paste0("Functia de repartitie pentru variabila aleatoare ∑(i = 1 → n)Xᵢ distribuita Poisson Pois(λ = ", input$lambda_poisson, ")"))
                grid()
            })
        }
        else if(input$distributie == "Binomiala")
        {
            output$BinomialaPlot1 <- renderPlot({
                X17 = rbinom(input$n, size = input$r, prob = input$p)
                X17 = X17
                cdfEmpiric = ecdf(X17)
                plot(cdfEmpiric, col = "#00bc83", lwd = 2, ylab = "F(x)", xlab = "x", main = paste0("Functia de repartitie pentru variabila aleatoare X distribuita Binomial Binom(r = ", input$r, ", p = ", input$p, ")"))
                grid()
            })
            output$BinomialaPlot2 <- renderPlot({
                X18 = rbinom(input$n, size = input$r, prob = input$p)
                X18 = 5 * X18 + 4
                cdfEmpiric = ecdf(X18)
                plot(cdfEmpiric, col = "#00bc83", lwd = 2, ylab = "F(x)", xlab = "x", main = paste0("Functia de repartitie pentru variabila aleatoare 5X + 4 distribuita Binomial Binom(r = ", input$r, ", p = ", input$p, ")"))
                grid()
            })
            output$BinomialaPlot3 <- renderPlot({
                X19 = rbinom(input$n, size = input$r, prob = input$p)
                X19 = X19 * X19
                cdfEmpiric = ecdf(X19)
                plot(cdfEmpiric, col = "#00bc83", lwd = 2, ylab = "F(x)", xlab = "x", main = paste0("Functia de repartitie pentru variabila aleatoare X² distribuita Binomial Binom(r = ", input$r, ", p = ", input$p, ")"))
                grid()
            })
            output$BinomialaPlot4 <- renderPlot({
                X20 = rbinom(input$n, size = input$r, prob = input$p)
                X20 = cumsum(X20)
                cdfEmpiric = ecdf(X20)
                plot(cdfEmpiric, col = "#00bc83", lwd = 2, ylab = "F(x)", xlab = "x", main = paste0("Functia de repartitie pentru variabila aleatoare ∑(i = 1 → n)Xᵢ distribuita Binomial Binom(r = ", input$r, ", p = ", input$p, ")"))
                grid()
            })
        }
    })
    
}

shinyApp(ui = ui, server = server)


