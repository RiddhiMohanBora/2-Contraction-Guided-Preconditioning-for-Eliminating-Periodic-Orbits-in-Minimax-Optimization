# Periodic-Orbit Elimination in Planar Minimax Optimization Using 2-Contraction

MATLAB code and numerical illustrations accompanying a study of **2-contraction-guided modifications of gradient descent–ascent (GDA)** for planar minimax problems.

## Overview

Standard GDA may exhibit periodic trajectories even when a locally asymptotically stable minimax equilibrium exists. This project studies a simple correction of the continuous-time GDA direction that:

- **Preserves the original stationary points.**
- **Provides an explicit correction-gain condition** that ensures strict 2-contraction in a prescribed region.
- **Excludes nonconstant periodic orbits** in the simply connected region under the theorem's assumptions.
- **Supports convergence analysis** when the region is compact and forward invariant and contains a unique locally asymptotically stable equilibrium.

The repository also illustrates the dynamics numerically and compares an Euler implementation with other minimax algorithms.

## Mathematical model

For a smooth payoff function \(\phi(x,y)\), the continuous-time GDA dynamics are

\[
\dot z = F(z) = \begin{bmatrix}-\phi_x(x,y)\\\phi_y(x,y)\end{bmatrix},
\qquad z=(x,y)^\top.
\]

The proposed modification is

\[
\dot z=G_\theta(z)=(I+\theta S)F(z),
\qquad
S=\begin{bmatrix}0&-1\\1&0\end{bmatrix}.
\]

Here \(\theta\) is the correction gain. Because \(\det(I+\theta S)=1+\theta^2>0\), the corrected vector field has **exactly the same stationary points** as the original GDA field.

Its Jacobian trace is

\[
\operatorname{tr}J_{G_\theta}
=-\phi_{xx}+\phi_{yy}-2\theta\phi_{xy}.
\]

If, on a region \(\Omega\),

\[
-\phi_{xx}+\phi_{yy}\leq\bar d,
\qquad \phi_{xy}\geq\underline m>0,
\]

then choosing

\[
\theta\geq\max\left\{0,\frac{\bar d+c_2}{2\underline m}\right\},
\qquad c_2>0,
\]

guarantees \(\operatorname{tr}J_{G_\theta}\leq-c_2\) on \(\Omega\). This is the planar strict 2-contraction condition. In a simply connected region, it rules out nonconstant periodic orbits contained there.

## Polynomial minimax example

The example payoff is

\[
\phi_a(x,y)=\frac a2x^2+xy-\frac{x^4}{4}+\frac{x^6}{6}
-\frac a2y^2+\frac{y^4}{4}-\frac{y^6}{6},
\qquad 0<a<\frac1{16}.
\]

The original dynamics are

\[
\begin{aligned}
\dot x&=-ax-y+x^3-x^5,\\
\dot y&=x-ay+y^3-y^5.
\end{aligned}
\]

With the correction, they become

\[
\begin{aligned}
\dot x&=-(a+\theta)x-(1-a\theta)y+x^3-x^5-\theta y^3+\theta y^5,\\
\dot y&=(1-a\theta)x-(a+\theta)y+\theta x^3-\theta x^5+y^3-y^5.
\end{aligned}
\]

The phase-portrait scripts use **\(a=1/20=0.05\)** and, for the modified system, **\(\theta=0.5\)**.

- **Original GDA:** The origin is locally asymptotically stable, yet an attracting periodic orbit coexists with it. The annulus \(\mathcal A=\{(x,y):1/4\leq x^2+y^2\leq5\}\) is forward invariant.
- **Modified GDA:** The Jacobian trace is at most \(-0.2\) throughout the plane, excluding periodic orbits. The figures illustrate trajectories moving toward the origin. The original annulus is shown only as a **visual reference**; it is **not** forward invariant for the modified system.


## Requirements and usage

- **MATLAB R2022b** (the version used for the figures).
- No optional MATLAB toolboxes are required for the two phase-portrait scripts.

Download the `.m` files into one folder, open that folder in MATLAB, and run:

## Reported discrete-time comparison

The modified dynamics are discretized with forward Euler:

\[
z_{k+1}=z_k+h(I+\theta S)F(z_k).
\]

In the reported numerical experiment:

- Step size: \(h=0.03\) for every compared method.
- Example parameter: \(a=1/20\).
- Proposed gain: \(\theta=0.5\).
- Consensus optimization regularization: \(\gamma=0.2\).
- Initial conditions: **24** points uniformly spaced on \(\lVert z_0\rVert_2=1.2\).
- Success criterion: \(\lVert F(z_k)\rVert_2\leq10^{-3}\) within at most \(10^4\) iterations.
- Median iterations: calculated over **successful runs only**.

| Method | Successful runs | Median iterations |
| --- | ---: | ---: |
| Standard GDA | 0/24 | N/A |
| Extra-gradient | 0/24 | N/A |
| Optimistic GDA | 0/24 | N/A |
| Consensus optimization | 24/24 | 1679 |
| **Proposed method** (\(\theta=0.5\)) | **24/24** | **476** |

**N/A** means that no run reached the stopping criterion within the iteration limit. Under these settings, the proposed method reached the criterion in all 24 runs with an approximately **3.5-fold lower median iteration count** than consensus optimization. This is an **iteration-count comparison**, not a wall-clock timing result.

## Scope of the guarantees

The mathematical 2-contraction and convergence results concern the **continuous-time** vector field under their stated regional assumptions. They **do not automatically prove convergence** of forward Euler for an arbitrary fixed step size. The discrete-time results above are numerical observations for the reported parameter choices and initial conditions.

## Citation

If you use the code or figures, please cite the accompanying research paper once its bibliographic details are available. A BibTeX entry can be added here after publication.

## License

No software license has yet been specified. Please add a `LICENSE` file before distributing the code under an open-source license.
