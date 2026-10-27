clear
%%
%This is the traveling salesman problem. The task is to calculate the
%min distance needed to travel between London, Amsterdam, Paris, Rome,
%Prague, Zurich, Berlin, Vienna, Copenhagen, Brussels and Lisbon.

%This piece covers parts a and b takes a user created distance matrix and
% uses it to calculate the mmin distance. Here B contains information for
% Madrid which will be needed for later parts.

A=readmatrix('DisMatrixOne.xlsx','Range','D3:N13');
B=readmatrix('DisMatrixTwo.xlsx','Range','D3:O14');

n=length(A); %total number of cities in the first dist. matrix
m=length(B); %total number of cities in the second dist. matrix

PofA=perms(1:n); %calculates total permutatins for value of n
PofB=perms(1:m); %calculates total permutations for value of m

%calculating min distance

min=20000;
[row,coln]=size(PofA);
route=[];

for i=1:row
    dist=0;
    for j=1:coln-1
        ind1=PofA(i,j);
        ind2=PofA(i,j+1);
        dist=sum(A(ind1,ind2))+dist;
    end
    if dist<min
        min=dist;
        route=PofA(i,:);
        continue
    end
end
%% 

%Part c here assumes that London is your starting point and then calculates
%the min distance

lMin=20000;
lRoute=[];

for k=1:row
    lDist=0;
    if PofA(k)~=1
        continue
    end
    for g=1:coln-1
        lInd1=PofA(k,g);
        lInd2=PofA(k,g+1);
        lDist=sum(A(lInd1,lInd2))+lDist;
    end
    if lDist<lMin
        lMin=lDist;
        lRoute=PofA(k,:);
        continue
    end
end
%% 

%Part d adds in the city of Mardrid to the calculations from Parts a, b,
%and c above

Min=20000;
[Row,Coln]=size(PofB);
Route=[];

for e=1:Row
    Dist=0;
    for f=1:Coln-1
        Ind1=PofB(e,f);
        Ind2=PofB(e,f+1);
        Dist=sum(B(Ind1,Ind2))+Dist;
    end
    if Dist<Min
        Min=Dist;
        Route=PofB(e,:);
        continue
    end
end

LMin=20000;
LRoute=[];

for x=1:Row
    LDist=0;
    if PofB(x)~=1
        continue
    end
    for y=1:Coln-1
        LInd1=PofB(x,y);
        LInd2=PofB(x,y+1);
        LDist=sum(B(LInd1,LInd2))+LDist;
    end
    if LDist<LMin
        LMin=LDist;
        LRoute=PofB(x,:);
        continue
    end
end

disp(min);
disp(lMin);
disp(Min);
disp(LMin);