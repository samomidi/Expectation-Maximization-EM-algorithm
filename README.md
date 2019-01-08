# Assignment 2
# Team A

## Team Members
+ Wan-Chen Chiu, 150008359
+ Emma Farrugia, 160007020
+ Konstantinos Theodosopoulos, 170026763
+ Sam Omidi, 180024815

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

## Task 6: Work attribution

I confirm that this repository is the work of our team, except where clearly indicated in the text.

- Sam drew the plots as R code is attached, wrote part of the function testing, wrote the documentation for Task 1 and helped with code diagnosis and debugging.
- Emma wrote the initialisation and expectation functions, co-wrote the calclikelihood and teamEM functions with Wan-Chen, made the final flowchart, wrote the dataframe function and co-wrote the enhancement of including an option to use known ages (includeknown) with Wan-Chen.
- Konstantinos wrote the inputs checks, TestTeamEM function, worked on the calculation of the likelihood function and made some improvements in the teamEM function.
- Wan-Chen wrote the maximisation function, wrote the pairedttest, normality.test and component.test functions, wrote comments for the teamEM file and the TestEM file and wrote the documentation for Task 2.
