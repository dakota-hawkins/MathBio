% diffusion on a grid using Gillespie

% create a vector of numbers
N = 50; % number of boxes
U = zeros(N,1);
K = 400; % number of particles
U(N/2) = K;% all particles initially in the central box
alpha = 1.000001; % time constant
M = 2000;  % number of time steps

xpm = [ones(1,N); -ones(1,N)];
 xpm(2,1) = 1;
 xpm(1,N) = -1;
 sc = [1;2*ones(N-2,1);1];
 t = 0;
n = [1:N];
for j = 1:M
    for jj = 1:10
    R = rand(3,1);
    rates = alpha*sc.*U;
    rt = cumsum(rates);
    c = rt/rt(N);
    ndx = min(find(R(1)<=c));
       U(ndx) = U(ndx) -1;
       pm = (R(2) < 0.5) + 1;
       
       pdx = ndx+xpm(pm,ndx);
       U(pdx) = U(pdx) +1 ;
       dt = -log(R(3))/rt(N);
       t = t + dt;
    end
       figure(1)
       plot(n,U/K,'*')
       axis([1 N 0 1])
       pause(0.001)
end


 
 
    