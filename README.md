# MATLAB++
A collection of MATLAB tools and utilities that make MATLAB less absurd!

## Installation
You can install MATLAB++ manually in a project by opening a terminal in MATLAB and running:

```matlab
eval(webread('https://mpp.bojit.org/install'));
```

This will install the latest version of MATLAB++ in the project working directory. Alternatively, you can have a script automatically fetch MATLAB++ as folows:

```matlab
% FILE:         myScript.m
% DESCRIPTION:  Example automatic fetch of MATLAB++ utilities
% AUTHOR:       James Bennion-Pedley
% DATE CREATED: 05/07/2022

%------------------------------------------------------------------------------%

close all; clc; clear;

% Check if Matlab++ is installed
if ~exist('MPP', 'file'); eval(webread('https://mpp.bojit.org/install')); else; MPP.init(); end

%-------------------------------- Entry Point ---------------------------------%

disp("Put your scripting utils here as normal");

%------------------------------ Helper Functions ------------------------------%


```

## Usage

All functions in MATLAB++ are static class methods. You call them using the following syntax:

```matlab
% Example: Use LaTex formatting Functions
LaTex.matrix([1, 2; 3, 4]);
```

## Security

Despite the fact that the files are installed from the web automatically, there is no server-side component to these tools.
If you are paranoid about security, just download the files manually.
