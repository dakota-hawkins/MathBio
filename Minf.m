function [ out ] = Minf( V )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
V1 = -1.2;
V2 = 18;

out = 1/2*(1 + tanh((V-V1)/V2));

end

