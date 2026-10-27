clear
%%
%Problem 9a and b considers a circle and chooses two random points on the
%circumference to form a chord. Here, the distance of the chord lengths is
%at least half of the radius. The plots the probability distrubution of the
%results

a=10;

% Set the minimum distance between the center and the chord to be 
% half of the radius
min=a/2;
n=1000;

% Generate a set of random points on the circumference of the circle
theta=2*pi*rand(1,n);
x=a*cos(theta);
y=a*sin(theta);

% Initialize variables to keep track of the chordal lengths
cLengths=[];

% Loop through all pairs of points to calculate the chordal lengths
parfor i=1:n
    for j=i+1:n
        % Calculate the distance between the center of the circle and the 
        % chord
        a1=x(i);    a2=y(i);    b1=x(j);    b2=y(j);
        m1=(b2-a2)/(b1-a1);     m2=(a1-b1)/(b2-a2);
        p1=(a1*m1-a2)/(m1-m2);  p2=m2*p1;
        dist=sqrt((p1)^2+(p2)^2);
        % If the distance is greater than or equal to the minimum distance, 
        % add the chordal length to the list
        if dist>=min
            cLength=sqrt((a1-b1)^2+(a2-b2)^2);
            cLengths=[cLengths cLength];
        end
    end
end

% Plot the distribution of chordal lengths
figure(1)
[count,bins]=histcounts(cLengths);
histogram('BinEdges',bins,'BinCounts',count);

%% 
clear
%Problem 9c considers a ellipse and chooses two random points on the
%circumference to form a chord. Here, the distance of the chord lengths is
%at least half of the radius.

a=10;
b=20;

% Set the minimum distance between the center and the chord to be 
% half of the radius
min=a/2;
n=1000;

% Generate a set of random points on the circumference of the circle
theta=2*pi*rand(1,n);
x=a*cos(theta);
y=b*sin(theta);

% Initialize variables to keep track of the chordal lengths
cLengths=[];

% Loop through all pairs of points to calculate the chordal lengths
parfor i=1:n
    for j=i+1:n
        % Calculate the distance between the center of the circle and the 
        % chord
        a1=x(i);    a2=y(i);    b1=x(j);    b2=y(j);
        m1=(b2-a2)/(b1-a1);     m2=(a1-b1)/(b2-a2);
        p1=(a1*m1-a2)/(m1-m2);  p2=m2*p1;
        dist=sqrt((p1)^2+(p2)^2);
        % If the distance is greater than or equal to the minimum distance, 
        % add the chordal length to the list
        if dist>=min
            cLength=sqrt((a1-b1)^2+(a2-b2)^2);
            cLengths=[cLengths cLength];
        end
    end
end

% Plot the distribution of chordal lengths
figure(2)
[count,bins]=histcounts(cLengths,'Normalization','probability');
histogram('BinEdges',bins,'BinCounts',count);
