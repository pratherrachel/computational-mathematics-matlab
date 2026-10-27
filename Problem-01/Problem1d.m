clear

%Problem 1d generates a set of numbers that lie on the surface of a 3D
%sphere of radius (R) with at least the unity distance between them.

%initalizing variables
N=1000;  R=10;        u=1;
S=0;    DotProd=0;   CenAng=0;
i=1;

%Building the starting point
Stheta=rand(1)*2*pi;
Sphi=rand(1)*2*pi;

x=R*sin(Stheta)*cos(Sphi);
y=R*sin(Stheta)*sin(Sphi);
z=R*cos(Stheta);

%Loop to check for points that satisfy conditions of problem
while i<N
        thetaTemp=rand(1)*2*pi;
        phiTemp=rand(1)*2*pi;

        xT=R*sin(thetaTemp)*cos(phiTemp);
        yT=R*sin(thetaTemp)*sin(phiTemp);
        zT=R*cos(thetaTemp);

        DotProd=(x.*xT)+(y.*yT)+(z.*zT);
        CenAng=acos(DotProd./(R^2));
        S=R.*CenAng;
        if S>=u   %Checks for min distance between the points
            x=[x; xT];
            y=[y; yT];
            z=[z; zT];
            i=i+1;  %Increases the counter to ensure we get N points
        end
end

%Plot of the points
plot3(x,y,z,'k.')