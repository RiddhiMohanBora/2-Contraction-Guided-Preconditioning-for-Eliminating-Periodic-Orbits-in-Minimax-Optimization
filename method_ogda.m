function [z,iterations,success] = method_ogda(z0,a,h,maxIter,tol)
%METHOD_OGDA Optimistic GDA using the previous GDA direction.
%   The initialization F_{-1} = F_0 makes the first step standard GDA.

z = z0(:);
iterations = NaN;
success = false;
Fprevious = poly_gda_field(z,a);

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
    zNext = z + h*(2*F - Fprevious);
    Fprevious = F;
    z = zNext;
    if any(~isfinite(z))
        return;
    end
end
end
