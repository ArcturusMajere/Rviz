library(plotly)
library(dplyr)

# Assume df is your data frame
df <- data.frame(
  year = rep(2021, 12),
  quarter = rep(1:4, each = 3),
  sector = rep(letters[1:3], 4),
  count = sample(1:100, 12)
)

# Create a new variable time_period combining year and quarter
df <- df %>%
  mutate(time_period = paste(year, "Q", quarter, sep=""))

# Create a circular barplot with animation over time_period
p <- plot_ly(
  df,
  type = 'barpolar',
  r = ~count,
  theta = ~sector,
  frame = ~time_period,
  color = ~sector,
  hoverinfo = 'r+theta'
) 

# Adding animation controls
animation <- p %>%
  layout(
    title = "Animated Circular Barplot by Time Period",
    updatemenus = list(
      list(
        type = 'buttons',
        showactive = FALSE,
        buttons = list(
          list(
            label = 'Play',
            method = 'animate',
            args = list(
              NULL,
              list(
                frame = list(duration = 2000, redraw = TRUE),  # Adjust duration to slow down transitions
                fromcurrent = TRUE
              )
            )
          ),
          list(
            label = 'Pause',
            method = 'animate',
            args = list(
              NULL,
              list(
                frame = list(duration = 0, redraw = TRUE),
                mode = 'immediate',
                transition = list(duration = 0)
              )
            )
          )
        )
      )
    ),
    polar = list(
      radialaxis = list(
        tickfont = list(size = 8),
        ticks = ''
      ),
      angularaxis = list(
        tickfont = list(size = 8),
        rotation = 90,
        direction = "clockwise"
      )
    )
  )

animation
