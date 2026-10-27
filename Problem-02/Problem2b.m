clear

%Problem 2b uses the Box-Muller algorithm to generate a normal distribution
%and compares with the results from 2a.

%initalizing variables
N=1000; %Number of random varibles

U1=rand(N,1);    %first vector of random variables
U2=rand(N,1);    %second vector of random variables

%Applying Box-Muller algorithm
X=sqrt(-2.*log(U2)).*cos(2.*pi.*U1); %log returns ln in MATLAB
Y=sqrt(-2.*log(U2)).*sin(2.*pi.*U1);

subplot(2,2,[1,2]);
plot(X,Y,'b.',U1,U2,'r.')
title('Uniformly Distributed Random Variates vs. Box Muller Algorithm')
legend('Box Muller','Uniformly Distributed')
axis equal

subplot(2,2,3)
histfit(X)
title('Histogram of X-Values from Box Muller')

subplot(2,2,4)
histfit(Y)
title('Histogram of Y-Values from Box Muller')