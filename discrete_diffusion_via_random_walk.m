% diffusion on a grid via a random walk

% create a vector of numbers
N = 1; % number of objects
X = zeros(N,1); % initial position


alpha = 0.30; % Probability of movement
beta = 0.70
M = 100;  % number of time steps
XS = zeros(N,M);
c = [alpha,beta];

% Specify the movment vector
xm(1) = 1;
xm(2) = -1;
xm(3) = 0;

for j = 1:M
    R = rand(N,1);
    for k = 1:N
       ndx= min(find(R(k)<=c));
       X(k) = X(k) + xm(ndx);
       XS(:,j) = X;
    end
    
    figure(1)
  hist(X,[-20:20])
  axis([-25 25 0 300])
  pause(0.1)
  
end
figure(2)
plot(XS')


 
 
    