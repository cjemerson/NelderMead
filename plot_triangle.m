function h = plot_triangle(A)
% PLOT_TRIANGLE Plots 2-D triangles whose vertices are the i-th
% through the (i+2)-th columns of input A. Specifically designed to
% illustrate the xklist output of neldermead.m.
% Returns an array of the plot objects.
    dim = size(A);
    if (dim(1) ~= 2 || mod(dim(2), 3) ~= 0 )
        error('Invalid matrix dimensions. Must be 2 x 3n');
    end

    hold on;
    h = [];
    for i = 1:3:dim(2)
        x = A(1, i:i+2);
        y = A(2, i:i+2);

        g = fill(x, y, 'g');
        set(g, 'FaceAlpha', 0.75);
        h = [h, g];
    end
end