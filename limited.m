function [bse] = limited(bse)
sequ = bse;
n = length(sequ);
for i =1:1:n
    if(sequ(i)>=0)
        sequ(i) = 1;
    end
    if(sequ(i)<0)
        sequ(i) = -1;
    end
end
x2 = round(sequ);
seq = x2;
bse = seq;
end