function ki = kiw(a, b, z, h, sigma, w_1, w_2, p)
    w = linspace(w_1, w_2, p);
    x1 = w.*(-b-a*z+2*z*sigma+sigma^2+w.^2);
    x2 = (z+sigma)*(b+sigma*(sigma-a))-(a+z-sigma)*w.^2;
    ki = exp(-h*sigma)*(sigma^2+w.^2).*(cos(h*w).*x1-sin(h*w).*x2)./(w.*((z+sigma)^2+w.^2));
end