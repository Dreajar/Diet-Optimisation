# Diet-Optimisation

Writing this right now. Gonna paste my Word doc in here. 
Learn how to type math equations

Background: 
	Why did I start this project?
	Why python and Matlab
	Python for webscraping
	Matlab because Python can’t find gradients
  
Goal: $minimize_{x∈R^n} f(x)$, where $f(x)∈C^∞$, i.e., $f(x)$ is a smooth function
Methodology
	Simplify nonlinear constrained optimization problem using barrier methods (copy book)
Let g^((k))=∇f(x^((k) ) ),F^((k) )=∇^2 f(x^((k) ))
	Gradient method: x^((k+1) )=x^((k) )-α_k g^((k) )
	Choice of α_k: fixed, exact line search, or backtracking line search
	Pros: simple
	Cons: no use of 2nd order information, relatively slow progress
	Newton-Ralphson method: x^((k+1) )=x^((k) )-(F^((k) ) )^(-1) g^((k) )
	Pros: 2nd order information, 1-step for quadratic function, fast convergence near solution
	Cons: forming and computing (F^((k) ) )^(-1) is expensive, need modifications if (F^((k) )) is not positive definite, e.g., (the 2 methods)
	Borzilai-Borwein (BB) method: choose α_k such that -α_k g^((k) )≈d_newon^((k) )
Summary of BB method 
	Copy into github
Results


Extensions
	Implement webscraper
	Create safeguard
	Line search that permits temporary growth but enforces overall descent of the function value, i.e., it can jump out of a local minimum
	For nonconvex problems, they improve the likelihood of global optimality
	Current optimization problem is convex, but if repetition penalty function is nonconvex, then this will be necessary
	Improves convergence speed when a monotone scheme is forced to creep along the bottom of a narrow curved valley (see slides drawing)
	Zhang-Hager nonmonotone line search (copy)
