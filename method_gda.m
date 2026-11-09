function [z,iterations,success] = method_gda(z0,a,h,maxIter,tol)
%METHOD_GDA Simultaneous gradient descent-ascent (Euler update).

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
    z = z + h*F;
    if any(~isfinite(z))
        return;
    end
end
end
