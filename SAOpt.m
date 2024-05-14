function [sigma_max, kp_max, ki_max] = SAOpt(a, b, z, h, w_1, w_2, sigma_1, sigma_2, p, ps)
% SAOpt finds the minimal spectral abscissa achievable for a 
% linear second-order non-minimum phase time-delay system using a classical
% PI controller.
%
% Syntax:
%   [sigma_max, kp_max, ki_max] = find_sigma_max(a, b, z, h, w_1, w_2, sigma_1, sigma_2, p, ps)
%
% Description:
%   This function calculates the maximum value of sigma such that the system
%   can be sigma-stabilized by a PI controller, as well as the pair of control
%   gains that allow achieving such spectral abscissa. The system is of the
%   form exp(-h*s)*(s-z)/(s^2+a*s+b).
%
% Input Arguments:
%   - a: System parameter 'a'.
%   - b: System parameter 'b'.
%   - z: System parameter 'z'.
%   - h: System parameter 'h'. Must be a positive value.
%   - w_1: First frequency to compute the crossing curves for.
%   - w_2: Last frequency to compute the crossing curves for.
%   - sigma_1: Lower boundary of the interval to search for sigma_max.
%   - sigma_2: Upper boundary of the interval to search for sigma_max.
%   - p: Number of frequencies to consider between w_1 and w_2.
%   - ps: Number of sigmas to consider between sigma_1 and sigma_2.
%
% Output Arguments:
%   - sigma_max: Maximum value of sigma such that the system can be 
%     sigma-stabilized by a PI controller.
%   - kp_max: Proportional gain corresponding to sigma_max.
%   - ki_max: Integral gain corresponding to sigma_max.
%
% Example (open-loop unstable system):
%   a = 0;
%   b = 4;
%   z = 1;
%   h = 1;
%   p = 10000;
%   w_1 = 0;
%   w_2 = 5;
%   sigma_1 = 0;
%   sigma_2 = 2;
%   ps = 50; 
%   [sigma_max, kp_max, ki_max] = SAOpt(a, b, z, h, w_1, w_2, sigma_1, sigma_2, p, ps)

    if all(real(roots([1, a, b]))<0) % Check if it's case 1, open-loop stable
        a5 = h^2;
        a4 = 2*h^2*z-a*h^2-4*h;
        a3 = 2-2*a*h^2*z+2*a*h+b*h^2+h^2*z^2-10*h*z;
        a2 = 6*z-a*h^2*z^2+6*a*h*z+2*b*h^2*z-6*h*z^2;
        a1 = 4*a*h*z^2+b*h^2*z^2-2*b*h*z+6*z^2;
        a0 = -(2*a*z^2+2*b*h*z^2+2*b*z);
        poly = [a5, a4, a3, a2, a1, a0];
        sigma_max = min(roots(poly));
        kp_max = (exp(-h*sigma_max)*(b*z-(2*a+b*h)*z*sigma_max-(a+b*h- ...
            (3+a*h)*z)*sigma_max^2+(2+a*h-h*z)*sigma_max^3-h*sigma_max^4))/((z+sigma_max)^2);
        ki_max = (exp(-h*sigma_max)*sigma_max^2*(-a*z-b*(1+h*(z+sigma_max)) ...
            +sigma_max*(sigma_max+h*(a-sigma_max)*sigma_max+z*(2+a*h-h*sigma_max))))/((z+sigma_max)^2);
        return
    end
    sigma = linspace(sigma_1, sigma_2, ps);
    kp_i = 0;
    ki_i = 0;
    f = 0; % flag to indicate the intersection of the curve and line
    for i = 1:length(sigma)
        ki = kiw(a, b, z, h, sigma(i), w_1, w_2, p); % Crossing curves
        kp = kpw(a, b, z, h, sigma(i), w_1, w_2, p);
        kp0 = linspace(min(kp), max(kp), p);
        ki0 = sigma(i)*(kp0-(exp(-h*sigma(i))*(sigma(i)*(sigma(i)-a)+b))/(sigma(i)+z));
        kp_prev = kp_i;
        ki_prev = ki_i;
        [kp_i, ki_i] = intersections(kp, ki);
        [kp_c, ki_c] = intersections(kp, ki, kp0, ki0);
        if length(kp_c) == 2 %% check if for the first time the curves are crossing
            f = 1;
        end
        if f == 1 && length(kp_c) == 2 %% check if for the second time the curves are crossing so the collapse is there
            sigma_max = sigma(i);
            kp_max = kp_c;
            ki_max = ki_c;
            return
        end
        if length(kp_i) < 1 % check if the autointersection exists for the given sigma
            sigma_max = sigma(i);
            kp_max = kp_prev;
            ki_max = ki_prev;
            return
        end
    end
    sigma_max = [];
    kp_max = [];
    ki_max = [];
    print('No solution found, try a different interval for sigma')
end