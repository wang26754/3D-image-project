% calculates cost volume out of two images
% Syntax: [CostL, CostR] = calculate_cost(L, R, maxdisp);
%
% Where:
% CostL - Cost volume assocuiated with Left image
% CostR - Cost volume assocuiated with Right image
% L, R - Left and Right input images
% mindisp, maxdisp - parameters, limiting disparity 
%
% Algorithm hints:
% for disp from 0 to maxdisp
%   CostL(y,x,disp) = |L(y,x,:)-R(y,x-disp,:)| 
%   CostR(y,x,disp) = |R(y,x,:)-L(y,x+disp,:)| 


%function [CostLR, CostRL] = calculate_cost(L, R, maxdisp)
function [CostL, CostR] = calculate_cost(L, R, maxdisp)
    L = double(L);
    R = double(R);
    [height, width, ~] = size(L);
    
    CostL = ones(height, width, maxdisp + 1) * inf;
    CostR = ones(height, width, maxdisp + 1) * inf;
    
    for disp = 0:maxdisp
        for y = 1:height
            for x = 1+disp:width
                diff = abs(L(y,x,:) - R(y,x-disp,:));
                CostL(y,x,disp+1) = sum(diff);
                CostL(y,x,disp+1) = min(CostL(y,x,disp+1), 150);
            end
            for x = 1:width-disp
                diff = abs(R(y,x,:) - L(y,x+disp,:));
                CostR(y,x,disp+1) = sum(diff);
                CostR(y,x,disp+1) = min(CostR(y,x,disp+1), 150);
            end
        end
    end
end






