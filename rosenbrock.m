function [f, df, Hf] = rosenbrock(x)
% ROSENBROCK Famous banana-contoured quartic function with unique global minimum at (1, 1).

    % clear num_calls to set to zeros
    persistent num_calls;
    if isempty(num_calls)
        num_calls = zeros(3, 1);
    end

    if (nargin == 0)
        f = num_calls(1);
        df = num_calls(2);
        Hf = num_calls(3);
        return;
    end

    if (length(x) ~= 2)
        error('x must be length 2 vector')
    end

    f = 100 * (x(2) - x(1)^2)^2 + (1 - x(1))^2;

    num_calls(1) = num_calls(1) + 1;

    if nargout > 1
        df = [- 400 * x(1) * (x(2) - x(1)^2) - 2 * (1 - x(1));
              200 * (x(2) - x(1)^2)];
          
        num_calls(2) = num_calls(2) + 1;
    end
    if nargout > 2
        Hf = [1200*x(1)^2-400*x(2)+2,  -400*x(1);
              -400*x(1),               200];
        num_calls(3) = num_calls(3) + 1;
    end