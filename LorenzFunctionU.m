function [dydx] = LorenzFunctionU(t, y, parameter, tud, ud)

GAMA = parameter(1); 
SIGMA = parameter(2);

% GAMA = 24.4444;
% SIGMA = 2.8877;

ud = interp1(tud, ud, t); % Interpolate the data set (ft,f) at time t

dydx = [
    -y(1)+y(2).*y(3)+ud;
    -y(2)-y(1).*y(3)+GAMA*y(3)+0;
    SIGMA*(y(2)-y(3))+0;
];
end

