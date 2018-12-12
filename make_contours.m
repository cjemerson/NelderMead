function g = make_contours(f, xlims, ylims)
% MAKE_CONTOURS Plots a logarithmic contour map. Returns the
% plotted contour object.
	contours = [0:0.001:0.01, 0.02:0.01:0.1, 0.2:0.1:1, 2:1:10,20:10:100, 200:100:1000];
	[X, Y] = meshgrid(linspace(xlims(1), xlims(2)), linspace(ylims(1), ylims(2)));

	for j = 1:length(X)
		for k = 1:length(Y)
			Z(j, k) = f([X(j, k), Y(j, k)]');
		end
	end
	[~, g] =contourf(X, Y, Z, contours);
	set(g, 'LineStyle', 'none');
end