% Consistency check between two disparity maps (left & right)
% Performs per-slice filtering of input cost volume
%
% Syntax:  = consistency_check(dispL, dispR)
% dispL / dispR - input disparity map from left and right perspectives
% invalidPixelsL / invalidPixelsR - binary mask with inconsistent pixels marked with ones
function [invalidPixelsL, invalidPixelsR] = consistency_check(dispL, dispR, threshold)
    invalidPixelsL = zeros(size(dispL));
    invalidPixelsR = zeros(size(dispR));
    for y = 1:size(dispL, 1)
        for x = 1:size(dispL, 2)
            dL = dispL(y, x);
            xR = x - dL; 
            if xR >= 1 && xR <= size(dispR, 2)
                dR = dispR(y, xR);
                if abs(dL - dR) > threshold
                    invalidPixelsL(y, x) = 1; 
                end
            else
                invalidPixelsL(y, x) = 1; 
            end
        end
    end
    for y = 1:size(dispR, 1)
        for x = 1:size(dispR, 2)
            dR = dispR(y, x);
            xL = x + dR; 
            if xL >= 1 && xL <= size(dispL, 2)
                dL = dispL(y, xL);
                
                if abs(dL - dR) > threshold
                    invalidPixelsR(y, x) = 1; 
                end
            else
                invalidPixelsR(y, x) = 1; 
            end
        end
    end
end




    
    
