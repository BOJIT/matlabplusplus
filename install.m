% FILE:         install.m
% DESCRIPTION:  Installation Script for MATLAB Tools
% AUTHOR:       James Bennion-Pedley
% DATE CREATED: 05/07/2022

%-------------------------------- Entry Point ---------------------------------%

% Config
root = "https://mpp.bojit.org/src/";
target = "MPP/";
api = "http://api.github.com/repos/BOJIT/matlabplusplus/commits/gh-pages";
browse = "https://github.com/BOJIT/matlabplusplus/tree/";
manifest = [
    "CHeader.m";
    "Config.m";
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
    fprintf("Fetching %s...\n", url);
    websave(filename, url);
end

% Write out release notes
metadata = webread(api);
release_str = sprintf(strcat( ...
    "# MATLAB++\n\n", ...
    "Author: [James Bennion-Pedley](https://bojit.org)\n\n", ...
    "Release: [%s](%s)\n" ...
), metadata.sha, strcat(browse, metadata.sha));

fid = fopen(strcat(target, "RELEASE.md"), 'w+');
fwrite(fid, release_str);
fclose(fid);

% Print notes
fprintf("--------------------------------------------\n");
fprintf("All files fetched!\n");
fprintf("Release Commit: %s\n", metadata.sha);
fprintf("Add ./MPP to your path to use the helper functions\n");
