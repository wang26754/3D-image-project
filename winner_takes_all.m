% Finds disparity map from Cost Volume
% Syntax: [Disp] = winner_takes_all(Cost)
% Hints:
% for each (y,x) find the z (the layer) with the lowest cost value
% (note that matlab coordinates starts from 1, hence we need substract that unity)

function [Disp] = winner_takes_all(Cost)
    [~, Disp] = min(Cost, [], 3);
   
    Disp = Disp - 1;
end
