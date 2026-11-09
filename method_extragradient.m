function [z,iterations,success] = method_extragradient(z0,a,h,maxIter,tol)
%METHOD_EXTRAGRADIENT One prediction and one correction per step.

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
    zHalf = z + h*F;
    FHalf = poly_gda_field(zHalf,a);
    z = z + h*FHalf;  % Update from z, not zHalf.
    if any(~isfinite(z))
        return;
    end
end
end
