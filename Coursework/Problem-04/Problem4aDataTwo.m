clear
%%
%Problem4aDataTwo generates a set of random points within a box that have 
% a set min distance (r) between them. From there, the code with generate
% the first neighbor map of the set of N random points.

load 216.txt

%initalizing variables
N=length(X216);
R=2.8;
iter=0;
Map(:,1)=1:N;

x=X216(:,1); y=X216(:,2); z=X216(:,3);
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
