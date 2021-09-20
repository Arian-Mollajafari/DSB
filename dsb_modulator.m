function u = dsb_modulator(t,m,Ac,fc)

u = Ac*m.*cos(2*pi*fc*t);

end
