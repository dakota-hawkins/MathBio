% code to simulate diffusion process via Method of lines
function Diff_sim
 global alpha
alpha = 0.1;  %The time constant
  
 N = 52; %number of cells    
 
 u0 = zeros(N,1);
 u0(N/2) = 1;
 
tstep = 1;
t_end = 50;
 
%specify the output points
tspan = [0:tstep:t_end];

 

[T,S] = ode23(@deRHS,tspan, u0, odeset('maxstep',1));  

figure(1)
for j = 1:length(T)
    plot(S(j,:),'*')
    
    axis([0 N 0 1])
    pause(.1)
end
figure(2)
plot(T,S(:,N/2),T,S(:,fix(N/4)))
xlabel('time','fontsize',16)
ylabel('U','fontsize',16)

 
%the right hand side for ode simulation:
function s_prime=deRHS(t,s)
global alpha
 
      Fu = alpha*(-2*s+[0;s(1:end-1)]+[s(2:end);0]);
s_prime = Fu;

