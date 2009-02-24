\name{geom_contour}
\alias{geom_contour}
\alias{GeomContour}
\title{geom\_contour}
\description{Display contours of a 3d surface in 2d}
\details{
This page describes geom\_contour, see \code{\link{layer}} and \code{\link{qplot}} for how to create a complete plot from individual components.
}
\section{Aesthetics}{
The following aesthetics can be used with geom\_contour.  Aesthetics are mapped to variables in the data with the \code{\link{aes}} function: \code{geom\_contour(\code{\link{aes}}(x = var))}
\itemize{
  \item \code{x}: x position (\strong{required}) 
  \item \code{y}: y position (\strong{required}) 
  \item \code{weight}: observation weight used in statistical transformation 
  \item \code{colour}: border colour 
  \item \code{size}: size 
  \item \code{linetype}: line type 
}
}
\usage{geom_contour(mapping=NULL, data=NULL, stat="contour", position="identity", ...)}
\arguments{
 \item{mapping}{mapping between variables and aesthetics generated by aes}
 \item{data}{dataset used in this layer, if not specified uses plot dataset}
 \item{stat}{statistic used by this layer}
 \item{position}{position adjustment used by this layer}
 \item{...}{ignored }
}
\seealso{\itemize{
  \item \code{\link{geom_density2d}}: Draw 2d density contours
  \item \url{http://had.co.nz/ggplot2/geom_contour.html}
}}
\value{A \code{\link{layer}}}
\examples{\dontrun{
# See stat_contour for examples
}}
\author{Hadley Wickham, \url{http://had.co.nz/}}
\keyword{hplot}