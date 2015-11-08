% This is to illustrate diffusion of particles (i.e., Brownian motion)
clear
N = 1000; %number of particles
K = 100; %number of time steps
y = [-100:100]/5;
D = 1/2;
binc = [-20:20];
%Record the movie
%mov = avifile(’parsim_one.avi’);
%moviename = [’MOVIE.qt’]
%MakeQTMovie(’start’, moviename)
ksk = 5;
x = zeros(K,1);
X = x;
dt = .1;
t = 0;
var(1) = 0;
T(1) = 0;
k = 1;
diff = sqrt(dt);
est1 = 0;
est2 = 0;
for j = 2:N
    x = x + diff*randn(K,1);
    X = [X,x];
    var(j) = std(x)^2;
        t = t +dt;
        est1 = est1 + t^2;
        est2 = est2 + t*var(j);
    T(j) = t;

    if (fix(j/ksk)*ksk==j)
    figure(1)
    hist(x,binc)
    hold on
p = K*exp(-y.^2/(4*D*t))/sqrt(4*pi*D*t);
plot(y,p,'r','linewidth',2)
hold off
    axis([-20 20 0 45])
% F(j) = getframe;
% %this command saves files for later making a movie with qt-7
    saveas(gcf, sprintf('./movie_files/frame%g',j/ksk),'jpeg')
%
% mov = addframe(mov,F(j));
%MakeQTMovie(’addframe’,’moviename’)
%MakeQTMovie(’quality’, 1.0)
    pause(0.01)
    end
end
%mov = close(mov);
%MakeQTMovie(’finish’,’moviename’)
figure(3)
sl = est2/est1;
plot(T,var,T,sl*T,'--' )
hold off