Expectation
Calculate the probability that length observation xi belongs to component k using Bayes Rule:
 

P (x
 
∈ k|x ) = P (xi|xi ∈ k)P (k) .
 
i	i	P (xi)

This posterior probability is computed for each observation xi based upon our initial guesses about the model parameters. P ( ) represents the probability of the event described inside the parenthesis and xi k is the event that observation xi comes from component k.
How can we calculate the probability that observation xi belongs to age class k? If we assume each component of the mixture is Gaussian, then these probabilities are derived from the normal distribution with parameters µˆk  and σˆk.  We compute these probabilities for each observation for each possible component that may have generated each xi.
To  ensure P (xi    k xi) is a probability,  i.e., 0    P (xi     k xi)     1, standardize P (xi     k xi) by  dividing by    the sum of probabilities across all three components:

3
P (xi) =	P (xi xi	k)P (k)
k=1
Hint: at this point you should have a matrix with rows for each length observation and columns for each age class, where the matrix components are the probability of membership in each age class.

Maximization
Given the probabilities of membership estimated above, compute another iteration of the estimate µˆk as
 

N
µˆ	i=1
 
P (xi ∈ k|xi)xi .
 
k	N
i=1
 
P (xi
 
∈ k|xi)
 
Note that this is a weighted mean, with the weights being the probability of an observation belonging to each age class for each observation.
The new estimate of σˆk  is based on µˆk:
 
= ‚., ΣN
 
P (xi ∈ k|xi) (xi − µˆk)2
 

Finally,
 
k	N
i=1
 
P (xi
 
∈ k|xi)
 
N
λˆ	P  x

 
 
∈ k|x ).
 

Likelihood evaluation
 
k	i	i
i=1
 
We can now calculate the likelihood of our data given these new values of λˆ, µˆ, and σˆ.  The likelihood is

K
2
k
k=1
note N () refers to the normal distribution and σ2 refers to the variance (rather than standard deviation) of
the kth component of the mixture.
This likelihood is calculated at each iteration.

Iteration and the stopping rule

The process of expectation and maximisation is repeated until the likelihood of data given the estimated parameters in the model changes negligibly. The magnitude of the change in successive likelihoods forms our criterion to determine when iteration should cease. Because likelihoods can become vanishingly small (and lead to underflow problems), it is easier to work with log-likelihoods:
 

ln(
 

) = ln( (
 
)) = Σ
 
ln ΣΣK	(
 
2)Σ
 
L

Convergence is reached when
 
P X|µ, σ, λ
 

n=1
 

k=1
 
λkN
 
xn|µk, σk
 
ln(Li+1) − ln(Li) < s
where ln(L)+∞) is the log-likelihood from the ith iteration of the EM algorithm and s is a desired tolerance.
