clear, clc;

R = 0.011;
L = 0.018;
Fi = 0.055;
p = 4;
JM = 0.002; JL = 0.1;
BM = 0.18; BS = 0.0;
KS = 500;

%initial condition
ic = [0, 0, 0, 1, 1]; 
% u(1) = ud
% u(2) = uq
u = [0, 0];
dt = 0.01;
tLimit = 120;
tspan = 0:dt:tLimit;
% tud = tspan;
% ud = 1*sin(2*pi*tud/20);

%% Loop
xvals = [];
opts = odeset('RelTol',1e-8,'AbsTol',1e-8);
for para = 0.005:0.005:1
    BM = para;
    % calculate the paremeter
    A1 = -(BM*KS)/(JM*JL);
    A2 = -(JM*KS+JL*KS+BM*BS)/(JM*JL);
    A3 = -(JL*BS+JM*BS+JL*BM)/(JM*JL);
    A4 = (p*Fi)/(JM*JL);
    C1 = -R/L; C2 = KS*p; C3 = BS*p; C4 = JL*p; C5 = 1/L;
    D1 = -R/L; D2 = -KS*p; D3 = -BS*p; D4 = -JL*p;
    D5 = (Fi*KS*p)/L; D6 = (Fi*BS*p)/L;
    D7 = (Fi*JL*p)/L; D8 = 1/L;
    parameter = [A1,A2,A3,A4,C1,C2,C3,C4,C5,D1,D2,D3,D4,D5,D6,D7,D8];
    B3 = JL; B2 = BS; B1 = KS;
    
    % integration
    [t, x] = ode45(@(t, x)PMSMfunFlex(t, x, parameter), tspan, ic, opts);
    id = x(:,4);
    iq = x(:,5);
    omega = B1*x(:,1)+B2*x(:,2)+B3*x(:,3);
    
    idd = id(floor(length(id)/2):end);
    iqq = iq(floor(length(iq)/2):end);
    omegaa = omega(floor(length(omega)/2):end);
    tt = t(floor(length(t)/2):end);
    
    point = [mean(idd),mean(iqq),mean(omegaa)];
    nvector = [1,0,0];
    xx = [idd,iqq,omegaa];
    section = Fsections(point,nvector,xx,tt);
    Rsec = size(section,1);
    Rxva = size(xvals,2);
    xvals(1, (Rxva+1):(Rxva+Rsec)) = section(:,4);
    xvals(2, (Rxva+1):(Rxva+Rsec)) = zeros(1,Rsec)+para;   
end

%% figure
figure('color',[1 1 1]);
set(gcf,'position',[50 50 500 400]);
% plot(xvals(2,:), xvals(1,:), ':', 'LineWidth', 2, 'color', [0, 0, 0]);
plot(xvals(2,:), xvals(1,:), '.', 'MarkerSize', 5, 'color', [0, 0, 0]);
hold on
set(gca,'XLim',[0.005 1]);
set(gca,'fontsize',15,'fontname','Times New Roman');
xlabel('$B_M$','interpreter','latex', 'Fontname', 'Times New Roman','FontSize',16,'FontAngle','italic');
ylabel('$\omega_M$','interpreter','latex','Fontname', 'Times New Roman','FontSize',16,'FontAngle','italic');
grid on;
set(gca,'position',[0.13 0.15 0.83 0.82]);


















