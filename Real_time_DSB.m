clc;
clear;
% Assuming a time domain which can be infinite
% no limitations such as memory run-out, overloads, etc.
T = 30;

% Message bandwidth
W = 5000;

% Carrier amplitude
Ac = 2;

% Carrier frequency
fc = 10000;

% Assuming power spectral density N0/2
N0 = 10^-9;

% Audio recorder object
recorder = audioDeviceReader;

% Audio player object
player = audioDeviceWriter('SampleRate',recorder.SampleRate);

% Assigning the SamplesPerFrame rate equal to the SamplesRate
% in order to process the latest one-second data
recorder.SamplesPerFrame = recorder.SampleRate;

% Start recording
disp('Radio started')

% Using tic-toc in order to form the t array for each second
tic;

% Radio is active for T seconds
for i = 0:round(T)
t0 = toc; % The time at the start of recording
m = recorder();
t = linspace(t0, toc, length(m)); % Forming t
mod   = dsb_modulator(t, m', Ac, fc);
chn   = channel(mod, 2*W, N0);
demod = dsb_demodulator(chn, t, fc, W, recorder.SampleRate);
player(demod');
end
release(recorder)
release(player)