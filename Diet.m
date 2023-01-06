A = readmatrix('');  % insert your own excel filepath
digits(6);
OPTIMAL_RATIO = [20 50 30];
n_OPTIMAL_RATIO = OPTIMAL_RATIO / norm(OPTIMAL_RATIO);


A_1 = A(1, :); % row vectors
A_2 = A(2, :);
A_3 = A(3, :);
A_4 = A(4, :);
leng = size(A_1, 2);
x = sym('x', [leng 1]);

points = zeros(leng, 1);
% Initilization
ratio = [dot(A_2, x) dot(A_3, x) dot(A_4, x)];
n_ratio = ratio / norm(ratio);
x_pp = norm(n_ratio - n_OPTIMAL_RATIO) - dot(A_1, x)/1200; % prefer more calories



% Constraints
c1 = sum(A_1 * (1.05.^x-1).* log(exp(1).^(10^5*x)+1)) - 0.24;
c3 = 30 - dot(A_2, x);
c4 = 80 - dot(A_3, x);
c5 = 50 - dot(A_4, x);
c6 = sum(1./(10^-6 - x));   

mu = 1;
tic
while true
    b = x_pp - 10^(1-mu) * (1/c1 + 1/c3 + 1/c4 + 1/c5 + c6);
    grad = vpa(gradient(b), 6);

    % k = 0: start with feasible initial point
    x_old = vpa(transpose([0 0 0 2 2 0 0 0 0 0 0 0 0 0 0] + 10^-3));

    x_new = vpa(x_old - 0.1 * subs(grad, x, x_old));

    % k = 1
    i = 1;
    while true
        s_old = vpa(x_new - x_old);
        y_old = vpa(subs(grad, x, x_new) - subs(grad, x, x_old));
        alpha = vpa(dot(s_old, s_old) / dot(s_old, y_old));

        temp = vpa(x_new - alpha * subs(grad, x, x_new));
        x_old = x_new;
        x_new = temp;

        if ~all(x_new > 0)
            points = cat(2, points, x_old);
            break;
        end
        
        if norm(x_new - x_old) < 10^-4 || i >= 10
            points = cat(2, points, x_new);
            break;
        end

        i = i + 1;
    end

    if mu > 50
        break;
    end
    mu = mu + 1;
end

last = points(:, end);
last_modified = vpa(max(last, 0))
toc
