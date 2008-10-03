\name{geom_segment}
\alias{geom_segment}
\alias{GeomSegment}
\title{geom\_segment}
\description{Single line segments}
\details{
This page describes geom\_segment, see \code{\link{layer}} and \code{\link{qplot}} for how to create a complete plot from individual components.
}
\section{Aesthetics}{
The following aesthetics can be used with geom\_segment.  Aesthetics are mapped to variables in the data with the \code{\link{aes}} function: \code{geom\_segment(\code{\link{aes}}(x = var))}
\itemize{
  \item \code{x}: x position (\strong{required}) 
  \item \code{y}: y position (\strong{required}) 
  \item \code{xend}: NULL (\strong{required}) 
  \item \code{yend}: NULL (\strong{required}) 
  \item \code{colour}: border colour 
  \item \code{size}: size 
  \item \code{linetype}: line type 
}
}
\usage{geom_segment(mapping=NULL, data=NULL, stat="identity", position="identity", ...)}
\arguments{
 \item{mapping}{mapping between variables and aesthetics generated by aes}
 \item{data}{dataset used in this layer, if not specified uses plot dataset}
 \item{stat}{statistic used by this layer}
 \item{position}{position adjustment used by this layer}
 \item{...}{other arguments}
}
\seealso{\itemize{
  \item \code{\link{geom_path}}: Connect observations, in original order
  \item \code{\link{geom_line}}: Connect observations, in ordered by x value
  \item \url{http://had.co.nz/ggplot2/geom_segment.html}
}}
\value{A \code{\link{layer}}}
\examples{\dontrun{
require("maps")

xlim <- range(seals$long)
ylim <- range(seals$lat)
usamap <- data.frame(map("world", xlim = xlim, ylim = ylim, plot =
FALSE)[c("x","y")])
usamap <- rbind(usamap, NA, data.frame(map('state', xlim = xlim, ylim
= ylim, plot = FALSE)[c("x","y")]))
names(usamap) <- c("long", "lat")

p <- ggplot(seals, aes(x = long, y = lat))
(p <- p + geom_segment(aes(xend = long + delta_long, yend = lat + delta_lat), arrow=arrow(length=unit(0.1,"cm"))))
p + geom_path(data = usamap) + scale_x_continuous(limits=xlim)

}}
\author{Hadley Wickham, \url{http://had.co.nz/}}
\keyword{hplot}
