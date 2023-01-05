# Diet-Optimisation

Writing this right now. Gonna paste my Word doc in here. 
Learn how to type math equations

# Background: 

Why did I start this project?

# Goal: 
$minimize_{x∈R^n} f(x)$, where $f(x)∈C^∞$, i.e., $f(x)$ is a smooth function

# Description of problem

# Methodology

Whereas unconstrained optimisation algorithms usually start from some initial point, the situation differs in the constrained case. Most methods require an initial solution that is feasible, i.e., one that satisfies all given constraints. Such an initial point may be hard to find; furthermore, there may exist no feasible points. Thus, a number of methods require a preliminary search method that finds an initial feasible solution point, from which we can then optimise the solution.

Following linear programming (LP) terminology, we shall call such the initial search a _Phase 1_ procedure and the process of finding an optimal point from the initial solution a _Phase 2_ procedure.

A major category of algorithms is formed by the _barrier and penalty function methods_. Here I shall briefly discuss the principle underlying the barrier function methods. Consider the convex programming problem 
```math
minimize_{x∈R^n} f(x)
```
```math
g_i(x)\le0, i = 1,..., m
```
The idea is to convert this problem into a corresponding unconstrained problem with an optimal solution near that of the original problem.

One method of doing so is the interior point (IP) method, pioneered by Anthony V. Fiacco and Garth P. McCormick in the early 1960s. The basis of IP method restricts the constraints into the objective function by creating a barrier function. This limits potential solutions to iterate in only the feasible region, resulting in a much more efficient algorithm with regards to time complexity.

To ensure the program remains within the feasible region, a perturbation factor, $r$, is added to "penalize" close approaches to the boundaries. This approach is analogous to the use of an invisible fence to keep dogs in an unfenced yard. As the dog moves closer to the boundaries, the more shock he will feel. In the case of the IP method, the amount of shock is determined by $r$. A large value of $r$ gives the analytic center of the feasible region. As $r$ decreases and approaches 0, the optimal value is calculated by tracing out a central path.

In this project, the barrier function used is defined by 
```math
B(x, r)=f(x)-r\sum_{i=1}^m \frac{1}{g_i(x)}. 
```
The terms $\frac{-r}{g_i(x)}$ are called the _boundary repulsion_ terms and force $x$ to stay within the feasible region so that we can use unconstrained optimisation techniques.

## Steps for finding an optimal point
1. We start with an initial interior feasible point $x^0$ and set $k:=1$.
2. We use any unconstrained optimisation technique to find the minimum of the barrier function 
```math
B(x, r_k) = f(x) - r_k\sum_{i=1}^m \frac{1}{g_i(x)}$
```
3. Vary $r_k$, e.g., $r_k = 10^{1-k}$ and repeat the process until the current solution satisfies some stop criterion\\
Note that the choice of ${{r_k}}^\infty_{k=1} = {{10^-k}}^\infty_{k=1}$ has been empirically proved to yield satisfactory results; a slower converging $r_k$ sequence may delay the convergence of the algorithm, while a faster sequence may cause numerical istability. (See Fiacco and McCormick (1968))

However, with regards to Step 2, which optimisation technique should we choose?
Our goal is as follows: $minimize_{x∈R^n} f(x)$, where $f(x)∈C^∞$, i.e., $f(x)$ is a smooth function
Let $g^({(k)})=∇f(x^{(k)}),F^{(k)}=∇^2 f(x^{(k)})$
- Gradient method: $x^{(k+1)}=x^{(k)}-α_k g^{(k)}$
    - Choice of α_k: fixed, exact line search, or backtracking line search
    - Pros: simple
    - Cons: no use of 2nd order information, relatively slow progress
- Newton-Ralphson method: $x^{(k+1)}=x^{(k)}-{(F^{(k)})}^{-1} g^{(k)}$
    - Pros: 2nd order information, 1-step for quadratic function, fast convergence near solution
    - Cons: forming and computing ${(F^{(k)})}^{-1}$ is expensive, need modifications if $F^{(k)}$ is not positive definite, e.g., (the 2 methods)
- Borzilai-Borwein (BB) method: choose $α_k$ such that $-α_k g^{(k)}≈d_{Newton}^{(k)}$
    - Background: it is a gradient method with special step sizes. The method is motivated by Newton's method but does not compute Hessian
    - Pros: at nearly no extra cost over the standard gradient method, the BB method often significantly outperforms the stardard gradient method
    - Cons: no convergence guarantee for smooth convex problems

# Summary of BB method 
Define:
```math
s^{(k-1)}:=x^{(k)}-x^{(k-1)}
```
```math
y^{(k-1)}:=g^{(k)}-g^{(k-1)}
```
```math
\alpha_k^1:=\frac{   {(s^{(k-1)})}^T s^{(k-1)}} {{(s^{(k-1)})}^T y^{(k-1)}    }
```

At $k=0$, $x^{(k-1)}, g^{(k-1)}$ (and thus $s^{(k-1)}, y^{(k-1)}$) are undefined, so we apply 1 iteration of the standard gradient descent.  
Then, we switch to the BB method at $k=1$

# Test #1
I set \mu


# Extensions
	Implement webscraper
	Create safeguard
	Line search that permits temporary growth but enforces overall descent of the function value, i.e., it can jump out of a local minimum
	For nonconvex problems, they improve the likelihood of global optimality
	Current optimization problem is convex, but if repetition penalty function is nonconvex, then this will be necessary
	Improves convergence speed when a monotone scheme is forced to creep along the bottom of a narrow curved valley (see slides drawing)
	Zhang-Hager nonmonotone line search (copy)
