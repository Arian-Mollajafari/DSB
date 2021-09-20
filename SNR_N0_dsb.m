clear;
clc;
W = 10;
T = 2;
fs = 400000;
N0=linspace(10^-4,5*10^-3, 60);
t = linspace(0,T-1/fs,T*fs);
msg = cos(2*pi*W*t);

mod = dsb_modulator(t,msg,1,400);
demod_no_n = dsb_demodulator(mod, t, 400, 1.1*W, fs);

s_pow_no_n = mean(demod_no_n.^2);
snr = zeros(1,length(N0));
for i=1:length(N0)
    chn = channel(mod,2*W,N0(i));
    demod_n = dsb_demodulator(chn, t, 400, 1.1*W, fs);
    n_pow =mean(demod_n.^2)-s_pow_no_n;
    snr(i) = s_pow_no_n/n_pow;
end
plot(N0,snr)
xlabel('N_0')
ylabel('SNR')