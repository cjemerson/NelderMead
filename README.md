# NelderMead
Math 661 - Optimization: Research Project Repository

## Intro
The Nelder-Mead method is a derivative-free method of optimization. While there are no generic proofs of convergence, it has demonstrated itself to be robust and reliable.

Some of the MATLAB code is the work [Dr. E. Bueler](http://bueler.github.io). He created *sdbt.m*, *newtonbt.m*, and the original versions of *easy2dquad.m*, *easy5dquad.m*, and *rosenbrock.m*. 

## Illustrations
![Asset unable to loaded](https://github.com/cjemerson/NelderMead/assets/neldermead_easy2dquad_contours.gif "Using neldermead.m, an easy 2-D quadratic with a unique minimum at (0, 0) is optimized.")
![Asset unable to loaded](https://github.com/cjemerson/NelderMead/assets/neldermead_rosenbrock_contours.gif "Using neldermead.m, the Rosenbrock banana curve with a unique minimum at (1, 1) is optimized.")

## What is in the repository?
MATLAB functions which take in a point and return the objective value, gradient and Hessian at that point. Additionally, each function counts the number of calls for objective value, gradient and Hessian. These number of calls are returned in their respective output by calling the function without input. The number of calls is reset by calling clear on the function. For example, to clear then number of calls to easy2dquad.m call `clear easy2dquad`.
* easy2dquad.m
* rosenbrock.m
* himmelblau.m
* easy5dquad.m

MATLAB functions which can optimize a n-dimensional function given an intial position and a tolerance.
* neldermead.m
* sdbt.m
* newtonbt.m

MATLAB functions to assist in illustrating a problem and the Nelder-Mead method. Note *plot_triangle.m* can plot the xklist output of *neldermead.m*.
* make_contours.m
* add_marker.m
* plot_triangle.m
* make_neldermead_gif.m

## Using *neldermead.m* in the MATLAB command line
```matlab
>> clear easy2dquad
>> [xk, xklist] = neldermead([1, 1]', @easy2dquad, 1e-4);
>> reported_min = xk

reported_min =
    0.0027
   -0.0090

>> num_iterations = length(xklist)/3 - 1

num_iterations =

    20

>> [f_calls, df_calls, Hf_calls] = easy2dquad

f_calls =

    62


df_calls =

     0


Hf_calls =

     0

>> iters = length(xklist)-1

iters =

    62

```