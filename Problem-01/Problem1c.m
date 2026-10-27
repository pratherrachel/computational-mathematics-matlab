clear

%Problem 1c generates a set of numbers that lie on the surface of a 3D
%sphere of radius (R).

%initalizing variables
N=1000; R=10;

%Building the random points
theta=rand(N,1)*2*pi;
phi=rand(N,1)*2*pi;

%Getting points of the sphere
x(:,1)=R*sin(theta).*cos(phi);
y(:,1)=R*sin(theta).*sin(phi);
z(:,1)=R*cos(theta);

%Plot of the points
plot3(x,y,z,'k.')