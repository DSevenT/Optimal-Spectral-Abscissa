# Optimal-Spectral-Abscissa
PI Control for Optimal Spectral Abscissa in General Non-Minimum Phase Systems with Time Delay

## Main function
# SAOpt

Finds the minimal spectral abscissa achievable for a linear second-order non-minimum phase time-delay system using a classical PI controller.

## Syntax

```matlab
[sigma_max, kp_max, ki_max] = find_sigma_max(a, b, z, h, w_1, w_2, sigma_1, sigma_2, p, ps)
```
## Description

This function calculates the maximum value of sigma such that the system can be sigma-stabilized by a PI controller, as well as the pair of control gains that allow achieving such spectral abscissa. The system is of the form exp(-hs)(s-z)/(s^2+a*s+b).
## Input Arguments

    a: System parameter 'a'.
    b: System parameter 'b'.
    z: System parameter 'z'.
    h: System parameter 'h'. Must be a positive value.
    w_1: First frequency to compute the crossing curves for.
    w_2: Last frequency to compute the crossing curves for.
    sigma_1: Lower boundary of the interval to search for sigma_max.
    sigma_2: Upper boundary of the interval to search for sigma_max.
    p: Number of frequencies to consider between w_1 and w_2.
    ps: Number of sigmas to consider between sigma_1 and sigma_2.

## Output Arguments

    sigma_max: Maximum value of sigma such that the system can be sigma-stabilized by a PI controller.
    kp_max: Proportional gain corresponding to sigma_max.
    ki_max: Integral gain corresponding to sigma_max.
## Used functions
To find the self-intersections of the curve we use intersections, provided by Doug Schwarz. On the Matlab File Exchange: https://fr.mathworks.com/matlabcentral/fileexchange/11837-fast-and-robust-curve-intersections 
kpw and kiw give the corresponding stability crossing curve (kp, ki) for a given sigma 
