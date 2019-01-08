#Assignment 2
#Team K
# EM Algorithm -----------------------------------------------------------------------


includeknown <- function (data, posterior) {
  # Purpose: For the enhancement section of the assignment. Updates the posterior 
  #   probabilities matrix so that each known observation will have a probability of 
  #   1 when it belongs in their known group, and 0(s) for all the other groups.
  # Inputs:
  #   data - the dataframe of all the observations 
  #   posterior - a matrix of posterior probabilities with 'number of observations' 
  #     rows and 'number of groups' columns
  # Outputs:
  #   posterior - an updated matrix of posterior probabilities with 'number of observations' 
  #     rows and 'number of groups' columns
  
  # Input checks
  if (!is.data.frame(data) | !is.numeric(posterior)) {
    stop("Invalid arguments")
  }
  
  # Loop around each observation
  for (k in 1:length(data[, 1])) {
    # Loop around each group
    for (m in 1:max(data[, 3], na.rm = TRUE)) {
      # If the observation belongs to a known group, update the probabilities in the 
      #   posterior matrix to 1 for that known group, and 0(s) everywhere else
      if (identical(data[k, 3], as.numeric(m))) {
        posterior[k, ] <- rep(0, max(data[, 3], na.rm = TRUE))
        posterior[k, m] <- 1
      }
    }
  }
  
  return(posterior)
}


initialisation <- function (data) {
  # Purpose: Calculates the initial values of mean, standard deviation and lambda
  #   for each group and stores these estimated parameters into a matrix  
  # Inputs: 
  #   data - the dataframe of all the observations
  # Outputs:
  #   inits - a matrix with mean, standard deviations and lambda (columns) for each 
  #     group (row) of the known observations
  
  # Input checks
  if (!is.data.frame(data)) {
    stop("Invalid arguments")
  }
  
  # Finds the number of groups
  k <- max(data[, 3], na.rm = TRUE)
  total <- rep(0, k)
  number <- rep(0, k)
  sigma <- rep(0, k)
  
  # Finds the sum (total) and the number (number) of known observations for each group
  for (i in 1:k) {
    total[i] <- sum(subset(data$Length, data$Age == i))
    number[i] <- length(subset(data$Length, data$Age == i))
  }
  
  # Calculates the initial parameter estimates (mean, standard deviation, lambda)
  mu <- total / number
  for (i in 1:k) {
    sigma[i] <- sqrt((sum((subset(data$Length, data$Age == i) - mu[i]) ** 2) 
                      / (number[i] - 1)))
  }
  lambda <- number / length(subset(data$Length, is.na(data$Age) == FALSE))
  
  # Initialise the inits matrix and put the parameter estimates in the corresponding columns
  inits <- matrix(nrow = k, ncol = 3)
  dimnames(inits) <- list(rownames(inits, do.NULL = FALSE, prefix = "Age"))
  colnames(inits) <- c("mu", "sigma", "lambda")
  inits[, 1] <- mu
  inits[, 2] <- sigma
  inits[, 3] <- lambda
  
  return(inits)
}


expectation <- function (data, estimates) {
  # Purpose: Calculates probabilities of each observation being in a certain group, 
  #   using Bayes' Rule
  # Inputs: 
  #   data - the dataframe of all the observations
  #   estimates - a matrix with mu, sd and lambda (columns) for each group (row)
  # Outputs:
  #   posterior - a matrix of posterior probabilities with 'number of observations' 
  #     rows and 'number of groups' columns

  # Input checks
  if (!is.data.frame(data) | !is.numeric(estimates)) {
    stop("Invalid arguments")
  }
  
  # Finds the number of groups
  k <- max(data[, 3], na.rm = TRUE)
  # Initialises a vector for the probabilities for each group
  probabilities <- rep(0, k)
  
  # Create the posterior matrix
  posterior <- matrix(nrow = length(data[, 1]), ncol = max(data[, 3], na.rm = TRUE))
  dimnames(posterior) <- list(rownames(posterior, do.NULL = FALSE, prefix = "Fish"),
                              colnames(posterior, do.NULL = FALSE, prefix = "Age"))
  
  # Implement Bayes' Rule for every observation
  for (i in 1:nrow(data)) {
    # Grabs the vector of observations from the dataframe
    xi <- data[i, 2]
    denom <- 0
    for (j in 1:k) {
      denom <- denom + dnorm(xi, estimates[j, 1], estimates[j, 2]) * estimates[j, 3]
    }
    # Calculates a vector of probabilities of a single observation belonging to a certain group
    for (l in 1:k) {
      probabilities[l] <- (dnorm(xi, estimates[l, 1], estimates[l, 2]) * estimates[l, 3]) / denom
    }
    # Puts the vector of probabilities into a row in the posterior probabilities matrix
    posterior[i, ] <- probabilities
  }
  
  return(posterior)
}


