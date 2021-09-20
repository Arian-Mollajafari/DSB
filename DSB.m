clear;
clc;
% Message bandwidtth
W = 5000;

% Carrier amplitude
Ac = 1;

% Carrier frequency
fc = 15000;

% Assuming power spectral density N0/2
N0 = 10^-9;

% Audio reading from the file
[m,fs] = audioread('PinkPanther.wav');

% Forming t
t = linspace(0, (length(m)-1)/fs, length(m));

mod    = dsb_modulator(t, m', Ac, fc);
chn    = channel(mod, 2*W, N0);
demomd = dsb_demodulator(chn, t, fc, W, fs);

sound(demomd, fs);