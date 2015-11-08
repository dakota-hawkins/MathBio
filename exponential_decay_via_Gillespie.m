% exponential decay of particles via Gillespie algorithm

alpha = 0.001;  % rate of decay
N = 50; % initial number of particles
K = 100 %total number of trials
 
t = zeros(N+1,K);
R = rand(N,K);
for j = 1:N
    n = N-j+1;
    
    dt = -log(R(j,:))/(alpha*n);
    t(j+1,:) = t(j,:) + dt;
    
    end
    s = 1;
 tt = reshape([t(:,s)';t(:,s)'],2*(N+1),1);
  nn = reshape([ N:-1:0; N:-1:0],2*(N+1),1);

 figure(1)
 plot(tt(2:end),nn(1:end-1,1),tt,N*exp(-tt),'--')
 
figure(2)
 semilogy(tt,nn)
 
 
 figure(3)
  
 hist(t(N,:),20)
 
 
 
 mean(t(N,:))
 E = sum(1./[1:N])
 

 

 
 
    