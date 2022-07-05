% FILE:         install.m
% DESCRIPTION:  Installation Script for MATLAB Tools
% AUTHOR:       James Bennion-Pedley
% DATE CREATED: 05/07/2022

%-------------------------------- Entry Point ---------------------------------%

% Config
root = "https://mpp.bojit.org/src/";
target = './MPP/';
api = "http://api.github.com/repos/BOJIT/matlabplusplus/commits/gh-pages";
manifest = [
    "CHeader.m";
    "Domain.m";
    "FFT.m";
    "Figure.m";
    "Filter.m";
    "LaTex.m";
    "Maths.m";
];

% Create MPP directory if it doesn't exist
if ~exist(target, 'dir')
    mkdir(target);
end

% Fetch files
for m = manifest'
    filename = strcat(target, m);
    url = strcat(root, m);
    fprintf("Fetching %s...", url);
    websave(filename, url);
end

% Write out release notes
fprintf("All files fetched!");
