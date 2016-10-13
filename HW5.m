%% Problem 1: detecting the surface of the fly embryo using Ilastik

% Time000000.tif is a big file, the high resolution is not required for
% simply finding the surface of the embryo. Downsample it 4-fold in FIJI
% and save as Time000000_bin4.tif (Hint: use imresize)

% Use Ilastik on this downsampled data set to segment identify the fly 
% embryo in 3D and export as simple segmentation. (Make sure to set axes as
% zxy before starting segmention.)

% Read the segmentation into Matlab and create a binary image containing 
% only the surface pixels (Hint: subtract erosion from solid mask, 
% which may need to be cleaned up).
% Overlay the surface mask on cross section through the middle of the
% embryo in each direction.

% Obtain a list of the XYZ coordinates of the surface pixels.
% (Hint: use regionprops).
% Then shift to the centroid of the embryo.
% Subsample the pointcloud 1:50 by taking regularly spaced points in the 
% XYZ list and also by picking 1/50th of the points randomly.
% What is the difference?
% Visualize the point clouds in 3D.
% Color them by y value.

%% Problem 2: making a mesh using Meshlab

% Save point cloud to obj format:
addpath(scriptPath);
writeVertsToOBJ(XYZ, 'pointCloud.obj'); %this function is provided in the repository

% Download Meshlab and open this file
% It may be useful to turn on view -> Show Layer Dialog in the following.
% Then build a mesh using Poisson surface reconstruction using the 
% following steps:
% 1) Sampling / Poisson disk sampling (use Base Mesh Subsampling)
% 2) Point set / compute normals
% 3) Point set / Poisson surface reconstruction
%
% Save the resulting mesh in .ply format, and read it back into Matlab.

outputMesh = 'embryo.ply';
[vertex, face] = read_ply(outputMesh);%this function is provided in the repository

% Use patch to visualize the mesh with faces and edges in different colors.

%% Problem 3: measuring distance on a surface

% Find a vertex at the anterior or posterior end, and one laterally,
% visualize them 

% Measure the distance between these points four ways:
% 1) in an orthographic projection onto the midsaggital plane (or another
% plane containing the AP axis)
% 2) in an orthographic projection along the anterior-posterior axis
% 3) in 3D
% 4) along the surface

% For 4), first compute the distance of each vertex from
% the anterior tip, as measured along the mesh.

D = perform_fast_marching_mesh(vertex, face, Aidx);
% Note the function perform_fast_marching_mesh is provided in the
% repository but requires some compiled functions. Precompiled versions of
% these are provided that will work on Mac (with 64 bit operating system).
% Either use a computer with this operating system (strongly suggested) or else you will need to
% compile them yourself using the function compile_mex.m that is provided. 


% Then visualize this distance map on the mesh using FaceVertexCData.
% Finally read out this distance of the lateral point

% Note that the is an error in this measurement that depends on how fine of
% a mesh you made to approximate the surface.

% Explain the difference between the four distance measurement. 
% How will this affect related measurements such as cell density or cell 
% velocity, knowing that cells move along the surface during the early
% stages of gastrulation? 
