clear;
clc;
T = 2;
fs = 400000;
N0 = 10^-3;
W = linspace(5,100, 60);
t = linspace(0,T-1/fs,T*fs);
snr = zeros(1,length(W));
msg = zeros(length(W),length(t));
for i=1:length(W)
msg(i,:) = cos(2*pi*W(i)*t);
mod = dsb_modulator(t,msg(i,:),1,400);
demod_no_n = dsb_demodulator(mod, t, 400, 1.1*W(i), fs);
s_pow_no_n = mean(demod_no_n.^2);
chn = channel(mod,2*W(i),N0);
demod_n = dsb_demodulator(chn, t, 400, 1.1*W(i), fs);
n_pow =mean(demod_n.^2)-s_pow_no_n;
snr(i) = s_pow_no_n/n_pow;
end
plot(W,snr)
xlabel('W')
ylabel('SNR')