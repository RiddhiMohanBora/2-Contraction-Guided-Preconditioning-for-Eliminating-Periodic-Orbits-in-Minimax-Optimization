function [z,iterations,success] = method_modified_gda(z0,a,h,theta,maxIter,tol)
%METHOD_MODIFIED_GDA Fixed skew-symmetric correction of the GDA field.
%   Correction: (I+theta*S)*F, S = [0 -1; 1 0].

z = z0(:);
iterations = NaN;
success = false;
S = [0 -1; 1 0];
A = eye(2) + theta*S;

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
    z = z + h*(A*F);
    if any(~isfinite(z))
        return;
    end
end
end
