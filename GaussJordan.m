%% Gauss-Jordan Elimination Algorithm:
%% Mahmoud Halwani u23100372
%% ABDELRAHMAN AMJED M MANSOUR u23101444
%% HASHEM MOHAMMAD FATEHI ALSHAR u23101334
%% Anas Feras Abed Alrajabi u21104982
%% GOLAM MOHAMMAD MOKBUL HOSSAIN DASTAGIR u23102430

clc;
clear;


A = [5  -1   0  -4   2;
    -1  13 -10  -2   4;
     0 -10  15  -5   3;
    -4  -2  -5  14   0];

%% Number of equations
n = 4;

for i = 1:n
    %% Find the Cmax in the current column 
    [~, p] = max(abs(A(i:n, i)));  % Find index of max 
    p = p + i - 1;               
    
    %% Swap rows 
    if p ~= i
        temp = A(i,:);
        A(i,:) = A(p,:);
        A(p,:) = temp;
    end

    %%  divide all elements in row
    A(i,:) = A(i,:) / A(i,i);

    %% subtract the values to turn the matix into an identity matrix 
    for j = 1:n
        if j ~= i
            A(j,:) = A(j,:) - A(j,i) * A(i,:);
        end
    end
end

%% Solution which is the last column
x = A(:,5);

%% Display modified matrix
disp('Matrix A after Gauss-Jordan Elimination Method :');
disp(A);

%% Display results
disp('Current Results using Gauss-Jordan Elimination Method (in mA):');
for i = 1:n
    fprintf('i%d = %.6f mA\n', i, x(i));
end
