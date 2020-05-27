function section = Fsections(point, Nvector, x, t)
% For 3D system
% point = the point on the section (row vector)
% Nvector = Normal vector, (row vector)
% x = input data
% t = input time

% vec = x-point

% section(n,1) = t
% section(n,2) = x
% section(n,3) = y
% section(n,4) = z
section = [];

point = point';
Nvector = Nvector';
vec = x;
vec(:,1) = vec(:,1)-point(1);
vec(:,2) = vec(:,2)-point(2);
vec(:,3) = vec(:,3)-point(3);

inner = vec*Nvector;

n = 1;
for i = 1:1:length(t)-1
    a = inner(i)*inner(i+1); % to judge whether it passes through the section
    if(a < 0) % linear interpolation
        lambda = (x(i,:)*Nvector-point'*Nvector)/((x(i,:)-x(i+1,:))*Nvector);
        section(n,1) = (1-lambda)*t(i)+lambda*t(i+1);
        section(n,2) = (1-lambda)*x(i,1)+lambda*x(i+1,1);
        section(n,3) = (1-lambda)*x(i,2)+lambda*x(i+1,2);
        section(n,4) = (1-lambda)*x(i,3)+lambda*x(i+1,3);
        n = n+1;
    end
end
end

