clc;
clear all;
z = [1 1 1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1 -1 -1 -1 -1 -1 1 1 -1 -1 1 -1 1 -1 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1];
y = xcorr(z,z);
plot(y); grid;
xlabel('Time');
ylabel('Auto-correlation');
title('Code Autocorrelation');