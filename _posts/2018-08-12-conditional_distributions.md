---
layout: post
title: "From conditional probability to conditional distribution to conditional expectation, and back"
author: "Alexej Gossmann"
tags: [probability, statistics, theory, basics]
---

I can't count how many times I have looked up the formal (measure theoretic) definitions of conditional probability distribution or conditional expectation (even though it's not that hard :weary:) Another such occasion was yesterday. This time I took some notes.

## From conditional probability &rarr; to conditional distribution &rarr; to conditional expectation

Let \\( X \\) and \\( Y \\) be two real-valued random variables.

### Conditional probability

For a fixed set \\( B \\) {% cite FellerVol2 --locator 157 %} defines conditional probability of an event \\( \\{Y \in B\\} \\) for given \\( X \\) as follows.

> By \\( \prob(Y \in B \| X) \\) (in words, &ldquo;a conditional probability of the event \\( \\{Y \in B\\} \\) for given \\(X\\)&rdquo;) is meant a function \\(q(X, B)\\) such that for every set \\(A \in \mathbb{R}\\)
> \\[\prob(X \in A, Y \in B) = \int\_A q(x, B) \mu(dx)\\]
> where \\(\mu\\) is the marginal distribution of \\(X\\).

(where \\( A \\) and \\( B \\) are both [Borel sets](https://en.wikipedia.org/wiki/Borel_set) on \\( \R \\).)

### Conditional distribution

Later on {% cite FellerVol2 --locator 159 %} follows up with the notion of conditional probability distribution:

> By a conditional probability distribution of \\(Y\\) for given \\(X\\) is meant a function \\(q\\) of two variables, a point \\(x\\) and a set \\(B\\), such that
> 1. for a fixed set \\(B\\)
> \\[q(X, B) = \prob(Y \in B \| X )\\]
> is a conditional probability of the event \\( \\{Y \in B\\} \\) for given \\(X\\).
> 2. \\(q\\) is for each \\(x\\) a probability distribution.

and points out that

{% quote FellerVol2 %}
In effect a conditional probability distribution is a family of ordinary probability distributions and so the whole theory carries over without change.
{% endquote %}

I found it incredibly enlightening to regard the conditional probability distribution as a *family of ordinary probability distribution*, when I first came across this viewpoint. :smile:

### Conditional expectation

Finally, {% cite FellerVol2 --locator 159 %} introduces the notion of conditional expectation.
By the above, for given a value \\( x \\) we have that
\\[ q(x, B) = \prob(Y \in B \| X = x), \quad\forall B\in\mathcal{B}\\]
(here \\( \mathcal{B} \\) denotes the [Borel \\( \sigma \\)-algebra](https://en.wikipedia.org/wiki/Borel_set) on \\( \R \\)), and therefore, a conditional probability distribution can be viewed as a family of ordinary probability distributions (represented by \\( q \\) for different \\( x \\)s).
Thus, as {% cite FellerVol2 --locator 159 %} points out, if \\(q\\) is given then the conditional expectation *&ldquo;introduces a new notation rather than a new concept.&rdquo;*

> A conditional expectation \\( E(Y \| X) \\) is a function of \\( X \\) assuming at \\( x \\) the value
> \\[ \E(Y \| X = x) = \int\_{-\infty}^{\infty} y q(x, dy) \\]
> provided the integral converges.

Note that, because \\( \E(Y \| X) \\) is a function of \\( X \\), it is a random variable, whose value at an individual point \\( x \\) is given by the above definition.
Moreover, from the above definitions of conditional probability and conditional expectation it follows that
\\[ \E(Y) = \E(\E(Y \| X)).\\]

## From conditional expectation &rarr; to conditional probability

An alternative approach is to define the conditional expectation first, and then to define conditional probability as the conditional expectation of [the indicator function](https://en.wikipedia.org/wiki/Indicator_function).
This approach seems less intuitive to me. However, it is more flexible and more general, as we see below.

### Conditional expectation

#### A definition in 2D

Let \\(X\\) and \\(Y\\) be two real-valued random variables, and let \\( \mathcal{B} \\) denote the [Borel \\( \sigma \\)-algebra](https://en.wikipedia.org/wiki/Borel_set) on \\( \R \\).
Recall that \\( X \\) and \\( Y \\) can be represented as mappings \\(X: \Omega \to \R\\) and \\(Y: \Omega \to \R\\) over some [measure space](https://en.wikipedia.org/wiki/Measure_space) \\((\Omega, \mathcal{A}, \prob)\\).
We can define \\(\mathrm{E}(Y \| X=x)\\), the conditional expectation of \\(Y\\) given \\(X=x\\), as follows.

A \\(\mathcal{B}\\)-measurable function \\(g(x)\\) is the conditional expectation of \\(Y\\) for given \\(x\\), i.e.,
\\[\mathrm{E}(Y \| X=x) = g(x),\\]
if for all sets \\(B\in\mathcal{B}\\) it holds that
\\[\int\_{X^{-1}(B)} Y(\omega) d\prob(\omega) = \int\_{B} g(x) d\prob^X(x),\\]
where \\( \prob^X \\) is the marginal probability distribution of \\( X \\).

#### Interpretation in 2D

If \\(X\\) and \\(Y\\) are real-valued one-dimensional, then the pair \\((X,Y)\\) can be viewed as a random vector in the plane.
Each set \\(\\{X \in A\\}\\) consists of parallels to the \\(y\\)-axis, and we can define a \\(\sigma\\)-algebra induced by \\(X\\) as the collection of all sets \\(\\{X \in A\\}\\) on the plane, where \\(A\\) is a Borel set on the line.
The collection of all such sets forms a \\( \sigma \\)-algebra \\( \mathcal{A} \\) on the plane, which is contained in the \\( \sigma \\)-algebra of all Borel sets in \\( \R^2 \\).
\\( \mathcal{A} \\) is called the \\( \sigma \\)-algebra generated by the random variable \\( X \\).

Then \\(\mathrm{E}(Y \| X)\\) can be equivalently defined as a random variable such that
\\[ \mathrm{E}(Y\cdot I_{A}) = \mathrm{E}(\mathrm{E}(Y \| X) \cdot I_{A}), \quad \forall A\in\mathcal{A},\\]
where \\( I\_{A} \\) denotes the indicator function of the set \\( A \\).

#### A more general definition of conditional expectation

The last paragraph illustrates that one could generalize the definition of the conditional expectation of \\( Y \\) given \\( X \\) to the conditional expectation of \\( Y \\) given an arbitrary \\( \sigma \\)-algebra \\( \mathcal{B} \\) (not necessarily the \\( \sigma \\)-algebra generated by \\( X \\)).
This leads to the following general definition, which is stated in {% cite FellerVol2 --locator 160-161 %} in a slightly different notation.

Let \\(Y\\) be a random variable, and let \\(\mathcal{B}\\) be a \\(\sigma\\)-algebra of sets.

1. A random variable \\(U\\) is called a conditional expectation of \\(X\\) relative to \\(\mathcal{B}\\), or \\(U = \E(X \| \mathcal{B})\\), if it is \\(\mathcal{B}\\)-measurable and

    \\[\E(Y\cdot I_{B}) = \E(U \cdot I_{B}), \quad \forall B\in\mathcal{B}.\\]

2. If \\(\mathcal{B}\\) is the \\(\sigma\\)-algebra generated by a random variable \\(X\\), then \\(\E(Y \| X) = \E(Y \| \mathcal{B})\\).

### Back to conditional probability and conditional distributions

Let \\(I\_{\\{Y \in A\\}}\\) be a random variable that is equal to one if and only if \\(Y\in A\\). The conditional probability of \\( \\{Y \in A\\} \\) given \\(X = x\\) can be defined in terms of a conditional expectation as

\\[\prob(\\{Y \in A\\} \| X = x) = \E(I\_{\\{Y \in A\\}} \| X = x).\\]

Under certain regularity conditions the above defines the conditional probability distribution \\(\prob(Y \| X)\\).

## References

{% bibliography --cited_in_order %}
