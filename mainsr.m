clc;
close all;
clear all;
particles =10000;
sig_len = 13;
iteration =20;
%initialize the random sequences for n particles
%initialize the random velocites for n particles
for i = 1:particles
    ranseq(i,:) = random('Normal',0,1,1,sig_len);
    vel(i,:) = random('Normal',0,1,1,sig_len);
end

for i = 1:particles
    for j = 1:sig_len
        if(ranseq(i,j)>=0)
            ranseq(i,j)=1;
        end
        if(ranseq(i,j)<0)
            ranseq(i,j)=-1;
        end
    end
end
for lp = 1:1:particles
    ranseqmf(lp,:) = discfr(ranseq(lp,:));
end

[max_p1 ind] = max(ranseqmf);
p1 = ranseq(ind,:);
p2 = p1;
a = linspace(0.9,1.2, iteration);
b1 = 1.494;
b2 = 1.494;

for t=1:iteration
for j = 1:particles
vel(j,:) = a(t)*vel(j,:)+b1*0.5*(p1-ranseq(j,:)) + b2*0.5*(p2-ranseq(j,:));
rass(j,:) = ranseq(j,:) + vel(j,:);
bse = rass(j,:);
%x2 = limited(bse);
%v_ranseq(j,:) = x2;
v_ranseq(j,:) = bse;
v_disc(j,:) = discfr(v_ranseq(j,:));
end
[max_vdisc ind1]=max(v_disc);
if (max_vdisc>=max_p1)
    bes_disc = max_vdisc;
    best = v_ranseq(ind1,:);
else
    bes_disc = max_p1;
    best = p1;
end
p2 = best;
b_seq(t,:) = best;
b_disc(t,:) = bes_disc;
end

b_seq;
b_disc;
[best_disc ind2] = max(b_disc);
best_seq = b_seq(ind2,:);

x=best_seq;
z=xcorr(x,x);
plot(z);
%set(gca,'XTickMode','manual');
%set(gca,'Xtick',[1,5,10]);
%set(gca,'Xtick',[30,35,40]);
%axisLimits = axis;
%axis([0,40,axisLimits(-5:32)])
%axis([-35,35,0,40]);
xlabel('n');
ylabel('z(n)');
title('auto correlation of input sequence');
