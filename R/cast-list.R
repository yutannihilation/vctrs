#' Cast a list to vector of specific type
#'
#' This is a function for developers to use when extending vctrs. It casts
#' a list to a more specific vectoring type, keeping the length constant.
#' It does this by discarding (with a warning), any elements after the 1.
#' It is called from `vec_cast.XYZ.list()` methods to preserve symmetry with
#' `vec_cast.list.XYZ()`.
#'
#' See `vignette("s3-vector")` for details.
#'
#' @param x A list
#' @param to Type to coerce to
#' @export
#' @keywords internal
vec_list_cast <- function(x, to) {
  ns <- map_int(x, length)

  lossy <- ns != 1L
  if (any(lossy)) {
    warn_lossy_cast(x, to, locations = which(lossy))
  }

  n <- length(x)
  out <- vec_na(to, n)

  for (i in seq_len(n)) {
    val <- x[[i]]
    if (length(val) == 0)
      next

    out[[i]] <- vec_cast(val[[1]], to)
  }

  shape_recycle(out, to)
}