maximisation <- function (posterior, data) {
  # Purpose: Calculates parameter estimates (mu, sd, lambda) for each group
  #   posterior - a matrix of posterior probabilities with 'number of observations' 
  #     rows and 'number of groups' columns
  #   data - vector of all the observations
  # Outputs:
  #   estimates - a matrix with mu, sd and lambda (columns) for each group (row)
  
  # Input checks
  # Check if the values of posterior are between 0 and 1
  posterior.vector <- as.vector(posterior)
  is.probability.values <- all(posterior.vector <= 1 & posterior.vector >= 0)
  
  if (!is.vector(data) | !is.numeric(posterior) | !is.probability.values) {
    stop("Invalid arguments")
  }
  
  # Finds the number of groups
  k <- ncol(posterior)
  
  # Initialise the estimates matrix
  estimates <- matrix(rep(0, k), nrow = k, ncol = 3)
  dimnames(estimates) <- list(rownames(estimates, do.NULL = FALSE, prefix = "Age"))
  colnames(estimates) <- c("mu", "sigma", "lambda")
  
  for (i in 1:k) {
    # Finds the sum of each group
    total <- sum(posterior[, i])
    # Calculates the mean of each group and puts it into the first column
    estimates[i, 1] <- sum(posterior[, i] * data) / total
    # Calculates the standard deviation of each group and puts it into the second column
    estimates[i, 2] <- sqrt(sum(posterior[, i] * (data - estimates[i, 1]) ** 2) / total)
    # Calculates lambda of each group and puts it into the third column
    estimates[i, 3] <- total / length(data)
  }
  
  return(estimates)
}


calclikelihood <- function (data, estimates) {
  # Purpose: Calculates the log-likelihood value given the parameter estimates
  # Inputs: 
  #   data - the dataframe of all the observations
  #   estimates - a matrix with mu, sd and lambda (columns) for each group (row)
  # Outputs:
  #   sumloglikelihood - a log-likelihood value

  # Input checks
  if (!is.data.frame(data) | !is.matrix(estimates) | !is.numeric(estimates)) {
    stop("Invalid arguments")
  }
  
  sumloglikelihood <- 0
  k <- max(data[, 3], na.rm = TRUE)
  l <- length(data$Length)
  
  # Loop around each observation
  for (i in 1:l) {
    # Loop around each group
    for (j in 1:k) {
      sumlikelihood <- 0
      # Calculates the likelihood
      sumlikelihood <- sumlikelihood + estimates[j, 3] * dnorm(data$Length[i], 
                        estimates[j, 1], estimates[j, 2])
    }
    # Logs the sum of the likelihoods
    sumloglikelihood <- sumloglikelihood + log(sumlikelihood)
  }
  
  return(sumloglikelihood)
}


teamEM <- function (data, epsilon = 1e-08, maxit = 1000, include = FALSE) {
  # Purpose: Implentation of the EM algorithm which consists of initialisation followed 
  #   by iteration over expectation and maximization, with a log-likelihood test 
  #   for convergence which will determine when iteration can stop.
  # Inputs: 
  #   data - the dataframe of all the observations
  #   epsilon - tolerance value, with a default value 1e-08
  #   maxit - the maximum number of iterations, with a default value 1000
  #   include - a boolean value, letting the user decide whether to use the 
  #     known probabilities in the EM algorithm (enhancement)
  # Outputs:
  #   estimates - a matrix with mu, sd and lambda (columns) for each group (row)
  #   inits - a matrix with mu, sd and lambda (columns) for each group (row) of 
  #     the known observations
  #   converged - a boolean (TRUE or FALSE) value indicating whether algorithm converged
  #   posterior - a matrix of posterior probabilities with 'number of observations' 
  #     rows and 'number of groups' columns
  #   likelihood - vector of log-likelihood values, one for each iteration of the 
  #     algorithm; vector length is the number of iterations of the algorithm
  
  # Input checks
  if (!is.data.frame(data) | !is.logical(include) | !is.numeric(maxit) | !is.numeric(epsilon)) {
    stop("Invalid arguments")
  }
  
  # A counter for the number of iterations to convergence
  count <- 1
  converged <- FALSE
  likelihood <- rep(0, maxit)
  
  # Initialisation
  inits <- initialisation(data)
  estimates <- inits
  
  # Loop around the maximum number of iterations desired for convergence
  for (i in 1:maxit) {
    posterior <- expectation(data, estimates)
    # Gives the user a choice to use the known probabilities (enhancement)
    if (include == TRUE) {
      posterior <- includeknown(data, posterior)
    }
    estimates <- maximisation(posterior, data$Length)
    # Stores the log-likelihood value into the ith element
    likelihood[i] <- calclikelihood(data, estimates)
    
    # Calculates the difference between the loglikelihoods of the current and 
    #   previous iteration by comparing the adjacent vector elements
    if (i > 1) {
      difference <- likelihood[i] - likelihood[i - 1]
      # Compares the difference to the tolerance value - if TRUE, the for loop breaks, 
      #   and the calculations will stop. It will jump out to the return statements.
      if (abs(difference) < epsilon) {
        converged <- TRUE
        break
      } 
    }
    count <- count + 1
  }

  list <- list(estimates, inits, converged, posterior, likelihood[1:count])
  names(list) <- c("Estimates", "Inits", "Converged", "Posterior", "Likelihood")
  return(list)
}


