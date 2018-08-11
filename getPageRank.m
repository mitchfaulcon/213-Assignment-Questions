function [P,G] = getPageRank(network, weight)
% This function calculates the PageRank vectors, given a list of
% network adjacencies
%
% Inputs:   network = An Nx2 numeric matrix, with nodes in the first
%                     entry of each row, and to nodes in the second entry.
%                     We assume this is numeric and that there are no
%                     missing numerical indices.
%           weight  = Weight applied to the Markov chain part of the
%                     Google matrix (as opposed to the random part).
%
% Outputs:  P = Nx1 vector containing the PageRank weights. This is a
%               valid probability vector.
%           G = NxN matrix, the resulting transiton matrix used to
%               calculate P.
%
% Author:   Mitchell Faulconbridge
% Date:     29/03/2018

[rows,~] = size(network);

% Find the size of the required transition matrix
n = max(max(network));

% Create initial transition matrix
initial = zeros(n);

% Array for no. of nodes adjacent to each node
adjacentNodes = zeros(1,n);

for i=1:rows
    
    currentNode = network(i,1);
    connectingNode = network(i,2);
    
    % Increase corresponding index in adjacent nodes array
    adjacentNodes(1,currentNode) = adjacentNodes(1,currentNode)+1;
    
    % Set appropriate index in transition matrix to 1
    initial(connectingNode,currentNode) = 1;
    
end

% Divide each column by the no. of adjacent nodes to get probabilities
initial = initial./adjacentNodes;

% If a node is an absorbing state, replace corresponding column with
% vector of equal probability
for i=1:n
    if isnan(initial(1,i))
        initial(:,i) = 1/n;
    end
end

% Create matrix populated with equal probabilities
K(1:n,1:n) = 1/n;

% Create final Google Matrix
G = weight.*initial + (1-weight).*K;

% Rearrange final transition matrix to Q*pi=0
Q = G-eye(n);
Q = [Q,zeros(n,1)];

% Drop one row and enforce sum of probabilites = 1
Q(n,:) = 1;

% Solve to get probabilities
Q = rref(Q);
P = Q(:,n+1);

end

