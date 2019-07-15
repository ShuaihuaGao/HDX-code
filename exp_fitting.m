function [coffs, ks, D] = exp_fitting(x, y, ntotal, reg_k2, reg_k3, weight)
[xdata, ydata] = prepareCurveData(x, y);
fun = @(x) sum((ntotal - x(1)*exp(-x(4)*xdata) - x(2)*exp(-x(5)*xdata) - x(3)*exp(-x(6)*xdata) - x(7) - ydata).^2 .* weight + reg_k2 * (x(5)).^2 + reg_k3 * (x(6)).^2);
quater_ntotal = ntotal / 4;
lower = [0 0 0 0 0 0 0];
start_point = [quater_ntotal, quater_ntotal, quater_ntotal, 20, 0.1, 0.01, quater_ntotal];
upper = [ntotal, ntotal, ntotal, 100, 10, 1, ntotal];
Aeq = zeros(1, 7);
Aeq([1, 2, 3, 7]) = 1;

solutions = fmincon(fun, start_point, [], [], Aeq, ntotal, lower, upper);
[coffs, ks, D] = postprocess_result(solutions);
end

function [coffs, ks, D] = postprocess_result(solutions)
ks = solutions(4:6);
coffs = solutions(1:3);
D = solutions(7);

[~, idx] = sort(ks, 'descend');
ks = ks(idx);
coffs = coffs(idx);
end
