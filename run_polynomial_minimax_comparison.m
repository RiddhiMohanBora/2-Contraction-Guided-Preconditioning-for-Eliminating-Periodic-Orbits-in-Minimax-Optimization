function results = run_polynomial_minimax_comparison()
%RUN_POLYNOMIAL_MINIMAX_COMPARISON Reproduce the 5-method comparison.
%   MATLAB R2022b; no optional toolboxes; no random initialization.
%   Place this file and all method_*.m/poly_gda_field.m in one folder.

a = 1/20;
h = 0.03;
theta = 0.5;
gamma = 0.2;
maxIter = 10000;
tol = 1e-3;
N = 24;
radius = 1.2;

angles = 2*pi*(0:N-1)/N;
initials = radius*[cos(angles);sin(angles)];
methodNames = {'GDA';'Extra-gradient';'Optimistic GDA'; ...
               'Consensus optimization';'Proposed modified GDA'};
iters = NaN(5,N);

for m = 1:5
    for i = 1:N
        z0 = initials(:,i);
        switch m
            case 1
                [~,n,ok] = method_gda(z0,a,h,maxIter,tol);
            case 2
                [~,n,ok] = method_extragradient(z0,a,h,maxIter,tol);
            case 3
                [~,n,ok] = method_ogda(z0,a,h,maxIter,tol);
            case 4
                [~,n,ok] = method_consensus(z0,a,h,gamma,maxIter,tol);
            case 5
                [~,n,ok] = method_modified_gda(z0,a,h,theta,maxIter,tol);
        end
        if ok
            iters(m,i) = n;
        end
    end
end

successCount = sum(~isnan(iters),2);
medianIterations = NaN(5,1);
for m = 1:5
    successful = iters(m,~isnan(iters(m,:)));
    if ~isempty(successful)
        medianIterations(m) = median(successful);
    end
end

results = table(methodNames,successCount,medianIterations, ...
    'VariableNames',{'Method','SuccessfulRuns','MedianIterations'});

fprintf('a=%.2f, h=%.2f, theta=%.2f, gamma=%.2f, N=%d\n', ...
    a,h,theta,gamma,N);
fprintf('Criterion: ||F(z_k)||_2 <= %.0e; maximum %d updates\n\n', ...
    tol,maxIter);
fprintf('%-25s %-12s %s\n','Method','Successes','Median iterations');
for m = 1:5
    if isnan(medianIterations(m))
        medText = 'N/A';
    else
        medText = sprintf('%d',round(medianIterations(m)));
    end
    fprintf('%-25s %2d/%-9d %s\n', ...
        methodNames{m},successCount(m),N,medText);
end
end
