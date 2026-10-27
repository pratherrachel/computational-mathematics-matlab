clear
%%
%Problem4aData generates the first neighbor map from a text file that is
%loaded in

load edges.txt

%initalizing variables
N=28;               %number of nodes
e=length(edges);    %number of edges or number of rows in text file
Map(:,1)=1:N;       %predefining the neighbor charts
iter=0;

%first loop to build Map
for i=1:e   %loop checks for the first neighbors
    node=edges(i,1);    %defines the site
    neighbor=edges(i,2);   %defines the first neighbor

    %if statement to set value of prior node
    if i==1
        oldnode=edges(i,1);
    else
        oldnode=edges(i-1,1);
    end

    %if statement to check if the node changes
    if oldnode == node
        iter=iter+1;
    else
        Map(oldnode,2)=iter;
        iter=1;
    end

    Map(node,iter+2)=neighbor;  %stores the neighbors
end

%second loop to finish building Map
for k=1:e
    node=edges(k,2);
    neighbor=edges(k,1);
    for j=3:size(Map,2)
        if Map(node,j)==0
            Map(node,j)=neighbor;
            Map(node,2)=Map(node,2)+1;
            break
        end
    end
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

%%