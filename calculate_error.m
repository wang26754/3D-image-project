% calculates percentage of bad pixels
% (pixels, with error larger than unity)
% 
% Syntax: [err] = calculate_error(Disp, GT)
% Disp - disparity map
% GT - ground truth to be compared against


function [err] = calculate_error(Disp, GT)
    
    bad_pixels = abs(Disp - GT) > 1;
   
    err = sum(bad_pixels(:)) / numel(Disp);
end

