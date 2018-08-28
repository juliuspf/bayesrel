#' forces a quadratic matrix to be symmetrical
make.symmetric <- function(a, lower.tri=TRUE){
  if (lower.tri){
    ind <- upper.tri(a)
    a[ind] <- t(a)[ind]
  } else {
    ind <- lower.tri(a)
    a[ind] <- t(a)[ind]
  }
  a
}

#' computes alpha analytical interval with given bounds
ciAlpha <- function(palpha, n, V){
  p <- ncol(V)
  z <- qnorm(1 - palpha/2)
  b <- log(n/ (n - 1))
  j <- matrix(rep(1, p), nrow = p, ncol = 1)
  a0 <- t(j) %*% V %*% j
  t1 <- sum(diag(V))
  t2 <- sum(diag(V %*% V))
  a1 <- a0 ^ 3
  a2 <- a0 * (t2 + t1^2)
  a3 <- 2 * t1 * t(j) %*% (V %*% V) %*% j
  a4 <- 2 * p^2 / (a1 * (p - 1)^2)
  r <- (p/ (p-1)) * (1 - t1 / a0)
  var <- a4 * (a2 - a3) / (n - 3)
  ll <- 1 - exp(log(1 - r) - b + z * sqrt(var / (1 - r)^2))
  ul <- 1 - exp(log(1 - r) - b - z * sqrt(var / (1 - r)^2))
  out <- c(ll, ul)
  return(out)
}