function [z,iterations,success] = method_consensus(z0,a,h,gamma,maxIter,tol)
%METHOD_CONSENSUS Consensus optimization with L = 0.5*norm(F)^2.
%   Correction: J_F(z).' * F(z), with consensus gain gamma > 0.

z = z0(:);
iterations = NaN;
success = false;

for k = 0:maxIter
    F = poly_gda_field(z,a);
    if norm(F,2) <= tol
        iterations = k;
        success = true;
        return;
    end
    if k == maxIter
        return;
    end
    x = z(1);
    y = z(2);
    JF = [ -a+3*x^2-5*x^4, -1; ...
            1, -a+3*y^2-5*y^4 ];
    z = z + h*(F - gamma*(JF.'*F));
    if any(~isfinite(z))
        return;
    end
end
end
