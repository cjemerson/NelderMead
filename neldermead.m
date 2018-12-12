function [xk, xklist] = neldermead(x0, f, tol, scale, maxiters)
% NELDERMEAD  Nelder-Mead optimization (aka Downhill Simplex method or Amoeba method).
% Stopping criterion is tolerance on the 2-norm of the distance between the simplex
% vertices and the centroid of the simplex.
% Usage:
%   [xk, xklist] = neldermead(x0, f, <tol>, <scale>, <maxiters>)
%   <optional> - explicitly set to zero gives default behavior
% where
%   x0          vector used to construct initial simplex 
%   f           function handle (e.g. "f" if f is anonymous or "@f" if f is
%               f.m); f() needs to return function value f(x_k) and gradient
%               grad f(x_k) as the first output:   [fxk] = f(xk)
%   tol         <optional> stop when 2-norm of gradient divided by the sqrt(N)
%               is less than this number
%   scale       <optional> scale the initial simplex S_0
%               S_0 = { x0, x0 + scale*e_0, ..., x0 + scale*e_n }
%   maxiters    <optional> maximum number iterations
% and (outputs)
%   xk          Nth iterate
%   xklist      all iterate simplex vertices as a N x 3(N+1) column matrix

    [n, r] = size(x0);
    if (r ~= 1)
        error('Invalid dimensions, x0 must be a column vector');
    end

    if (nargin < 3 || tol <= 0)
        tol = 1e-8;
    end
    if (nargin < 4 || scale == 0)
        scale = 1;
    end
    if (nargin < 5 || maxiters <= 0)
        maxiters = 20000;
    end

    % Create simplex and determine function values
    P_list = [x0, scale*eye(n) + x0];
    y_list = nan(1, n + 1);

    for i = 1:n+1
        y_list(i) = f(P_list(:, i));
    end

    if (nargout > 1)
        xklist = [P_list];
    end

    alpha = 1; % MUST BE POSITIVE
    gamma = 2; % MUST BE GREATER THAN UNITY
    beta = 0.5; % MUST BE BETWEEN 0 AND 1

    for iter = 1:maxiters
        % Determine the values and indices of the highest (h) and lowest (l) points
        [y_h, h] = max(y_list);
        [y_l, l] = min(y_list);

        % Determine centroid (excluding h)
        except_h = true(1, n+1);
        except_h(1, h) = false;
        P_centroid = mean(P_list(:, except_h), 2);
        y_centroid = f(P_centroid); % used in stopping criterion

        % Determine P_star (DETERMINE REFLECTON)
        P_star = (1 + alpha)*P_centroid - alpha*P_list(:, h);
        y_star = f(P_star);

        if (y_star == y_l && y_star == y_h)
            xk = P_list(:, l);
            if (nargout > 1)
                xklist = [xklist P_list(:, l)];
            end

            break;
        end

        if (y_star < y_l)
            % EXPANSION TEST
            % The original paper gives two definitions: (inline p.1 & flowchart p.2)
            P_star_star = gamma*P_star + (1 - gamma)*P_centroid;
            % P_star_star = (1 + gamma)*P_star - gamma*P_centroid;

            y_star_star = f(P_star_star);

            if (y_star_star <= y_l)
                % SUCCESSFUL EXPANSION
                P_list(:, h) = P_star_star;
                y_list(h) = y_star_star;

            else % if (y_star_star > y_l)
                % FAILED EXPANSION
                P_list(:, h) = P_star;
                y_list(h) = y_star;
            end
        else
            % Determine second highest (s) value, (index unnecessary)
            y_s = max(y_list(except_h));

            if (y_star > y_s)
                if (y_star < y_h)
                    % REPLACE P_h WITH P_star (still highest value point)
                    P_list(:, h) = P_star;
                    y_list(h) = y_star;
                    y_h = y_star;
                end

                P_star_star = beta*P_list(:, h)+(1-beta)*P_centroid;
                y_star_star = f(P_star_star);

                if (y_star_star > y_h)
                    % SHRINK
                    % For each P_i replace with (P_i + P_l)/2
                    P_list = (P_list + P_list(:, l))/2;

                    for j = 1:n+1
                        if (j == l)
                            continue;
                        end
                        y_list(j) = f(P_list(:, j));
                    end

                else % if (y_star_star <= y_h)
                    % CONTRACTION
                    P_list(:, h) = P_star_star;
                    y_list(h) = y_star_star;
                end

            else % if (y_star <= y_s)
                P_list(:, h) = P_star;
                y_list(h) = y_star;
            end
        end

        if (nargout > 1)
            xklist = [xklist P_list];
        end

        % STOPPING CRITERION
        % The following is the stopping criterion as defined in the original paper
        tol_criterion = sqrt(sum((y_list(except_h)-y_centroid).^2)/n);

        if (tol_criterion < tol)
            xk = P_list(:, l);
            break;
        end

    end
end