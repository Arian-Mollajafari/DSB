function r = channel(u,Bc,N0)

noinse_power = 2*(N0/2)*Bc;
noise_power_db = 10*log10(noinse_power);
r = u + wgn(1, length(u), noise_power_db);

end
