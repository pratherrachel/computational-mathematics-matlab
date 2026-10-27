clear
%%
%Problem 7a generates the DL triangulation of the random points generated
%using the algorthim discussed in class.

%This part just builds the random points needs for the triangulation

%initalizing variables
N=1000; L=100;  r=1;
i=1;    d=0; dist=0;

%Setting starting point
pt=rand(1,2)*L;   %random starting point

%Seperating the point into the x and y components
x=pt(:,1); y=pt(:,2);

%Loop to check for points that satisfy conditions of problem
while i<N
    xt=rand(1)*L;
    yt=rand(1)*L;
    d=((x-xt).^2)+((y-yt).^2);
    if d>=r^2   %Checks for min distance between the points
        x=[x; xt];
        y=[y; yt];
        i=i+1;  %Increases the counter to ensure we get N points
    end
end

%Beginning the triangulation
pts=[x(:),y(:)];
trivect=[];

for i=1:N-2
    for j=i+1:N-1
        for k=j+1:N
            keep=1;
            m1=(pts(i,1)-pts(j,1))/(pts(j,2)-pts(i,2));
            m2=(pts(j,1)-pts(k,1))/(pts(k,2)-pts(j,2));
            x0=(pts(i,2)-pts(k,2)+m2*(pts(j,1)+pts(k,1))-m1*(pts(i,1)+pts(j,1)))/(2*(m2-m1));
            y0=m1*(x0-(pts(i,1)+pts(j,1))/2)+(pts(i,2)+pts(j,2))/2;
            r=(pts(i,1)-x0)^2+(pts(i,2)-y0)^2;
            for h=1:N
                if h==i || h==j || h==k
                    continue
                end
                dist=((pts(h,1)-x0)^2+(pts(h,2)-y0)^2);
                if dist <= r
                    keep=0;
                    break
                end
            end
            if keep==1
                trivect=[trivect;i,j,k];
            end
        end
    end
end

%Plot of the triangulation
figure(1)
triplot(trivect,x,y,'k');
%text(x,y,string(1:N),'VerticalAlignment','top','HorizontalAlignment','left')
