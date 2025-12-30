
clc;
clear;

% Define the function
f = @(x) (1/3)*x.^3 + (1/5)*x.^2 - (1/6)*x - (19/3);

% Initial guesses
x0 = 0;
x1 = 4;

% Calculate first values
y1 = f(x0);
y2 = f(x1);
c = y1 * y2;

if c < 0
    fprintf('Iter\t\tx0\t\tx1\t\tx2\t\tf(x2)\t\tTolerance\n');
    fprintf('--------------------------------------------------------------------------\n');
    
    iteration = 1;
    
    while true
        % Step 1: find midpoint
        x2 = (x0 + x1) / 2;
        
        % Step 2: check the sign and update bounds
        if f(x0) * f(x2) < 0
            x1 = x2;
        else
            x0 = x2;
        end
        
        % Step 3: calculate tolerance
        tol = abs(f(x2));
        
        % Print iteration info as one table
        fprintf('%d\t\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\n', iteration, x0, x1, x2, f(x2), tol);
        
        % Step 4: check the stopping condition
        if tol <= 0.1
            fprintf('\nRoot found at x = %.6f with tolerance = %.6f\n', x2, tol);
            break;
        end
        
        iteration = iteration + 1;
    end
else
    fprintf('No sign change between f(x0) and f(x1), no root in this range.\n');
end

