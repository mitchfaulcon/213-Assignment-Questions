function [L,U,P] = myLU(matrix)
% This function performs LU decompostition with
% partial pivoting on a square matrix
% Author: Mitchell Faulconbridge
% Date: 12/3/18

% Get matrix dimensions
[rows,cols]=size(matrix);

% Check matrix is square
if (rows==cols)
    
    % Set up appropriate initial L,U, and P
    U=matrix;
    L=eye(rows);
    P=eye(rows);
    
    % Loop through rows
    for i=1:rows-1
        
        % Find best row to use as pivot row
        column=U(i:rows,i);
        [~,index]=max(abs(column));
        index=index-1+i;
        % Switch rows in L
        if (i>1)
            tempRow=L(i,1:i-1);
            L(i,1:i-1)=L(index,1:i-1);
            L(index,1:i-1)=tempRow;
        end
        % Switch pivot row into pivot row position
        tempRow=U(i,:);
        U(i,:)=U(index,:);
        U(index,:)=tempRow;
        
        % Update permutation matrix
        tempRow=P(i,:);
        P(i,:)=P(index,:);
        P(index,:)=tempRow;
        
        % update lower triangular matrix
        L(i+1:rows,i)=U(i+1:rows,i)/U(i,i);
        
        % Perform row operation
        for j=i+1:rows
            U(j,:)=U(j,:)-((U(j,i)/U(i,i))*U(i,:));
        end
    end
    
else
    % Matrix isn't square so do nothing
    disp('Matrix is not square')
end
end

