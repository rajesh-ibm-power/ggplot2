GeomLine <- proto(GeomPath, {
	objname <- "line"
	desc <- "Connect observations, in ordered by x value"
	icon <- function(.) {
		pos <- seq(0, 1, length=5)
		linesGrob(pos, c(0.2, 0.7, 0.4, 0.8, 0.3))
	}
	
	default_stat <- function(.) StatSort
	
	seealso <- list(
		geom_path = GeomPath$desc,
		geom_segments = "Line segments",
		geom_ribbon = "Fill between line and x-axis"
	)
	
	examples <- function(.) {
		# Summarise number of movie ratings by year of movie
		mry <- do.call(rbind, by(movies, round(movies$rating), function(df) { 
			nums <- tapply(df$length, df$year, length)
			data.frame(rating=round(df$rating[1]), year = as.numeric(names(nums)), number=as.vector(nums))
		}))

		p <- ggplot(mry, aes(x=year, y=number, group=rating))
		p + geom_line()

		# Add aesthetic mappings
		p + geom_line(aes(size = rating))
		p + geom_line(aes(colour = rating))

		# Change scale
		p + geom_line(aes(colour = rating)) + scale_colour_gradient(low="red")
		
		# Set aesthetics to fixed value
		p + geom_line(colour = "red", size = 1)

		# Use qplot instead
		qplot(year, number, data=mry, group=rating, geom="line")
		qplot(year, number, data=mry, group=rating, geom="path", statistic="sortx")
	}
})
