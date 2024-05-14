# Optimal-Spectral-Abscissa
PI Control for Optimal Spectral Abscissa in General Non-Minimum Phase Systems with Time Delay

## Main function
# SAOpt

Finds the minimal spectral abscissa achievable for a linear second-order non-minimum phase time-delay system using a classical PI controller.

## Syntax

```matlab
[sigma_max, kp_max, ki_max] = find_sigma_max(a, b, z, h, w_1, w_2, sigma_1, sigma_2, p, ps)
```
## Used functions
To find the self-intersections of the curve we use intersections, provided by Doug Schwarz. On the Matlab File Exchange: https://fr.mathworks.com/matlabcentral/fileexchange/11837-fast-and-robust-curve-intersections 
kpw and kiw give the corresponding stability crossing curve (kp, ki) for a given sigma 
