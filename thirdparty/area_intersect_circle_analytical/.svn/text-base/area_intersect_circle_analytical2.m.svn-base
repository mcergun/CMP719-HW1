function M = area_intersect_circle_analytical2(varargin)
% Compute the overlap area between 2 circles defined in an array.
% Computation is vectorized, and intersection area are computed an
% analytical way.
%   
% Input: Circles data presented in an array G of three columns.
%        G contains parameters of the n circles
%           . G(1:n,1) - x-coordinate of the center of circles,
%           . G(1:n,2) - y-coordinate of the center of circles,
%           . G(1:n,3) - radii of the circles 
%        Each row of the array contains the information for one circle.
% 
%        Input can also be provided in three different vectors. These
%        vectors can be row or column vectors. The 1st one corresponds to
%        x-coordinate of the center of circles, the 2nd one to the
%        y-cooridnate and the 3rd one to the radii of the circles.
% 
% 
% Output: Square matrix M(n,n) containing intersection areas between
% circles
%         M(i,j) contains the intersection area between circles i & j
%         By definition, M(i,i) corresponds to the area of circle i.
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For 2 circles i & j, three cases are possible depending on the distance
% d(i,j) of the centers of the circles i and j.
%   Case 1: Circles i & j do not overlap, there is no overlap area M(i,j)=0;
%             Condition: d(i,j)>= ri+rj
%             M(i,j) = 0;
%   Case 2: Circles i & j fully overlap, the overlap area has to be computed.
%             Condition: d(i,j)<= abs(ri-rj)
%            M(i,j) = pi*min(ri,rj).^2
%   Case 3: Circles i & j partially overlap, the overlap area has to be computed
%            decomposing the overlap area.
%             Condition: (d(i,j)> abs(ri-rj)) & (d(i,j)<(ri+rj))
%            M(i,j) = f(xi,yi,ri,xj,yj,rj)
%                   = ri^2*arctan2(yk,xk)+ ...
%                     rj^2*arctan2(yk,d(i,j)-xk)-d(i,j)*yk
%             where xk = (ri^2-rj^2+d(i,j)^2)/(2*d(i,j))
%                   yk = sqrt(ri^2-xk^2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Guillaume JACQUENOT
% guillaume.jacquenot@gmail.com
% 2007_06_08

% Some explanations, comments were added. Input arguments are detailed.
% Verifications of input arguments are performed.
% The number of calculations has been divided by two.
 
switch nargin
    case 0
        % Performs an example
        % Creation of 5 circles
        x = [0,1,5,3,-5];
        y = [0,4,3,7,0];
        r = [1,5,3,2,2];
    case 1
        temp = varargin{1};
        x = temp(:,1);
        y = temp(:,2);
        r = temp(:,3);
    case 3
        x = varargin{1};
        y = varargin{2};
        r = varargin{3};
    case 4
        x = varargin{1};
        y = varargin{2};
        r = varargin{3};
        sel = varargin{4};
    otherwise
        nargin
        error('The number of arguments must 0, 1, 3, or 4')
end

% Inputs are reshaped in 
size_x = numel(x);
size_y = numel(y);
size_r = numel(r);

x = reshape(x,size_x,1);
y = reshape(y,size_y,1);
r = reshape(r,size_r,1);

% Checking if the three input vectors have the same length
if (size_x~=size_y)||(size_x~=size_r)
    error('Input of function must be the same length')
end

% Computation of distance between all circles, which will allow to
% determine which cases to use.
D = sqrt((x - x(sel)).^2 + (y - y(sel)).^2);

sumR = r + r(sel);
difR = abs(r - r(sel));

% Creating the resulting vector
M = zeros(length(x), 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Case 2: Circles i & j fully overlap
% One of the circles is inside the other one.
C1    = D <= difR;
if nnz(C1) > 0
    M(C1) = pi * min(r(C1), r(sel)).^2;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Case 3: Circles i & j partially overlap
% Partial intersection between circles i & j
C2 = (D > difR) & (D < sumR);
if nnz(C2(:)) > 0
    % Computation of the coordinates of one of the intersection points of the
    % circles i & j
    Xi(C2) = (r(C2).^2 - r(sel).^2 + D(C2).^2)./(2 * D(C2));
    
    Yi(C2) = sqrt((r(C2).^2)' - Xi(C2).^2);
    % Computation of the partial intersection area between circles i & j
    M(C2) = (r(C2).^2)' .* atan2(Yi(C2), Xi(C2))+...
        r(sel)^2 * atan2(Yi(C2), (D(C2)' - Xi(C2)))-...
        (D(C2)') .* Yi(C2);
end
M(sel) = pi * r(sel)^2;  


