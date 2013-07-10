# Conjugate update rules

function update(d::Beta, x::Vector)
	a, n = sum(x), length(x)
	b = n - a
	Beta(d.alpha + a, d.beta + b)
end

function update(d::Normal, x::Vector)
	error("Not yet defined")
end

# Beta/Bernoulli pair
#  * x is a vector of 0's and 1's
function update(prior::Beta, ::Type{Bernoulli}, x::Vector)
	a, n = sum(x), length(x)
	b = n - a
	Beta(prior.alpha + a, prior.beta + b)
end

# Beta/Binomial pair
#  * D is a matrix with a column of successes and a column of trials
function update(prior::Beta, ::Type{Bernoulli}, D::Matrix)
	a, n = sum(D, 1)
	b = n - a
	Beta(prior.alpha + a, prior.beta + b)
end

# Beta/NegativeBinomial pair
# TODO

# Gamma/Poisson pair
# TODO

# Dirichlet/Categorical pair
function update(prior::Dirichlet, ::Type{Categorical}, x::Vector)
	alpha = copy(prior.alpha)
	for i in 1:length(x)
		alpha[x[i]] += 1.0
	end
	return Dirichlet(alpha)
end

# Dirichlet/Multinomial pair
function update(prior::Dirichlet, ::Type{Multinomial}, x::Vector)
	return Dirichlet(prior.alpha + x)
end

# Dirichlet/Multinomial pair
function update(prior::Dirichlet, ::Type{Multinomial}, x::Matrix)
	return Dirichlet(prior.alpha + vec(sum(x, 2)))
end

# Hypergeometric/BetaBinomial pair

# Geometric/Beta pair

# Gamma/Exponential pair
function update(prior::Gamma, ::Type{Exponential}, x::Vector)
	n = length(x)
	a, b = prior.shape, 1.0 / prior.scale
	return Gamma(a + n, 1.0 / (b + sum(x)))
end

# function credibleinterval()
# end

# Known variance of data, s_data^2
function update(prior_m::Normal,
	            s_data::Real,
	            ::Type{Normal},
	            x::Vector)
	n = length(x)
	m_prior, s_prior = mean(prior_m), std(prior_m)
	c = (n * s_prior^2 + s_data^2)
	s_posterior = sqrt((s_data^2 * s_prior^2) / c)
	m_posterior = s_data^2 / c * m_prior + (n * s_prior^2) / c * mean(x)
	return Normal(m_posterior, s_posterior)
end

# Unknown mean, unknown variance
function update(prior_m::Normal,
	            prior_s::Gamma,
	            ::Type{Normal},
	            x::Vector)
	# mu: True mean of data
	# lambda: True precision of data
	#...
end
