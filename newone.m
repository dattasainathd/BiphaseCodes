%Code prepared for Project Work
%Author: Datta Sainath D.
%Choose signal length at sig_len
%choose iteration according to your need for fine tuning
%more the no. of iterations more is the tuning
clc;
close all;
clear all;
particles =100;
sig_len = 13;
iteration =50;
%initialize the random sequences for n particles
%more the random sequences gives us more scope for searching various
%random sequences
%increase the number of particles for better results
%initialize the random velocites for n particles
for i = 1:particles
    ranseq(i,:) = random('Normal',0,1,1,sig_len);
    vel(i,:) = random('Normal',0,1,1,sig_len);
end

%Randomly generated sequences consists of real numbers between -1 and 1
%Converting the random sequence to either 1 or -1
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

%Finding the discriminatory factor for all the random sequences generated
for lp = 1:1:particles
    st = xcorr(ranseq(lp,:));
    mainlobe = max(st);
    sidelobe = max(st(1:sig_len-1));
    df = mainlobe/sidelobe;
    ranseqmf(lp,:) = df;
end

%finding the maximum discriminatory factor from all the discriminatory
%factors of random sequences generated
%initializing p1 as local best
%initialzing p2 as global best
%initialzing a for iteration
%initialzing b1 and b2 according to PSO algorithm
[max_p1 ind] = max(ranseqmf);
p1 = ranseq(ind,:);
p2 = p1;
a = linspace(0.9,1.2, iteration);
b1 = 1.494;
b2 = 1.494;

%PSO algorithm 
for t=1:iteration
for j = 1:particles
    vel(j,:) = a(t)*vel(j,:)+b1*0.5*(p1-ranseq(j,:)) + b2*0.5*(p2-ranseq(j,:));
    rass(j,:) = ranseq(j,:) + vel(j,:);
    bse = rass(j,:);
    x2 = limited(bse);
    v_ranseq(j,:) = x2;
    
    %calculating the discriminatory factory for the newly formed sequence
    v_st = xcorr(v_ranseq(j,:));
    v_mainlobe = max(v_st);
    v_sidelobe = max(v_st(1:sig_len-1));
    v_df = v_mainlobe/v_sidelobe;
    v_disc(j,:) = v_df;
end

%finding the maximum discriminatory function
[max_vdisc ind1]=max(v_disc);

%interchanging the old local best with the new local best if this
%discriminatory factor is greater than previous local best
if (max_vdisc>=max_p1)
    bes_disc = max_vdisc;
    best = v_ranseq(ind1,:);
else
    bes_disc = max_p1;
    best = p1;
end

%doing necessary changes for the local best and global best
p2 = best;
b_seq(t,:) = best;
b_disc(t,:) = bes_disc;
end


%finding the maximum discriminatory factor among all the iterations
[best_disc ind2] = max(b_disc);
best_seq = b_seq(ind2,:);
b_disc
x=best_seq

%plotting the autocorrelation plot
z=xcorr(x,x);
plot(z);
xlabel('n');
ylabel('z(n)');
title('auto correlation of input sequence');