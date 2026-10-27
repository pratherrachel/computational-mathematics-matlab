% Solution to (unassigned) Exploration 7.2.2,
%   useful for Exploration 9.1.5
% makelagrange - given vector x of interpolation points, this
%                function constructs the Lagrange polynomials
%                for these points and returns their coefficients
%                in a matrix, one polynomial per row
function L=makelagrange(x)
% retrieve length of vector
n=length(x);
% force x to be a row vector
x=reshape(x,1,n);
% empty n-by-n matrix for Lagrange polynomials
L=zeros(n,n);
% identity matrix
I=eye(n);
for j=1:n
    % y-values = jth row of I
    % p(x(i))=1 if i=j, p(x(i))=0 otherwise
    p=polyfit(x,I(j,:),n-1);
    % store coefficients in jth row of L
    L(j,:)=p;
end
