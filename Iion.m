function [ I ] = Iion( V,W )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
gCa = 4.4;
gK = 8;
gL = 2;
Vca = 120;
VL = -60;
VK = -84;

I = gCa*Minf(V)*(V-Vca)+gK*W*(V - Vk) + gL*(V-VL);

end

