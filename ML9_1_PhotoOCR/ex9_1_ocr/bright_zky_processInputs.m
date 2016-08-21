function []=bright_zky_processInputs()
% bright_zky_processInputs: process Inputs.
%remove those data that surrounds with 0: process background noise.
load('bright_zky_zkyAllData.mat');
