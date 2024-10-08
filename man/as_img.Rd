% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/as_img.R
\name{as_img}
\alias{as_img}
\title{As Image}
\usage{
as_img(x, ...)
}
\arguments{
\item{x}{object to convert to image}

\item{...}{additional arguments}
}
\description{
Convert an object to an image by rendering the object in its own RMarkdown
file and taking a webshot.
}
\examples{
\dontrun{
library(table1)

as_img(table1(~mpg, data = mtcars))
}
}
