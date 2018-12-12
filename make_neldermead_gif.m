function make_neldermead_gif(filename, x0, f, tol, scale, xlims, ylims, xmin)
% MAKE_NELDERMEAD_GIF A function which illustrates the process of how to create a gif in MATLAB.
	[~, xklist] = neldermead(x0, f, tol, scale, 1000);

	h = figure;

	hold on;
	if (nargin > 6)
		make_contours(f, xlims, ylims);
	end
	if (nargin > 7)
		add_marker(xmin);
	end

	axis tight manual % To ensure that getframe() returns a consistent size
	for j = 1:3:length(xklist(1, :))
		plot_triangle(xklist(:, j:j+2));

		drawnow

		% Capture the plot as an image
		frame = getframe(h);
		im = frame2im(frame);
		[imind,cm] = rgb2ind(im,256);

		% Write to the GIF File
		if j == 1
            % On the first iteration
			imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
        else
            % On every iteration after
			imwrite(imind,cm,filename,'gif','WriteMode','append');
		end
	end
end