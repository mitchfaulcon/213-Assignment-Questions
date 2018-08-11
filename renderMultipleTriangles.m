function colArray = renderMultipleTriangles(N, u, v, w, uCol, vCol, wCol)
% This function renders the colours of multiple triangles on a square
% of NxN pixels. Pixels not in any triangle are defaulted to be
% white (1,1,1). We assume triangles are not overlapping.
%
% Inputs:        N = Size of the NxN pixels square to draw on.
%          u, v, w = Mx2 matrix, each row contains the coordinates of
%                    a triangle vertex.
% uCol, vCol, wCol = Mx3 matrix, with each row containing the RGB
%                    (weighted between 0 and 1) colour at the 3 points.
%
% Output: colArray = NxNx3 array, containing the RGB combination for
%                    every pixel, in MATLAB notation of 0...1.
%
% Author:   Mitchell Faulconbridge
% Date:     22/04/2018

% Get number of triangles in inputs and check if input sizes are consistent
[rowU,~]=size(u);
[rowV,~]=size(v);
[rowW,~]=size(w);
[rowColU,~]=size(uCol);
[rowColV,~]=size(vCol);
[rowColW,~]=size(wCol);
assert(rowU==rowV&&rowU==rowW&&rowU==rowColU&&rowU==rowColV&&rowU==rowColW,'Number of triangles in inputs are not consistent');
triangles=rowU;

% Create RGB array, defaulted to white
colArray=ones(N,N,3);

% Loop through for number of triangles
for currentTriangle=1:triangles
    
    % Current triangle colours
    uColCurrent=uCol(currentTriangle,:)';
    vColCurrent=vCol(currentTriangle,:)';
    wColCurrent=wCol(currentTriangle,:)';
    
    % Create homogeneous form of triangle coordinates
    vertexArray=ones(3);
    vertexArray(1:2,1)=u(currentTriangle,:)';
    vertexArray(1:2,2)=v(currentTriangle,:)';
    vertexArray(1:2,3)=w(currentTriangle,:)';
    
    % Get inverse of homogeneous coordinates to use in multiplication
    invVertexArray=inv(vertexArray);
    
    % Get boundaries for triangle
    topRow=min(vertexArray(1,:));
    bottomRow=max(vertexArray(1,:));
    leftCol=min(vertexArray(2,:));
    rightCol=max(vertexArray(2,:));
    
    % Run through for each possible coordinate of triangle
    for row=topRow:bottomRow
        for col=leftCol:rightCol
            
            % Calculate barycentric coordinates from homogeneous
            homogeneousP=[row;col;1];
            barycentricP=invVertexArray*homogeneousP;
            
            % Check if P is within triangle
            if ((barycentricP(1)<=1&&barycentricP(1)>=0)&&...
                    (barycentricP(2)<=1&&barycentricP(2)>=0)&&...
                    (barycentricP(3)<=1&&barycentricP(3)>=0))
                
                % Get colour at P using barycentric coordinates
                colourAtP=barycentricP(1).*uColCurrent+barycentricP(2).*vColCurrent+barycentricP(3).*wColCurrent;
                
                % Set pixel colour in RGB array
                colArray(row,col,:)=[colourAtP(1);colourAtP(2);colourAtP(3)];
            end
        end
    end
end

end