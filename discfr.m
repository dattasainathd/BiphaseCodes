function [df] = discfr(tt)
st = xcorr(tt);
n = length(tt);
mainlobe = max(st);
sidelobe = max(st(n-5:n-1));
df = mainlobe/sidelobe;

