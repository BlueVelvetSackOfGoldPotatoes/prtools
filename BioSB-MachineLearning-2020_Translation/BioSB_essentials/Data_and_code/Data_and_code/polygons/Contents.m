%POLYGONS Simple polygon handling
%
% A polygon is an ordered set of 2d coordinates. It represents a closed
% curve which should not intersect itself. The first and the last
% coordinate are equal. The representation is just a n*2 array of doubles.
%
% This toolbox contains a set of routines to create, convert, manipulate
% polygons. It also contains some routines to measure certain properties.
%
% The set of examples introduces the usage further.
%
% Bob Duin, 18 July 2006
%
% Creation of polygons
% --------------------
% polygon      - Define polygon, convert from contour or read from file, PRFILTER.
% polygen      - Generate polygons
% im2poly      - Threshold image and find polygons
%
% Plot polygons
% -------------
% plotpoly     - Standard plot of polygon
% plotblob     - Plot polygon as blob
% showpoly     - Plot all polygons in rows
%
% Manipulating polygons
% ---------------------
% polynorm     - Normalize polygons on size, position and orientation
% polyclose    - Close polygon if necessary
% polycell     - Combine polygons
% polyint      - Interpolate polygons
% polyopt      - Find best fitting smaller polygon
% polyone      - select largest polygone in cell array of polygons
%
% Measuring properties
% --------------------
% polyarea     - Measure area of polygon
% polylength   - Measure length of polygon
% polybox      - Measure box size in which polygon fits
% polyposition - Position of polygons in image
% polymoments  - Compute translation and scale invariant moments
% polydist     - Measure dissimilarity matrix between sets of polygons
%
% Conversion of polygons
% ----------------------
% poly2im      - Convert polygon to image
% poly2fc      - Convert polygon to Freeman code string
% fc2poly      - Convert Freeman code string to polygon
% poly2rad     - Find radial description of polygon
% rad2poly     - Convert radial description into polygo
% rad2rad      - Smooth polygons
%
% Examples
% --------
% poly_ex1     - Intro polygons
% poly_ex2     - Image --> Polygons --> Image
% poly_ex3     - Generate polygons
% poly_ex4     - Polygon normalisation
% poly_ex5     - Polygon interpolation and smoothing
% poly_ex6     - Digit recognition
% poly_ex7     - Freeman string code conversion
