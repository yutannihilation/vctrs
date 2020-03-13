#' AsIs S3 class
#'
#' These functions help the base AsIs class fit into the vctrs type system
#' by providing coercion and casting functions.
#'
#' @keywords internal
#' @name as-is
NULL

# ------------------------------------------------------------------------------
# Printing

#' @export
vec_ptype_full.AsIs <- function(x, ...) {
  x <- asis_strip(x)
  paste0("I<", vec_ptype_full(x), ">")
}

#' @export
vec_ptype_abbr.AsIs <- function(x, ...) {
  x <- asis_strip(x)
  paste0("I<", vec_ptype_abbr(x), ">")
}

# ------------------------------------------------------------------------------
# Proxy / restore

# Arises with base df ctor: `data.frame(x = I(list(1, 2:3)))`

#' @export
vec_proxy.AsIs <- function(x, ...) {
  x <- asis_strip(x)
  vec_proxy(x)
}

#' @export
vec_restore.AsIs <- function(x, to, ...) {
  asis_restore(x)
}

# ------------------------------------------------------------------------------
# Coercion

#' @rdname as-is
#' @export vec_ptype2.AsIs
#' @method vec_ptype2 AsIs
#' @export
vec_ptype2.AsIs <- function(x, y, ..., x_arg = "x", y_arg = "y") {
  UseMethod("vec_ptype2.AsIs", y)
}

#' @method vec_ptype2.AsIs default
#' @export
vec_ptype2.AsIs.default <- function(x, y, ..., x_arg = "x", y_arg = "y") {
  x <- asis_strip(x)
  vec_ptype2_asis(x, y, ..., x_arg = x_arg, y_arg = y_arg)
}

#' @method vec_ptype2.AsIs AsIs
#' @export
vec_ptype2.AsIs.AsIs <- function(x, y, ..., x_arg = "x", y_arg = "y") {
  x <- asis_strip(x)
  y <- asis_strip(y)
  vec_ptype2_asis(x, y, ..., x_arg = x_arg, y_arg = y_arg)
}

vec_ptype2_asis <- function(x, y, ...) {
  out <- vec_ptype2(x, y, ...)
  asis_restore(out)
}

# ------------------------------------------------------------------------------
# Casting

#' @rdname as-is
#' @export vec_cast.AsIs
#' @method vec_cast AsIs
#' @export
vec_cast.AsIs <- function(x, to, ...) {
  vec_cast_to_asis(x, to, ...)
}

vec_cast_from_asis <- function(x, to, ...) {
  x <- asis_strip(x)
  vec_cast(x, to, ...)
}

vec_cast_to_asis <- function(x, to, ...) {
  to <- asis_strip(to)
  out <- vec_cast(x, to, ...)
  asis_restore(out)
}

# ------------------------------------------------------------------------------

is_asis <- function(x) {
  inherits(x, "AsIs")
}

asis_strip <- function(x) {
  class(x) <- setdiff(class(x), "AsIs")
  x
}

asis_restore <- function(x) {
  # Using `oldClass()` here to return `NULL` for atomics
  # so that their implicit class isn't added
  class(x) <- c("AsIs", oldClass(x))
  x
}