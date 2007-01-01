ScaleGradient <- proto(ScaleContinuous, expr={

	new <- function(., name=NULL, low="darkblue", high="yellow", space="rgb", limits=c(NA,NA), trans="identity", alpha = 1, ..., variable) {
		if (is.character(trans)) trans <- Trans$find(trans)
		proto(., name=name, low=low, high=high, space=space, .input=variable, .output=variable, .tr = trans, limits=limits, alpha = alpha, ...)
	}
	
	map <- function(., x) {
		rng <- .$frange()
		domain <- .$domain()
		x[x < domain[1] | x > domain[2]] <- NA

		ramp  <- colorRamp(c(.$low, .$high),  space=.$space, interpolate="linear")
		
		x <- (x - rng[1]) / diff(rng)
		
		nice_ramp(ramp, x, .$alpha)
	}
	
	rbreaks <- function(.) .$map(.$breaks())
	guide_legend_geom <- function(.) GeomTile
	common <- c("colour", "fill")

	# Documetation -----------------------------------------------
	
	objname <- "gradient"
	desc <- "Smooth colour gradient"
	icon <- function(.) {
		g <- scale_fill_gradient()
		g$train(1:5)
		rectGrob(c(0.1, 0.3, 0.5, 0.7, 0.9), width=0.21, 
			gp=gpar(fill=g$map(1:5), col=NA)
		)		
	}


	desc_params <- list(
		low = "colour at low end of scale", 
		high = "colour at high end of scale",
		alpha = "alpha value to use for colours",
		space = "colour space to interpolate through, rgb or Lab, see ?colorRamp for details",
		interpolate = "type of interpolation to use, linear or spline, see ?colorRamp for more details"
	)
	seealso <- list(
		"scale_colour_gradient2" = "continuous colour scale with midpoint",
		"colorRamp" = "for details of interpolation algorithm"
	)
	
	examples <- function(.) {
		# It's hard to see, but look for the bright yellow dot 
		# in the bottom right hand corner
		dsub <- subset(diamonds, x > 5 & x < 6 & y > 5 & y < 6)
		(d <- qplot(x, y, data=dsub, colour=z))
		# That one point throws our entire scale off.  We could
		# remove it, or manually tweak the limits of the scale
		
		# Tweak scale limits.  Any points outside these
		# limits will not be plotted, but will continue to affect the 
		# calculate of statistics, etc
		d + scale_colour_gradient(limits=c(3, 10))
		d + scale_colour_gradient(limits=c(3, 4))
		# Setting the limits manually is also useful when producing
		# multiple plots that need to be comparable
		
		# Alternatively we could try transforming the scale:
		d + scale_colour_gradient(trans = "log")
		d + scale_colour_gradient(trans = "sqrt")
		
		# Other more trivial manipulations, including changing the name
		# of the scale and the colours.

		d + scale_colour_gradient("Depth")
		d + scale_colour_gradient(expression(Depth[mm]))
		
		d + scale_colour_gradient(limits=c(3, 4), low="red")
		d + scale_colour_gradient(limits=c(3, 4), low="red", high="white")
		# Much slower
		d + scale_colour_gradient(limits=c(3, 4), low="red", high="white", space="Lab")
		d + scale_colour_gradient(limits=c(3, 4), space="Lab")
		
		# Can also make partially transparent
		d + scale_colour_gradient(limits=c(3, 4), alpha=0.5)
		
		# scale_fill_continuous works similarly, but for fill colours
		(h <- qplot(x - y, data=dsub, geom="histogram", binwidth=0.01, fill=..count..))
		h + scale_fill_continuous(low="black", high="white", limits=c(0,NA))
	}
	
	
})

ScaleGradient2 <- proto(ScaleContinuous, expr={	
	new <- function(., name=NULL, low="red", mid="white", high="black", midpoint=0, space="rgb", limits=c(NA,NA), trans="identity", alpha=1, ..., variable) {
		if (is.character(trans)) trans <- Trans$find(trans)
		proto(., name=name, low=low, mid=mid, high=high, midpoint=midpoint, space=space, ..., .input=variable, .output=variable, .tr=trans, limits=limits, alpha=alpha)
	}
	
	map <- function(., x) {
		rng <- .$frange()  - .$midpoint
		domain <- .$domain()
		x[x < domain[1] | x > domain[2]] <- NA

		ramp  <- colorRamp(c(.$low, .$mid, .$high),  space=.$space, interpolate="linear")
		
		x <- x - .$midpoint
		x <- x / ifelse(x < 0, -rng[1], rng[2]) / 2 + 0.5
		
		nice_ramp(ramp, x, .$alpha)
	}
	
	rbreaks <- function(.) .$map(.$breaks())
	guide_legend_geom <- function(.) GeomTile
	
	objname <-"gradient2"
	common <- c("colour", "fill")
	desc <- "Smooth colour gradient, with midpoint"

	icon <- function(.) {
		g <- scale_fill_gradient2()
		g$train(1:5 - 3)
		rectGrob(c(0.1, 0.3, 0.5, 0.7, 0.9), width=0.21, 
			gp=gpar(fill=g$map(1:5 - 3), col=NA)
		)
	}

	desc_params <- list(
		low = "colour at low end of scale", 
		mid = "colour at mid point of scale",
		high = "colour at high end of scale",
		midpoint = "position of mid point of scale, defaults to 0",
		alpha = "alpha value to use for colours",
		space = "colour space to interpolate through, rgb or Lab, see ?colorRamp for details",
		interpolate = "type of interpolation to use, linear or spline, see ?colorRamp for more details"
	)
	seealso <- list(
		"scale_color_gradient" = "continuous colour scale with midpoint",
		"colorRamp" = "for details of interpolation algorithm"
	)
	
	examples <- function(.) {
		dsub <- subset(diamonds, x > 5 & x < 6 & y > 5 & y < 6)
		(d <- qplot(x, y, data=dsub, colour=x-y))
		
		d + scale_colour_gradient2()
		# Change scale name
		d + scale_colour_gradient2(expression(x - y))
		d + scale_colour_gradient2("Difference\nbetween\nwidth and\nheight")

		# Change limits and colours
		d + scale_colour_gradient2(limits=c(-0.2, 0.2))
		d + scale_colour_gradient2(mid="black", high="yellow", low="yellow")
		
		# You can also use a non-zero midpoint
		(d <- qplot(carat, price, data=diamonds, colour=price/carat))
		d + scale_colour_gradient2(midpoint=mean(diamonds$price / diamonds$carat), high="darkgreen", mid="yellow")
		
		# Fill gradients work much the same way
	}
	
})
ScaleColourContinuous <- proto(ScaleGradient, objname="continuous", doc=FALSE, examples=function(.) {})
