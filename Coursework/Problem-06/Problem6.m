clear
%%
%Problem 6a generates a stereographic projection of the points on the upper
%(north) hemishphere with respect to the north (0,0,1) ib rge extended x-y
%plane.

%initalizing variables
N=1000; R=1; x(:,1)=1:N; y(:,1)=1:N;

%Building the random points
theta=rand(N,1)*2*pi;
phi=rand(N,1)*2*pi;

%Getting points of the sphere
x1(:,1)=R*sin(theta).*cos(phi);
y1(:,1)=R*sin(theta).*sin(phi);
z1(:,1)=R*cos(theta);

%Constructing the stereographic projection
for i=1:N
    x(i)=-x1(i)/(z1(i)-1);
    y(i)=-y1(i)/(z1(i)-1);
end

%Plot of the points
plot(x,y,'.k')


%%
clear
%Problem 6b finds the radius of the circle produce from a stereographic
%projection with a constant polar angle theta.

%initalizing variables
N=1000; R=1; x(:,1)=1:N; y(:,1)=1:N;

%Building the random points
theta=pi/4;
phi=rand(N,1)*2*pi;

%Getting points of the sphere
x1(:,1)=R*sin(theta).*cos(phi);
y1(:,1)=R*sin(theta).*sin(phi);
z1=R*cos(theta);

%Constructing the stereographic projection
for i=1:N
    x(i)=-x1(i)/(z1-1);
    y(i)=-y1(i)/(z1-1);
end

radius=sqrt(((x(1)-0)^2)+((y(1)-0)^2));

%Plot of the points
plot(x,y,'.k')

%% 
clear 
%Problem 6c a sphere from random points

%initalizing variables
N=1000; L=10; x(:,1)=1:N; y(:,1)=1:N; z(:,1)=1:N;

%Building the random points
pts=rand(N,2)*2-1;
pts=pts*L;

%Seperating the points into their x and y components
x1=pts(:,1); y1=pts(:,2);

for i=1:N
    z(i)=abs((x1(i)^2+y1(i)^2-1)/(x1(i)^2+y1(i)^2+1));
    x(i)=x1(i)*(z(i)-1);
    y(i)=y1(i)*(z(i)-1);
end

plot3(x,y,z,'.k')
