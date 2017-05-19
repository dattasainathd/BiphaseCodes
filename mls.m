%Generation of Binary maximum length sequence code
% maxlength.m
clear, clc;
%code length and feed back (m=2-7; 9-11)
m= input ('length =');
a= m-1;
if m==5;a=3;end;
if m==6;a=5;end;
if m==7;a=6;end
if m==9;a=5;end;
if m==10;a=7;end;
if m==11;a=9;end;
 
l=2^m-1;
        %start sequence
x=eye(1,m);
z=x;
 
%generate sequence of zero-ones
 
for j=1:l;
    for i=2:m; x(i)=z(i-1); x(1) =z(a)+z(m); end;
    if x(1)==2; x(1)=0;end;
    Y(j)=z(m); z=x; end;
 
%Convert to sequence of 1,-1
 
for i=1:l;
    if Y(i)==0; Y(i)=-1; end;
end;
%         Plot correlation
%        if Y(i)==0; Y(i)=-1; end;
%        l=28;
%        Y= [-1     1     1    -1    -1    -1     1     1     1    -1     1      1    -1    -1    -1     1    -1     1    -1     1    -1     1 ...
%      1     1     1     1    -1    -1 ];
 
    t=1:2*l-1; zz=xcorr(Y);
    plot(t,abs(zz)); grid;
    xlabel('Time');
    ylabel('Auto-correlation');
   title(['Binary Code Autocorrelation']);
  zz=xcorr(Y); % Estimate the cross correlation
%zz =xcorr(Y)
%zz=20*log10(abs(xcorr(Y))+eps);
%zz=zz-max(zz);
%zz=max(zz,-60); 
%figure
%plot(zz);
title('Auto-correlation Function');
xlabel('{\it\tau}/\itt_b');
ylabel('Autocorrelation [dB]');
% title(titlest);
%axis([0 max(scalet) -60 0]);
grid;
   %Display sequence
%    b=input('Display Sequence Yes=1; No=0; ');
%    if b==1; disp(Y); end;