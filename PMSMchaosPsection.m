clear, clc;
% parameter(1) = Rs % 0.011
% parameter(2) = Ld % 0.018
% parameter(3) = Lq % 0.018
% parameter(4) = Fi % 0.055
% parameter(5) = p % 4
% parameter(6) = J % 0.102
% parameter(7) = b % 0.2
%Parameter = [0.011; 0.018; 0.018; 0.055; 4; 0.1; 0.2]; %chaotic values
Rs = 0.011;
Ld = 0.018;
Lq = 0.018;
Fi = 0.055;
p = 4;
J = 0.102;
b = 0.18;
tao = Lq/Rs;
k = b/(tao*p*p*Fi);
GAMA =  Fi/(k*Lq)
SIGMA = tao*b/J
parameter = [GAMA SIGMA];
% x(1) = id
% x(2) = iq
% x(3) = omegaP
x0 = [1; 1; 1]; %initial condition
% u(1) = ud
% u(2) = uq
% u(3) = TL
u = [0; 0; 0];
dt = 0.01;
tLimit = 100;
tspan = 0:dt:tLimit;
tud = tspan;
gainn = 1/(Rs*k);
ud = 100*sin(2*pi*tud);

% 1.42 1.43

opts = odeset('RelTol',1e-6,'AbsTol',1e-6);
% Bifurcation Diagran with GAMA
xvals = [];

for para = 2:0.005:3
    ppara = para;
    if ppara == 2
        ppara = 2.005;
    end
    parameter(2) = ppara;
    [t, x] = ode45(@(t, x)LorenzFunction(t, x, u, parameter), tspan, x0, opts);
    xx = x(floor(size(x,1)/2):end,:);
    tt = t(floor(size(t,1)/2):end,:);
    point = [mean(xx(:,1)),mean(xx(:,2)),mean(xx(:,3))];
    nvector = [1,0,0];
    section = Fsections(point,nvector,xx,tt);
    Rsec = size(section,1);
    Rxva = size(xvals,2);
    xvals(1, (Rxva+1):(Rxva+Rsec)) = section(:,4);
    xvals(2, (Rxva+1):(Rxva+Rsec)) = zeros(1,Rsec)+para;   
end

figure('color',[1 1 1]);
set(gcf,'position',[50 50 500 400]);
% plot(xvals(2,:), xvals(1,:), ':', 'LineWidth', 2, 'color', [0, 0, 0]);
plot(xvals(2,:), xvals(1,:), '.', 'MarkerSize', 5, 'color', [0, 0, 0]);
hold on
set(gca,'XLim',[2 3]);
set(gca,'fontsize',15,'fontname','Times New Roman');
xlabel('\sigma','Fontname', 'Times New Roman','FontSize',16,'FontAngle','italic');
ylabel('$\tilde{\omega}_p$','interpreter','latex','Fontname', 'Times New Roman','FontSize',16,'FontAngle','italic');
grid on;
set(gca,'position',[0.13 0.15 0.83 0.82]);


% yvals = [];
% for SIGMA = 1.43:0.01:25
%     parameter(2) = SIGMA;    
%     [t, x] = ode45(@(t, x)LorenzFunction(t, x, u, parameter), tspan, x0, opts);
%     for i = 0:iLimit  
%         yvals(1, length(yvals)+1) = SIGMA;
%         yvals(2, length(yvals)) = x(i+iFrom,1);
%         yvals(3, length(yvals)) = x(i+iFrom,2);
%         yvals(4, length(yvals)) = x(i+iFrom,3);
%         if(abs(x(i+iFrom,3)-x(i+iFrom-1,3))<0.001)
%             break;
%         end       
%     end
% end
% 
% plot(yvals(1,:), yvals(4,:), ':', 'LineWidth', 1, 'color', [0, 0, 0]);
% hold on





% %% Lorenz only
% opts = odeset('RelTol',1e-12,'AbsTol',1e-12);
% [t, x] = ode45(@(t, x)LorenzFunction(t, x, u, parameter), tspan, x0, opts);
% %plot3(x(:,1), x(:,2), x(:,3)/Parameter(5));
% %plot(x(:,3)/Parameter(5));

% % Figure Poincare section x-y
% figure('color',[1 1 1]);
% plot(x(:,1), x(:,2), '.', 'MarkerSize', 2);
% set(gca,'fontsize',15,'fontname','Times');
% xlabel('i_d','Fontname', 'Times New Roman','FontSize',17,'FontAngle','italic');
% ylabel('i_q','Fontname', 'Times New Roman','FontSize',17,'FontAngle','italic');
% grid on;

% % Figure Poincare section x-z
% figure('color',[1 1 1]);
% plot(x(:,1), x(:,3), '.', 'MarkerSize', 2);
% set(gca,'fontsize',15,'fontname','Times');
% xlabel('i_d','Fontname', 'Times New Roman','FontSize',17,'FontAngle','italic');
% ylabel('\omega','Fontname', 'Times New Roman','FontSize',17,'FontAngle','italic');
% grid on;

% % Figure Poincare section y-z
% figure('color',[1 1 1]);
% plot(x(:,2), x(:,3), '.', 'MarkerSize', 2);
% set(gca,'fontsize',15,'fontname','Times');
% xlabel('i_q','Fontname', 'Times New Roman','FontSize',17,'FontAngle','italic');
% ylabel('\omega','Fontname', 'Times New Roman','FontSize',17,'FontAngle','italic');
% grid on;

% % Figure x-y-z
% figure('color',[1 1 1]);
% plot3(x(:,1), x(:,2), x(:,3), '.', 'MarkerSize', 2);
% set(gca,'fontsize',15,'fontname','Times');
% grid on;




