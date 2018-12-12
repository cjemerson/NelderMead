function [f, df, Hf] = easy5dquad(x)
	% EASY5DQUAD  Easy to minimize quadratic function in 5D with unique minimum 0.


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

	if length(x) ~= 5,  error('x must be length 5 vector'),  end
	f = 10 * x(1)^2 + 5 * x(2)^2 + 1 * x(3)^2 + 0.5 * x(4)^2 + 0.1 * x(5)^2;
	num_calls(1) = num_calls(1) + 1;

	if (nargout > 1)
		df = [20 * x(1);
		      10 * x(2);
		      2 * x(3);
		      x(4);
		      0.2 * x(5)];
		num_calls(2) = num_calls(2) + 1;
	end
	if nargout > 2
	   Hf = [20,  0,   0,   0,   0;
	         0,  10,   0,   0,   0;
	         0,   0,   2,   0,   0;
	         0,   0,   0,   1,   0;
	         0,   0,   0,   0, 0.2];
	         num_calls(3) = num_calls(3) + 1;
	end
end