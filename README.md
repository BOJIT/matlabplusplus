# MATLAB++
A collection of `MATLAB` tools and utilities that make MATLAB less absurd!
Mostly tested with `MATLAB r2021a`, but aims to be backwards-compatible to `r2019b`.

## Installation

You can install MATLAB++ manually in a project by opening a terminal in MATLAB and running:

```matlab
eval(webread('https://mpp.bojit.org/install.m'));
```

This will install the latest version of MATLAB++ in the project working directory.


## Usage

All functions in `MATLAB++` are static class methods. You call them using the following syntax:

```matlab
% Example: Use LaTex formatting Functions
LaTex.matrix([1, 2; 3, 4]);
```

## Security

Despite the fact that the files are installed from the web automatically, there is no server-side component to these tools.
If you are paranoid about security, just download the files manually.
