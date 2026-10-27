clear all
%Problem 3b generates random vectors on the surface of a unit hypersphere
%for d=10 using uniformly distributed random numberes from -1:1 in a
%hypercube. Then the acceptance ratio will be calculated and then compared
%to the results in 3a

%initalizing variables
n=10;         %user choosen dimension 
L=2;          %user choosen length
r=1;          %user choosen radius
m=20000;     %max number of random vectors
Kept=[];      %preallocation of kept vectors
iter=0;       %starting count of vectors less than r

for i=1:m
    xI=(n:1);   %defines the size of XI
    for j=1:n
        xI=[xI, rand()*2-1];
    end

    d=sqrt(sum(xI.*xI));    %Calculates the distance from the origin of xI

    if d <=r                %Determins if distance if less than r
        Kept=[Kept;xI];     %Stores the vectors that fit critera above
        iter=iter+1;        %Counts how many fit
    end
end

alpha=iter/m %calculates the ratio