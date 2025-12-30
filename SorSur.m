%% Successive over-relaxation and Successive under-relaxation method
%% Mahmoud Halwani u23100372
%% ABDELRAHMAN AMJED M MANSOUR u23101444
%% HASHEM MOHAMMAD FATEHI ALSHAR u23101334
%% Anas Feras Abed Alrajabi u21104982
%% GOLAM MOHAMMAD MOKBUL HOSSAIN DASTAGIR u23102430

clc;
clear;


A = [5  -1   0  -4;
    -1  13 -10  -2;
     0 -10  15  -5;
    -4  -2  -5  14];
b = [2; 4; 3; 0];

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
        disp('Successive over-relaxation or Successive under-relaxation method will continue but may not converge.');
        break;  %% continue 
    end
end

%% Display modified matrix
disp('Matrix A after diagonal dominance:');
disp(A);
disp('Vector b after row switching:');
disp(b);


%% The Initial conditions
x = [0.5; -0.1; 0; 0.1];

%% number of iterations and relaxation factor
n_iterations = input('Enter number of iterations: ');
a = input('Enter relaxation factor alpha (between 0 and 2): ');

%% find if SOR or SUR 
if (a > 0 && a < 1)
    disp('Method: Successive Under-Relaxation');  
elseif (a > 1 && a < 2)
    disp('Method: Successive Over-Relaxation');    
else
    disp('Invalid alpha Program stopped.');
    return;  % Exits the current script gracefully
end

%% the process of SOR OR SUR
for k = 1:n_iterations
    x_old = x;  % Store previous values
    
    for i = 1:n
        sum = 0;
        for j = 1:n
            if j ~= i
                sum = sum + A(i,j) * x(j);
            end
        end
        
        %% new update
        x_new = (b(i) - sum) / A(i,i);
        
        %% Relaxation update
        x(i) = (1 - a) * x_old(i) + a * x_new;
    end 
end

%% Display results
disp('Current Results (in mA):');
for i = 1:n
    fprintf('i%d = %.6f mA\n', i, x(i));
end

%% Significant digits (d)
x_exact = A\b;  
d = zeros(n,1);

for i = 1:n
RE = abs((x(i) - x_exact(i))/x_exact(i));
d(i) = floor(1 - log10(2 * RE));  %% d<1-log10(2RE)

end
%% Display results
disp('Significant digits for each variable:');
for i = 1:n
        fprintf('i%d: d = %d\n', i, d(i));
end