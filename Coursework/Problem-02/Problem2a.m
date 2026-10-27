clear

%Problem 2a takes a set of random variates and generates a normal
%distribution of random variates using the central limit theorem
%initalizing variables
N=10000; %number of total random variates
m=100;   %number of sample random variates
x=(N:1);    %defining x to be an N by 1 vector

for i=1:N       %outer loop to get N values for x
    xT=(m:1);   %definging xT to be an m by 1 vector
    for j=1:m   %inner loop to get m sample points and their sum
        xT=[xT;rand()]; %random sample points
        Sum=sum(xT);    %sum of the random sample points
    end
    x=[x; Sum/sqrt(m)]; %calculting the value of x
end

%Plot of x to see if it is approximates a normal distribution
%histogram(x)
histfit(x)

