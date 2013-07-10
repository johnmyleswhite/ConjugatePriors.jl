using ConjugatePriors

data = rand(Bernoulli(), 100)

prior = Beta(1, 1)
posterior = update(prior, data)

prior = Beta(1000, 100)
posterior = update(prior, data)
