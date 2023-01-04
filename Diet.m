A = readmatrix('C:\Users\lmail\source\repos\Finance\Diet\test_menu_nutrients.xlsx');
OPTIMAL_RATIO = [20 50 30];
n_OPTIMAL_RATIO = OPTIMAL_RATIO / norm(OPTIMAL_RATIO);

A_1 = A(1, :); % row vectors
A_2 = A(2, :);
A_3 = A(3, :);
A_4 = A(3, :);
leng = size(A_1, 2);
x = sym('x', [leng 1]);

points = zeros(leng, 1);
% Initilization
ratio = [dot(A_2, x) dot(A_3, x) dot(A_4, x)];
n_ratio = ratio / norm(ratio);
x_pp = norm(n_ratio - n_OPTIMAL_RATIO);

% Constraints
c1 = sum(A_1*(1.05.^x-1)/0.05) - 1200;
c2 = 800 - sum(A_1*(1.05.^x-1)/0.05);
c3 = 30 - dot(A_2, x);
c4 = 80 - dot(A_3, x);
c5 = 50 - dot(A_4, x);

for mu = 1:10
    b = x_pp - 10^(4-mu) * (1/c1 + 1/c2 + 1/c3 + 1/c4 + 1/c5);
    grad = vpa(gradient(b), 8);

    % k = 0
    x_old = 0.5 + zeros(leng, 1);

    x_new = x_old - 0.1 * subs(grad, x, x_old);

    s_old = x_new - x_old;
    y_old = subs(grad, x, x_new) - subs(grad, x, x_old);
    alpha = dot(s_old, s_old) / dot(s_old, y_old);

    % k = 1
    i = 1;
    while true
        s_old = x_new - x_old;
        y_old = subs(grad, x, x_new) - subs(grad, x, x_old);
        alpha = vpa(dot(s_old, s_old) / dot(s_old, y_old), 8);

        temp = x_new - alpha * subs(grad, x, x_new);
        x_old = x_new;
        x_new = temp;
        
        if norm(x_new - x_old) < 10^-8 || i >= 10
            points = cat(2, points, x_new);
            break;
        end

        i = i + 1;
    end
end

last = points(:, end)
