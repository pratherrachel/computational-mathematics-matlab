clear

%Problem 3a calculates the volume of a unit hypersphere in d dimensions and
%a hypercube of length 2 to determine the ratio between the two as alpha. 
%Next, it will plot the results as a(d) vs. d

%initalizing variables
d=20;   %user choosen max dimension 
L=2;    %user choosen length
r=1;    %user choosen radius
VCube=0;    %preallocating volume for hypercube
VSphere=0;  %preallocating volume for hypercube
alpha=[];   %Vector to store ratio volume hyperspehe vs hypercube


for n=2:d
    VCube=L^n;  %calculating volume of hypercube

    if rem(n,2)==0  %calculates volume of hypersphere
        N=factorial(n/2);   %volume if n if is even
        VSphere=(pi^(n/2)/N)*r^n;
    else
        m=fix((n/2)+1); %fix rounds value down to nearest integer
        mNum=1;
        for i=1:(m)
            mNum=(2*i-1)*mNum;
        end
        N=mNum/2^m;
        VSphere=(pi^(n/2)/(N*sqrt(pi)))*r^n;
    end

    alpha=[alpha; VSphere/VCube];  %calculates ratio of hypersphere vs hypercube
end

N=2:d;
plot(N,alpha)