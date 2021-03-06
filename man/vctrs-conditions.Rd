% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/conditions.R
\name{vctrs-conditions}
\alias{vctrs-conditions}
\alias{stop_incompatible_type}
\alias{stop_incompatible_cast}
\alias{warn_lossy_cast}
\title{Custom conditions for vctrs package}
\usage{
stop_incompatible_type(x, y, details = NULL, ..., message = NULL,
  .subclass = NULL)

stop_incompatible_cast(x, y, details = NULL, ..., message = NULL,
  .subclass = NULL)

warn_lossy_cast(x, y, locations = NULL, details = NULL, ...,
  message = NULL, .subclass = NULL)
}
\arguments{
\item{x, y}{Vectors}

\item{details}{Any additional human readable details}

\item{..., message, .subclass}{Only use these fields when creating a subclass.}

\item{locations}{For \code{warn_lossy_cast()}, an optional vector giving the
locations where \code{x} lost information.}

\item{subclass}{Use if you want to further customise the class}
}
\description{
These errors and warnings have custom classes and structures to make
testing easier.
}
\keyword{internal}
