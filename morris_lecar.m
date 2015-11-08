%file morris_lecar.m
%Morris-Lecar model of excitable barnacle muscle fiber
%adapted from Morris and Lecar (1981) Biophysical Journal 35 pp. 193-231
%Figures 8.6 and 8.7

function morris_lecar

%declare model parameters
global C;
global gbarCa;
global ECa;
global gbarK;
global EK;
global gleak;
global Eleak;
global v1;
global v2;
global v3;
global v4;
global phi;
global tau;
global Iapplied;

%assign parameter values
C= 20 ; %microfarad/cm^2 
gbarCa=4.4; % millisiemens/ cm^2 
ECa=120; %millivolts
gbarK=8;% millisiemens/ cm^2 
EK=-84; %millivolts
gleak=2;% millisiemens/ cm^2 
Eleak=-60;%millivolts
v1=-1.2; %millivolts
v2= 18 ; %millivolts
v3= 2 ; %millivolts
v4= 30; %millivolts
phi = 0.04 % per millisecond
tau=0.8

Iapplied=0;

%set simulation parameters
OPTIONS = odeset('RelTol',1e-9,'AbsTol',1e-9, 'refine',5, 'MaxStep', 1);
ODEFUN=@morris_lecar_ddt;
Tend=200;

%set initial conditions for Figure 8.6A. state=(V,w)

%rest:
S00=[-60.8554    0.0149];
%sub-threshold
S10=[-35    0.0149];
%sub-threshold
S20=[-15   0.0149];
%super-threshold
S30=[ -13  0.0149];
%super-threshold
S40=[15    0.0149];

%run simulations
[t1,S1]=ode15s(ODEFUN, [0 100], S00);
[t2,S2]=ode15s(ODEFUN, [t1(length(t1)) 150 + t1(length(t1))], S10);
[t3,S3]=ode15s(ODEFUN, [t2(length(t2)) 150 + t2(length(t2))], S20);
[t4,S4]=ode15s(ODEFUN, [t3(length(t3)) 150 + t3(length(t3))], S30);
[t5,S5]=ode15s(ODEFUN, [t4(length(t4)) 150 + t4(length(t4))], S40);

%produce figure 8.6A
figure(1)
set(gca, 'fontsize', 14)
plot([t1;t2;t3;t4;t5], [S1(:,1); S2(:,1);S3(:,1); S4(:,1); S5(:,1)], 'k', 'Linewidth', 3)
xlabel('Time (msec)', 'fontsize',12)
ylabel('Membrane Voltage (mV)', 'fontsize',12)
str1(1) = {'A'};
text(-90,40,str1, 'Fontsize', 40)
str1(1) = {'-35 mV'};
text(25,-30,str1, 'Fontsize', 15)
str1(1) = {'-15 mV'};
text(150,-15,str1, 'Fontsize', 15)
str1(1) = {'-13 mV'};
text(310,-10,str1, 'Fontsize', 15)
str1(1) = {'+5 mV'};
text(465,5,str1, 'Fontsize', 15)


%Figure 8.6B
figure(2)
hold on
%generate nullclines
myfun1 = @(Vn,wn) (1/C)*(gbarCa*(0.5*(1+tanh((Vn-v1)/v2)))*(ECa-Vn) + gbarK*wn*(EK-Vn) + gleak*(Eleak-Vn));
myfun2 = @(Vn,wn) phi*((0.5*(1+tanh((Vn-v3)/v4)))-wn)/tau;
a1=ezplot(@(Vn,wn) myfun1(Vn,wn), [-80 40 -0.2 1])
setcurve('color','black','linestyle','--', 'Linewidth', 1) 
set(gca, 'fontsize', 14)
a2=ezplot(@(Vn,wn) myfun2(Vn,wn), [-80 40 -0.2 1])
setcurve('color',[0.5 0.5 0.5], 'Linewidth', 1) 
legend('V nullcline', 'w nullcline')
title('')

%simulate trajectories
[tp1,Sp1]=ode15s(ODEFUN, [0 300], [-35, 0.0149]);
[tp2,Sp2]=ode15s(ODEFUN, [0 300], [-15, 0.0149]);
[tp3,Sp3]=ode15s(ODEFUN, [0 300], [-13, 0.0149]);
[tp4,Sp4]=ode15s(ODEFUN, [0 300], [5, 0.0149]);
plot(Sp1(:,1), Sp1(:,2), 'k', Sp2(:,1), Sp2(:,2), 'k', 'Linewidth', 3)
plot(Sp3(:,1), Sp3(:,2), 'k', Sp4(:,1), Sp4(:,2), 'k', 'Linewidth', 3)
xlabel('Membrane Voltage V (mV)', 'fontsize',12)
ylabel('Potassium gating variable w', 'fontsize',12)
axis([-80 40 -0.15 0.5])


