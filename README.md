# Motivation
In the field of fisheries stock assessment, biologists model fish populations to estimate sustainable levels of fishing mortality. One important component of these models is the age structure of the fish population, which can be estimated by taking a sample of fish from the population and counting growth layers on a small ear bone called the otolith. This is similar to ageing a tree by counting growth rings.
This is a time consuming process and thus relatively expensive. It is easier to measure fish lengths; however, due to individual variation in growth rates, fish length does not correspond perfectly to fish age. We can consider observed fish lengths as resulting from a mixture of length distributions that correspond to age cohorts.

# Problem
Given a set of observations of fish lengths spanning three age cohorts, estimate the parameters of the Gaussian
(normal) distributions of length-at-age, when the age of each length observation is not known.

If we knew the component that each observation came from, we would use maximum likelihood to estimate
mean length ˆμk and standard deviation ˆk of each of the k ages. We would also know the proportion of
observations coming from each age cohort k. However, we do not know which component of the distribution
generated each observation (the generation process is “hidden” or “latent”). The key to the estimation
problem is therefore to assign labels (ages) to observations by some process, and subsequently perform
maximum likelihood estimation of ˆμk and ˆk. This assignment and estimation is performed repeatedly until
the parameter estimates cease changing.

