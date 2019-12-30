---
layout: post
title: "Concordance Correlation Coefficient"
author: "Alexej Gossmann"
tags: [statistics, probability, math, theory, basics]
---

If we collect $$ n $$ pairs of [i.i.d.](https://en.wikipedia.org/wiki/Independent_and_identically_distributed_random_variables) observations $$ (Y_{i1}, Y_{i2}) $$ from some bivariate distribution, then what is the expected squared perpendicular distance of each such point in a 2D plane from the 45-degree line?

TODO: Graph

Assume that $$ (Y_1, Y_2) $$ follows a bivariate distribution with mean vector $$ (\mu_1, \mu_2) $$, and covariance matrix with entries $$ \mathrm{Var}(Y_1) = \sigma_1^2 $$, $$ \mathrm{Var}(Y_2) = \sigma_2^2 $$ and $$\mathrm{Cov}(Y_1, Y_2) = \sigma_{12} $$.
The squared perpendicular distance of the point $$ (Y_1, Y_2) $$ from the 45-degree line is $$ (Y_1 - Y_2)^2 $$, and its expected value is given by,

$$
\begin{align}
\E\left[ (Y_1 - Y_2)^2 \right] &= \E\left[ \left( (Y_1-\mu_1) - (Y_2-\mu_2) + \mu_1-\mu_2 \right)^2 \right] \\
&= \E\left[ \left((Y_1-\mu_1) - (Y_2-\mu_2) \right)^2 \right] + (\mu_1-\mu_2)^2 \\
&= (\mu_1-\mu_2)^2 + \sigma_1^2 + \sigma_2^2 - 2\sigma_{12} \label{eq:decomp1} \\
&= (\mu_1-\mu_2)^2 + (\sigma_1 - \sigma_2)^2 + 2[1 - \rho] \sigma_1 \sigma_2.
\end{align}
$$

To answer the question raised at the beginning of this post, we can estimate the quantity of equation $$\eqref{eq:decomp1}$$ based on $$ n $$ pairs of observations $$ (Y_{11}, Y_{12}), (Y_{21}, Y_{22}), \dots, (Y_{n1}, Y_{n2}) $$ using the respective mean, variance, and covariance estimates.

Since the formula of equation $$\eqref{eq:decomp1}$$ basically measures the (dis)agreement between two sets of observations, it is natural to try to scale (or normalize) this quantity to the range $$ [0, 1] $$.
However, it turns out that it is customary to scale this quantity to the range from -1 to 1 as follows,

$$
\begin{equation}
\mathrm{CCC} := 1 - \frac{\E\left[ (Y_1 - Y_2)^2 \right]}{(\mu_1-\mu_2)^2 + \sigma_1^2 + \sigma_2^2}
\label{eq:ccc}
\end{equation}
$$

This expression, first introduced by Lin (19..), is known as the Concordance Correlation Coefficient, or CCC.

The scaling into the range from -1 to 1 may have been motivated by the fact that the [Pearson correlation coefficient](https://en.wikipedia.org/wiki/Pearson_correlation_coefficient) $$ \rho $$ also falls within the $$ [-1, 1] $$ range.
Analogously to how the Pearson correlation coefficient $\rho=1$ signifies perfect positive correlation, a CCC of 1 designates that the paired observations fall exactly on the line of perfect concordance (the 45-degree diagonal line).

In fact, by rewriting the CCC as

$$
\begin{equation}
\mathrm{CCC} = \frac{2\sigma_{12}}{(\mu_1-\mu_2)^2 + \sigma_1^2 + \sigma_2^2},
\end{equation}
$$

its relationship to Pearson correlation coefficient $$ rho $$ becomes evident:

* it has the same sign.
* it is 0 if and only if $$ \rho = 0 $$.

Additional insights can be derived by further rewriting the CCC as

$$
\begin{equation}
\mathrm{CCC} = \frac{2\sigma_{12}}{(\mu_1-\mu_2)^2 + \sigma_1^2 + \sigma_2^2} = \rho C,
\end{equation}
$$

where

$$
C = \frac{2}{v + \frac{1}{v} + u^2}, v = \frac{\sigma_1}{\sigma_2}, u = \frac{(\mu_1 - \mu_2)^2}{\sigma_1 \sigma_2}.
$$

If we consider $\rho$$ to be a measure of precision, i.e., how far each point deviates from the best fitting line, then the CCC combines it with a measure of accuracy denoted by $$ C $$, which quantifies how far the best-fit line deviates from the 45-degree line.
When the data lie exactly on the 45-degree line, then we have that C = 1. The further the observations deviate from the 45-degree line, the further C is from 1 and the closer it is to 0.
In particular, $$ v $$ can be considered a measure of scale shift, and $$ u $$ a measure of location shift relative to the scale.

## How is this useful?

You may want to compare two instruments that aim to measure the same target entity, or two [assays](https://en.wikipedia.org/wiki/Assay) that aim to measure the same analyte, or other quantitative measurement procedures or devices.
For example, one set of measurements may be obtained by what's considered the "gold standard", while the other set of measurements may be collected by a new instrument/assay/device that may be cheaper or in some other way preferable to the "gold standard" instrument/assay/device. Then one would wish to demonstrate that the collected two sets of measurements are equivalent.
Lin (19..) refers to this type of agreement or similarity between two sets of measurements as *reproducibility* of measurements.
They consider the following two illustrative examples in their paper:

> (1) Can a "Portable $ave" machine (actual name withheld) reproduce a gold-standard machine in measuring total bilirubin in blood?
> (2) Can an in-vitro assay for screening the toxicity of biomaterials reproduce from trial to trial?

And indeed this type of reproducibility assessment is a task where CCC has some clear advantages over the Pearson correlation coefficient as well as over some other approaches.

### Quick comparison to the Pearson correlation coefficient

One major shortcoming of the Pearson correlation coefficient when assessing reproducibility of measurements is that is is invariant to additive or multiplicative shifts by a constant value, referred to as location shift and scale shift respectively in the following.

Let's look at some illustrative examples.

Figures & discussion...

### Comparisons with other evaluation procedures

Lin (19..) also discusses the merits of CCC in comparison to several other common evaluation procedures while pointing out their shortcomings, for example:

* the _paired t-test_ can reject a highly reproducible set of measurements when the variance is very small, while it fails to detect poor agreement in pairs of data when the means are equal,
* the _least squares approach_ of testing intercept equal to 0 and slope equal to 1 fails to detect nearly perfect agreement when the residual errors are very small, while it has increasingly little chance to reject the null hypothesis of agreement the more the data are scattered.

I will end here. However, if you want to go deeper into the topic I invite you to check out the original paper by Lin, as well as ...

At this point I will conclude this blog post, and refer to Lin (19..) for a more thorough discussion of the merits of the CCC, as well as for its statistical properties.
