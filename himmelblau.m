function [f, df, Hf] = himmelblau(x)
% HIMMELBLAU A multi-modal function with 4 global minima at (3.0, 2.0),
% (-2.805118, 3.131312), (-3.779310, -3.283186), and (3.584428, -1.848126)

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

    f = (x(1)^2 + x(2)-11)^2 + (x(1) + x(2)^2 - 7)^2;

    num_calls(1) = num_calls(1) + 1;

    if nargout > 1
%         df = [2*(2*x(1)*(x(1)^2 + x(2)-11) + x(1) + x(2)^2 - 7);
%               2*(x(1)^2+2*x(2)*(x+x(2)^2-7)+x(2)+11)];
        df = [2 * (2 * x(1)  *(x(1)^2 + x(2) - 11) + x(1) + x(2)^2 - 7); 2*(x(1)^2 + 2 *x(2)* (x(1) + x(2)^2 - 7) + x(2) - 11)];
        num_calls(2) = num_calls(2) + 1;
    end
    if nargout > 2
        Hf = [4*(x(1)^2+x(2)-11)+8*x(1)^2 + 2,  4*x(1) + 4*x(2);
              4*x(1) + 4*x(2),              4*(x(1) + x(2)^2 - 7) + 8*x(2)^2 + 2];
        num_calls(3) = num_calls(3) + 1;
    end