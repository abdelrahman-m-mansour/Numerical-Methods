
clc;
clear;

A = [5  -1   0  -4;
    -1  13 -10  -2;
     0 -10  15  -5;
    -4  -2  -5  14];
b = [2; 4; 3; 0];

%% Initial guess
x = [0.5; -0.1; 0; 0.1];

n = length(b);

%% Check and Swapping the Matrix
for i = 1:n
    diag_correct = false;
    for k = i:n
        if abs(A(k,i)) > sum(abs(A(k,[1:i-1, i+1:n])))

            %% Swap rows i and k if needed
            if k ~= i
                tempA = A(i,:);
                A(i,:) = A(k,:);
                A(k,:) = tempA;

                tempb = b(i);
                b(i) = b(k);
                b(k) = tempb;

            end
            diag_correct = true;
            break;
        end
    end
    if ~diag_correct
        fprintf('Matrix is not diagonally dominant.\n');
        disp('Jacobi method will continue but may not converge.');
        break;  %%continue
    end
end

%% Display modified matrix
disp('Matrix A after diagonal dominance:');
disp(A);
disp('Vector b after row switching:');
disp(b);

%% Ask for number of iterations
n_iter = input('Enter number of iterations: ');

%% Jacobi Iteration
x_new = zeros(n,1);

for k = 1:n_iter
    for i = 1:n
        sum_val = 0;
        for j = 1:n
            if j ~= i
                sum_val = sum_val + A(i,j)*x(j);
            end
        end
        x_new(i) = (b(i) - sum_val)/A(i,i);
    end
    x = x_new;
end

%% Display results
disp('Current Results using Jacobi Method (in mA):');
for i = 1:n
    fprintf('i%d = %.6f mA\n', i, x(i));
end

%% Significant digits (d)
x_exact = A\b;  
d = zeros(n,1);

for i = 1:n
    RE = abs((x(i) - x_exact(i))/x_exact(i));
    d(i) = floor(1 - log10(2 * RE));  %% d < 1 - log10(2RE)
end

disp('Significant digits for each variable:');
for i = 1:n
    fprintf('i%d: d = %d\n', i, d(i));
end

