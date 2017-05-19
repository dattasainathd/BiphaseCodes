clc;
close all;
clear all;
particles = 1000;
sig_len = 32;
iteration = 13;

%initialize the random sequences for n particles
%initialize the random velocites for n particles
for i = 1:particles
    ranseq(i,:) = randperm(sig_len);
    vel(i,:) = randperm(sig_len);
end

%trying to find discriminatory factor for all the random sequences
for lp = 1:1:particles
    ranseqmf(lp,:) = discfr(ranseq(lp,:));
end

%extracted the maximum discriminatory factor and its indices
[max_p1 ind] = max(ranseqmf)

%assuming p1 as the random sequence which has the best discriminatory
%factor
p1 = ranseq(ind,:);
p2 = p1;

%assuming a according to no of iterations
a = linspace(0.9,1.2, iteration);
b1 = 1.494;
b2 = 1.494;

for t = 1: iteration
    for j = 1:particles
        vel(j,:) = a(t)*vel(j,:) + b1*0.5*(p1-ranseq(j,:)) + b2*0.5*(p2-ranseq(j,:));
        rass(j,:) = ranseq(j,:) +  vel(j,:);
        bse = rass(j,:);
        x2 = limited(bse);
        v_ranseq(j,:) = x2;
        v_disc(j,:) = discfr(v_ranseq(j,:));
    end
    
    %evaluating whether newly formed sequence is good or not and then
    %interchanging 
    [max_vdisc ind1] = max(v_disc);
    if(max_vdisc>=max_p1)
        bes_disc = max_vdisc;
        best =v_ranseq(ind1,:);
    else
        bes_disc = max_p1;
        best = p1;
    end
    
    p2 = best;
    b_seq(t,:) = best
    b_disc(t,:) = bes_disc
end
b_seq;
b_disc;
[best_disc ind2] = max(b_disc);
best_seq = b_seq(ind2,:)