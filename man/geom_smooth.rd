\name{geom_smooth}
\alias{geom_smooth}
\alias{GeomSmooth}
\title{geom\_smooth}
\description{Add a smoothed condition mean.}
\details{
This page describes geom\_smooth, see \code{\link{layer}} and \code{\link{qplot}} for how to create a complete plot from individual components.
}
\section{Aesthetics}{
The following aesthetics can be used with geom\_smooth.  Aesthetics are mapped to variables in the data with the \code{\link{aes}} function: \code{geom\_smooth(\code{\link{aes}}(x = var))}
\itemize{
  \item \code{x}: x position (\strong{required}) 
  \item \code{y}: y position (\strong{required}) 
  \item \code{colour}: border colour 
  \item \code{fill}: internal colour 
  \item \code{size}: size 
  \item \code{linetype}: line type 
  \item \code{weight}: observation weight used in statistical transformation 
  \item \code{alpha}: NULL 
}
}
\usage{geom_smooth(mapping=NULL, data=NULL, stat="smooth", position="identity", ...)}
\arguments{
 \item{mapping}{mapping between variables and aesthetics generated by aes}
 \item{data}{dataset used in this layer, if not specified uses plot dataset}
 \item{stat}{statistic used by this layer}
 \item{position}{position adjustment used by this layer}
 \item{...}{ignored }
}
\seealso{\itemize{
  \item \url{http://had.co.nz/ggplot2/geom_smooth.html}
}}
\value{A \code{\link{layer}}}
\examples{\dontrun{
# See stat_smooth for examples of using built in model fitting
# if you need some more flexible, this example shows you how to
# plot the fits from any model of your choosing

library(ggplot2)
qplot(wt, mpg, data=mtcars, colour=factor(cyl))

model <- lm(mpg ~ wt + factor(cyl), data=mtcars)
grid <- with(mtcars, expand.grid(
  wt = seq(min(wt), max(wt), length = 20),
  cyl = levels(factor(cyl))
))

grid$mpg <- predict(model, newdata=grid)

qplot(wt, mpg, data=mtcars, colour=factor(cyl)) + geom_line(data=grid)

# or with standard errors

err <- predict(model, newdata=grid, se = TRUE)
grid$ucl <- err$fit + 1.96 * err$se.fit
grid$lcl <- err$fit - 1.96 * err$se.fit

qplot(wt, mpg, data=mtcars, colour=factor(cyl)) + geom_smooth(aes(min=lcl, max=ucl), data=grid, stat="identity") 
}}
\author{Hadley Wickham, \url{http://had.co.nz/}}
\keyword{hplot}
