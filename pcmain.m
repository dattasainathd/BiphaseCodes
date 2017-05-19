%function for Input LFM signal generation
function [LFM, fre1, FLFM] = lffm1(BW,n,T)
fc = 10*10^6;
alpha = (BW)/(t); % chirp rate
disp(alpha);
t = linspace(-T/2,T/2, n) %time interval
ichannel = cos(2*pi*((fc)*t+alpha*t.^2)); %real part
%imaginary part
qchannel = sin(2*pi*((fc)*t+alpha*t.^2));
%computing linear frequency modulating waveform
LFM = (ichannel + (li*qchannel));
LFM(2:1:10)=0;
LFM(504:1:511) = 0;
disp(LFM);
freqmin=fc-BW/2;%minimum frequency at t= -T/2;
freqmax=fc+BW/2;%maximum frequnecy at t=  T/2;
fre1=linspace(freqmin,freqmax,n);% frequency limitations
FLFM=fftshift(fft(LFM));
%plot(fre1,abs(FLFM));