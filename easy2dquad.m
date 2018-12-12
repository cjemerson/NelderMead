function [f, df, Hf] = easy2dquad(x)
% EASY2DQUAD  Easy to minimize quadratic function in 2D with unique minimum 0.

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

    f = 5 * x(1)^2 + 0.5 * x(2)^2;
    num_calls(1) = num_calls(1) + 1;
    
    if (nargout > 1)
        df = [10 * x(1);
              x(2)];
        num_calls(2) = num_calls(2) + 1;
    end
    if nargout > 2
        Hf = [10, 0; 0, 1];
        num_calls(3) = num_calls(3) + 1;
    end
end

