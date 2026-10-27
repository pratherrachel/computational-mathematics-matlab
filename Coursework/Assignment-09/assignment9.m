clear variables
close all
clc

load test.mat
load train.mat

%Building the matrix from the train and test data
x=[train0;train1;train2;train3;train4;train5;train6;train7;train8;train9];

Y=[test0;test1;test2;test3;test4;test5;test6;test7;test8;test9];

%Performing PCA on X, the training portion of the file
X=double(x);
X=X';
Xmean=mean(X,2);
tX=transpose(X-Xmean);
[eVec,eVal]=eig(cov(tX));
coeff=eVec(:,end:-1:end-9);
score=tX*coeff;

%Working on the testing part of the data
Y=double(Y);
L = length(X);
comp = 10; % number of components
correct = 0;
count=0; 

for index=1:100 % test writing

    % Only take principal components
    score = score(:,1:comp);
    coeff = coeff(:,1:comp);

    % Find minimal distance
     dist = zeros(L,1);

    % Decompose test writing into components
    testY = Y(index,:) - Xmean';
    scoreTest = testY*coeff;

    count=count+1;  

        for i=1:L
            dist(i) = sum((score(i,:)-scoreTest).^2);
        end
    [t,loc] = min(dist);

    %figure(1)
    %subplot(1,2,1)
    %imshow(uint8(Y(index)))
    %subplot(1,2,2)
    %imshow(uint8(X(loc)))

        if floor((loc-1)/100) == floor((index-1)/10)
            disp('Correct!')
            correct = correct + 1;
        else
            disp('Wrong!')
        end

end

disp(correct/count)