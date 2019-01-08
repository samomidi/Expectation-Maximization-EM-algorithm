# Motivation
In the field of fisheries stock assessment, biologists model fish populations to estimate sustainable levels of
fishing mortality. One important component of these models is the age structure of the fish population, which
can be estimated by taking a sample of fish from the population and counting growth layers on a small ear
bone called the otolith. This is similar to ageing a tree by counting growth rings.
This is a time consuming process and thus relatively expensive. It is easier to measure fish lengths; however,
due to individual variation in growth rates, fish length does not correspond perfectly to fish age. We can
consider observed fish lengths as resulting from a mixture of length distributions that correspond to age
cohorts.
In this assignment, you will be given 1000 fish length measurements, 100 of which are of known age. Your
task is to determine the mean and standard deviation of the expected length-at-age for each age cohort in
the sample and estimate the proportion of the sample that belongs to each age cohort.

## Task 1: Data exploration


![fishboxplot](https://user-images.githubusercontent.com/32543461/46751739-4c881880-ccb3-11e8-902f-aa1cf3d46db1.jpeg)


![frequency](https://user-images.githubusercontent.com/32543461/46906789-17710580-cf01-11e8-9445-60c313ddcae6.jpeg)



An initial descriptive statistic summary is conducted to explore potential relationships and properties of the dataset. This section looks at the frequencies of variable fish-length and relationship of fish-age across our variable length. The exploratory data analysis was produced with the help of R software and related packages. 
There are 100 observations with known fish-age that this analysis is based on. 
Looking at the boxplot illustrated above (graph 1) we can see that mean and median of age groups 2 and 3 are slightly different. As can be seen, this difference is due to number of outliers above mean in age group 2 which pushes the median higher and in group 3 outliers pull the median down when comparing it with the mean of its group.
Additionally, looking at age groups and their outliers, while the IQR areas (box areas) of each group don’t overlap along the y axis, there are few outliers from groups 1 and 3 which share the same length with group 2.  This shows the data is normally distributed which will be clearer when plotting the frequency graph of this dataset.
Graph 2 shows the frequency of the 100 fish. A high number of them are concentrated around length 45. This frequency is reasonably symmetric other than a slight peak around length 20. The general shape is not too far from the idealized normal “bell” curve. Given more observations, the graph would be more similar to the normal "bell" curve.



## Task 2: Methods description

In the teamEM function, a for-loop is run over the maximum number of iterations. The first iteration is in an if statement; the other iterations are in the else statement. In the first iteration, the initial estimated parameters (mean, standard deviation, lambda) is found from the 100 known fish lengths to start the EM algorithm. This algorithm contains the expectation function, which finds the probabilities of each fish length corresponding to an age group, and the maximisation function, which finds the parameter estimates, given the probabilities from the expectation function. The log-likelihood function calculates the log-likelihood by using the estimated parameters from the maximisation function and is entered into the first element of an initialised vector of maximum iteration size (a counter will crop this using the number of iterations to convergence).
In the else statement, the probabilities are updated using the estimated parameters and the estimated parameters are also updated by calling these new probabilities, using the EM algorithm functions. The log-likelihood is calculated from the updated estimated parameters and is entered into the ith element of the log-likelihood vector, corresponding to the ith iteration. 
The difference between the log-likelihoods calculated from the current and previous iteration is found by comparing elements in the log-likelihood vector. If this difference is smaller than the tolerance value, then the EM algorithm has converged; the likelihood of data, given the estimated parameters, changes insignificantly, and the iteration stops. The current estimated parameters are extremely close to the expected parameter estimates. 

Below is a diagram of the team's approach to the problem.

![teamem](https://user-images.githubusercontent.com/43880216/47170595-55559b80-d2fe-11e8-9f3e-e25618c2738e.jpg)

## Task 3: Algorithm implementation

- [Code for implementing the EM algorithm](https://github.com/eirenjacobson/MT4113-A2-TeamK/blob/master/Scripts/teamEM.R)


## Task 4: Function testing

- [Code to create simulated datasets with similar properties to the "true" data](https://github.com/eirenjacobson/MT4113-A2-TeamK/blob/master/Scripts/TestEM.R)

When testing teamEM with dataframe(500,5), a random dataframe similar to the one given but of length 500 and possible ages 1-5, we found that the p-values for mu, sigma and lambda are 0.9998, 0.9905, 1 respectively, which is very close to 1, so correct for parameters that we set for this data. A second test with dataframe(300,7) gave us p-values for mu, sigma and lambda as 0.9783, 0.9808, 1 respectively, which is very close to 1, so correct for parameters that we set for this data. This shows that the teamEM function outputs the correct parameters for the given data. The other tests also check the validity of our teamEM using our simulated dtaframes.

Note: the data sets will not always converge, but when they do they give a better estimate of the parameters set.

## Task 5: Results reporting

Below is a table of the estimates returned by `teamEM()`.


| Parameter | mu | sigma | lambda |
|-----------|----|-------|--------|
| Age 1     | 23.11276  | 3.852887     | 0.2019209      |
| Age 2     | 41.80995  | 5.629796     | 0.4526747      |
| Age 3     | 66.86052  | 8.356849     | 0.3454043      |

We have found that teamEM function converges faster when the user decides to use the known inputs.

Below is the graph of the original data with the densities of the mixture components superimposed.

![rplot](https://user-images.githubusercontent.com/32543461/47145044-bbbbc900-d2c0-11e8-83d3-23e55b704a89.jpeg)

