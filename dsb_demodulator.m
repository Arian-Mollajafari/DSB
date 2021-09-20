function y = dsb_demodulator(c, t, fc, W, Fs)

r = c.*cos(2*pi*fc*t);
y = lowpass(r, W, Fs);

end
