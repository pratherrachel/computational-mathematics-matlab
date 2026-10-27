clear

%Problem 1b generates a set of numbers within a box that have a set min
%distance (r) between them

%initalizing variables
N=1000; L=25;  r=1;
i=1;    d=0;

%Setting starting point
pt=rand(1,3)*L;   %random starting point

%Seperating the point into the x, y, and z components
x=pt(:,1); y=pt(:,2); z=pt(:,3);

%Loop to check for points that satisfy conditions of problem
while i<N
    xt=rand(1)*L;
    yt=rand(1)*L;
    zt=rand(1)*L;

    d=((x-xt).^2)+((y-yt).^2)+((z-zt).^2);
    if d>=r^2   %Checks for min distance between the points
        x=[x; xt];
        y=[y; yt];
        z=[z; zt];
        i=i+1;  %Increases the counter to ensure we get N points
    end
end

%Plot of the points
plot3(x,y,z,'k.')