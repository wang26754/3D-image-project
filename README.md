Implement the local color-weighted disparity estimation algorithm and evaluate its performance on a set of stereo image pairs. The algorithm includes the following steps:
1. Cost function calculation
2. Cost aggregation based on three methods
a. Box filtering
b. Gaussian filtering
c. Local color-weighted filtering (guided filter)
3. ‘Winner-takes-all’ disparity estimation and quality evaluation
4. Detection of occlusions 
5. Computation of confidence values for disparity estimates 
6. Post-filtering to tackle occlusions and bad pixels 
7. Implementation of cross-bilateral filter-based aggregation
