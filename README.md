ConjugatePriors.jl
==================

# NOTICE

**This package is deprecated and replaced by Distributions.jl.**

# Introduction

Closed-form solutions for Bayesian updating under conjugate priors

# Usage Examples

	using ConjugatePriors

	data = rand(Bernoulli(), 100)

	prior = Beta(1, 1)
	posterior = update(prior, data)

	prior = Beta(1000, 100)
	posterior = update(prior, data)
