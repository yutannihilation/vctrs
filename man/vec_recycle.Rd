% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/recycle.R
\name{vec_recycle}
\alias{vec_recycle}
\title{Recycle vector types to common shape}
\usage{
vec_recycle(...)
}
\arguments{
\item{...}{Vectors to recycle.}
}
\value{
A list of input vectors recycled to common shape, or an error
stating that a common shape could not be found.
}
\description{
The vctrs takes on recycling is both broader and stricter than base R.
As a general rule, we only ever recycle 1-d slices of high-d arrays.
This means we'll recycle a scalar to a vector, but not a length-2 vector
to a length-10 vector. Recycling arrays takes dimension into account so
that (e.g.) row and col vectors are fill a matrix as you might expect.
}
\details{
Recycling support is half-baked currently so please don't rely on this API.

This is called broadcasting in numpy and julia.
}
\examples{
# Only vectors of length 1 are recycled
vec_recycle(1:5, 5)
\dontrun{
vec_recycle(1:5, 1:2)
}

# Recycling respects dimensions
vec_recycle(
  matrix(1:6, nrow = 2),
  matrix(1:2, nrow = 2),
  matrix(1:3, nrow = 1),
  0
)
}
