clear

%Problem 2c generates the Box-Muller algorithm with a center at x0 and the
%root-mean-square width of sigma

%initalizing variables
N=1000; %Number of random varibles
sigma=.5;
x0=5;

U1=rand(N,1);    %first vector of random variables
U2=rand(N,1);    %second vector of random variables

%Applying Box-Muller algorithm
X=sqrt(-2.*log(U2)).*cos(2.*pi.*U1); %log returns ln in MATLAB
Y=sqrt(-2.*log(U2)).*sin(2.*pi.*U1);

%Applying sigma and x0
X=sigma.*X+x0;
Y=sigma.*Y+x0;

plot(X,Y,'b.',U1,U2,'r.')
title('Uniformly Distributed Random Variates vs. Box Muller Algorithm')
legend('Box Muller','Uniformly Distributed')
axis equal