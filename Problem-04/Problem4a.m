clear
%%
%Problem 4a generates a set of random points within a box that have a set 
% min distance (r) between them. From there, the code with generate the
% first neighbor map of the set of N random points.

%initalizing variables
N=1000; L=28;    r=2;
i=1;    d=0;     R=3;
D=0;    Map(:,1)=1:N; 
iter=0;

%Setting starting point
pt=rand(1,3)*L;   %random starting point

%Seperating the point into the x, y, and z components
x=pt(:,1); y=pt(:,2); z=pt(:,3);

%Loop to check for points that satisfy conditions of problem
while i<N
    xt=rand(1)*L;
    yt=rand(1)*L;
    zt=rand(1)*L;

    d=((x-xt).^2)+((y-yt).^2)+((z-zt).^2); %calculating distance
    if (d>=r^2)   %Checks for min distance between the points
        x=[x; xt];
        y=[y; yt];
        z=[z; zt];
        i=i+1;  %Increases the counter to ensure we get N points 
    end
end

pts=[x,y,z];    %combines x, y and z into one vector

%loop that checks for neighbors
for k=1:N   %Outer loops checks if the kth point has any neighbors
    ptsTemp1=pts(k,:);
    for j=1:N   %Checks the jth point to see if it is a neighbor of k
        ptsTemp2=pts(j,:);
        D=pdist2(ptsTemp1,ptsTemp2,"euclidean"); %calculates distance
        if (D<=R) && (D~=0) % If j and k are neighbors this is true
           iter=iter+1;
           Map(k,iter+2)=j;   %Returns the index of j to get k's neighbor
        end
    end
    Map(k,2)=iter;  %stores the number of first neighbors before resetting
    iter=0; %Resets the index counter
end

%%

%Problem4b starts here
M=length(Map);
Map2(:,1)=1:M;
Map2=[Map2, zeros(M,2)];

for i=1:M
    for j=3:size(Map,2)
        if Map(i,j)~=0
            neighbor=Map(i,j);
        end
        for k=3:size(Map,2)
            neighbor2=Map(neighbor,k);
            duplicates = ismember(neighbor2, [Map2(i,3:end-1),Map(i,3:end)]);
            if neighbor2==0 || duplicates==1 || neighbor2==i
                continue
            end
            if Map2(i, end)~=0
                Map2 = [Map2, zeros(M, 1)];
            end
            for l=3:size(Map2,2)
                if Map2(i,l)==0
                    Map2(i,l)=neighbor2;
                    Map2(i,2)=Map2(i,2)+1;
                    break
                end
            end
        end
    end
end
%%