%figure 8.7

%initial condition: subthreshold perturbation
S0a=[-35    0.0149];

Iapplied=20
[ta1,Sa1]=ode15s(ODEFUN, [0 200], S0a);
Iapplied=150
[ta3,Sa3]=ode15s(ODEFUN, [0 200], S0a);
Iapplied=400
[ta4,Sa4]=ode15s(ODEFUN, [0 200], S0a);

%produce figure 8.7A
figure(3)
set(gca, 'fontsize', 14)
plot(ta4, Sa4(:,1), 'k-.',ta3, Sa3(:,1), 'k',ta1, Sa1(:,1), 'k--','Linewidth', 3)
xlabel('Time (msec)', 'fontsize',12)
ylabel('Membrane Voltage (mV)', 'fontsize',12)
legend('I_{applied} = 400 pA/cm^2', 'I_{applied} = 150 pA/cm^2', 'I_{applied} = 20 pA/cm^2', 'fontsize', 18) 



%figure 8.7B

%generate nullclines
figure(4)
Iapplied=150
hold on
myfun1 = @(Vn,wn) (1/C)*(gbarCa*(0.5*(1+tanh((Vn-v1)/v2)))*(ECa-Vn) + gbarK*wn*(EK-Vn) + gleak*(Eleak-Vn)+Iapplied);
%myfun2 = @(Vn,wn) phi*((0.5*(1+tanh((Vn-v3)/v4)))-wn)/((1/(cosh((Vn-v3)/(2*v4)))));
myfun2 = @(Vn,wn) phi*((0.5*(1+tanh((Vn-v3)/v4)))-wn)/tau;
a1=ezplot(@(Vn,wn) myfun1(Vn,wn), [-80 60 -0.2 1])
setcurve('color','black','linestyle','--', 'Linewidth', 1) 
set(gca, 'fontsize', 14)
a2=ezplot(@(Vn,wn) myfun2(Vn,wn), [-80 60 -0.2 1])
setcurve('color',[0.5 0.5 0.5], 'Linewidth', 1) 
legend('V nullcline', 'w nullcline')
title('')

%generate simulation trajectories
[tp1,Sp1]=ode15s(ODEFUN, [0 300], [-40, 0]);
[tp2,Sp2]=ode15s(ODEFUN, [0 300], [60, 0.4]);
[tp3,Sp3]=ode15s(ODEFUN, [0 300], [20, 0.75]);
[tp4,Sp4]=ode15s(ODEFUN, [0 300], [-70, 0.5]);
[tp5,Sp5]=ode15s(ODEFUN, [0 300], [0, 0.35]);
[tp6,Sp6]=ode15s(ODEFUN, [0 300], [-10, 0.45]);

%plot trajectories
plot(Sp1(:,1), Sp1(:,2), 'k', Sp2(:,1), Sp2(:,2), 'k', 'Linewidth', 2)
plot(Sp3(:,1), Sp3(:,2), 'k', Sp4(:,1), Sp4(:,2), 'k', 'Linewidth', 2)
plot(Sp5(:,1), Sp5(:,2), 'k', Sp6(:,1), Sp6(:,2), 'k', 'Linewidth', 2)
xlabel('Membrane Voltage V (mV)', 'fontsize',12)
ylabel('Potassium gating variable w', 'fontsize',12)
axis([-70 60 0. 0.75])

end

%dynamics
function dS = morris_lecar_ddt(t,S)

global C;
global gbarCa;
global ECa;
global gbarK;
global EK;
global gleak;
global Eleak;
global v1;
global v2;
global v3;
global v4;
global phi;
global tau;
global Iapplied;

%locally define state variables:
V=S(1);
w=S(2);

%local functions:
m_inf = (0.5*(1+tanh((V-v1)/v2)));
w_inf = (0.5*(1+tanh((V-v3)/v4)));

ddt_V = (1/C)*(gbarCa*m_inf*(ECa-V) + gbarK*w*(EK-V) + gleak*(Eleak-V)+Iapplied);
ddt_w = phi*(w_inf-w)/(tau);

dS=[ddt_V; ddt_w];

end

%change properties of last curve in current figure
%Examples:
%     setcurve('color','red')
%     setcurve('color','green','linestyle','--')
%Type  help plot  to see available colors and line styles 
function setcurve(varargin)
h=get(gca,'children');
set(h(1),varargin{:})
end
 