function kp = kpw(a, b, z, h, sigma, w_1, w_2, p)
    w = linspace(w_1, w_2, p);
    y1 = -w.*(-b*z+sigma*(2*a*z+a*sigma-3*z*sigma-2*sigma^2)+(a+z-2*sigma)*w.^2);
    y2 = (sigma*(z+sigma)*(b+sigma*(-a+sigma))+(b+a*z-(a+3*z)*sigma)*w.^2-w.^4);
    kp = exp(-h*sigma)*(cos(h*w).*y1-sin(h*w).*y2)./(w.*((z+sigma)^2+w.^2));
end