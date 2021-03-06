% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/extract.R
\name{extract}
\alias{extract}
\alias{extract,function,data.frame-method}
\title{extract}
\usage{
\S4method{extract}{`function`,data.frame}(x, y, ctstime = FALSE, fact = NULL, verbose = TRUE, ...)
}
\arguments{
\item{x}{A raadtools read function.}

\item{y}{Object to use for querying from the raadtools read functions, such as a vector of character, Date, or POSIXt values,  data.frame, trip, etc.}

\item{ctstime}{specify whether to find the nearest value in time (\code{FALSE}), or interpolate between slices (\code{TRUE})}

\item{fact}{integer. Aggregation factor expressed as number of cells in each direction (horizontally and vertically). Or two integers (horizontal and vertical aggregation factor). See Details in \code{\link[raster]{aggregate}}}

\item{verbose}{report on progress or keep quiet}

\item{...}{Additional arguments passed to the read function.}
}
\value{
data values extracted by the read functions
}
\description{
Extract methods for raadtools read functions
}
\details{
Extract data from read functions in various ways.
}
\examples{

a <- structure(list(x = c(174, 168, 156, 111, 99, 64, 52, 46, -4,
-15, -30, -38, -47, -62, -87, -127, -145, -160, -161), y = c(-72,
-39, -50, -58, -35, -38, -48, -60, -48, -35, -37, -51, -68, -72,
-69, -54, -40, -49, -54)), .Names = c("x", "y"), row.names = c(NA,
-19L), class = "data.frame")

a$time <- structure(c(5479, 5479, 5479, 5479, 5479, 5479, 5479, 5479, 5479,
5479, 5479, 5489, 5529, 5529, 5529, 5579, 5579, 5579, 5579), class = "Date")
extract(readsst, a)
extract(readsst, a, method = "bilinear")
a$time <-  sort(as.Date("2005-01-01") + sample(c(0, 0, 0, 8, 20, 50), nrow(a), replace = TRUE))
extract(readsst, a)
}
\seealso{
\code{\link{readsst}} and \code{\link{extract}}
}
