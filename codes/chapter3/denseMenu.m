function denseMenu(m, n)
% Filename: denseMenu.m
% Description: Custom menu for creating dense random LPs
% Authors: Ploskas, N., & Samaras, N.
%
% Syntax: denseMenu(m, n)
%
% Input:
% -- m: the number of constraints of the generated random LPs
% -- n: the number of variables of the generated random LPs
%
% Output: files that store the generated dense random LPs

% read the directory to store the LPs
pathName = input(['Please give the path where you want ' ...
    'to store the generated LPs: ']);
% read the number of the LPs to generate
nOfProblems = input(['Please give the number of the LPs ' ...
    'that you want to create:  ']); 
% read the ranges of the values for matrix A
Alu = input(['Please give the range of the values for ' ...
    'matrix A: ']);
% read the ranges of the values for vector c
clu = input(['Please give the range of the values for ' ...
    'vector c: ']);
% read the type of optimization
optType = input(['Please give the type of optimization ' ...
    '(0 min, 1 max, 2 random): ']);
% read if all LPs will be optimal
optimality = input(['Do you want all the LPs to be ' ...
    'optimal (1 yes, 2 no): ']);
if optimality == 1 % optimal LPs
    % read the center of the circle
    center = input(['Please give the center of the circle: ']);
    % read the radius of the circle
    R = input(['Please give the radius of the circle ' ...
        '(must be less than the center of the circle: ']);
    while R >= center % read R
        R = input(['Please give the radius of the circle ' ...
            '(must be less than the center of the circle: ']);
    end
    % create nOfProblems dense random optimal LPs
    for i = 1:nOfProblems
        [A, c, b, Eqin, MinMaxLP] = denseRandomOptimal(m, n, ...
            optType, Alu, clu, center, R);
        s1 = num2str(m);
        s2 = num2str(n);
        k = num2str(i);
        fname = [pathName '/' 'fdata' k '_' s1 'x' s2];
        Name = ['fdata' k '_' s1 'x' s2];
        R = [];
        BS = [];
        NonZeros = nnz(A);
        c0 = 0;
        c00 = 0;
        % save variables in a MAT file
        eval(['save ' fname '.mat A c b Eqin MinMaxLP Name ' ...
            'R BS NonZeros c0 c00']);
    end
else % not optimal LPs
    % read the ranges of the values for vector b
    blu = input(['Please give the range of the values for ' ...
        'vector b: ']);
    % read the ranges of the values for vector Eqin
    Eqinlu = input(['Please give the range of the values ' ...
        'for vector Eqin (0 - equality constraints, 1 - ' ...
        ' less than or equal to inequality constraints, ' ...
        ' 2 - greater than or equal to inequality ' ...
        'constraints: ']);
    for i = 1:nOfProblems % create nOfProblems dense random LPs
        [A, c, b, Eqin, MinMaxLP] = denseRandom(m, n, ...
            optType, Alu, clu, blu, Eqinlu);
        s1 = num2str(m);
        s2 = num2str(n);
        k = num2str(i);
        fname = [pathName '/' 'fdata' k '_' s1 'x' s2];
        Name = ['fdata' k '_' s1 'x' s2];
        R = [];
        BS = [];
        NonZeros = nnz(A);
        c0 = 0;
        c00 = 0;
        % save variables in a MAT file
        eval(['save ' fname '.mat A c b Eqin MinMaxLP Name ' ...
            'R BS NonZeros c0 c00']);
    end
end
end