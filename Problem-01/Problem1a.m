clear 
%Problem 1a generates a set of numbers within a box

%initalizing variables
N=1000; L=25;

%Building the random points
pts=rand(N,3);
pts=pts*L;

%Seperating the points into their x, y, and z components
x=pts(:,1); y=pts(:,2); z=pts(:,3);

%Plot of the points
plot3(x,y,z,'k.')