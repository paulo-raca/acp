clear all % Limpar as variaveis do workspace

%% Definir as variáveis
t = 0:.0025:1;
u = sin(2*pi*(t+0)) + .5*sin(2*pi*(32*t + .7)) + .25*sin(2*pi*(64*t + .7));

%% Filtro
hold off
nfilters = 5;
ndegs = 4;
for n=0:1:(nfilters-1)
    for deg=1:ndegs
        for fig=1:2
            tau = .002 * 2 ^ n ^ 1/deg;
            if fig==1
                filter = tf([1], [tau 1]) ^ deg;
            else
                filter = tf([tau 0], [tau 1]) ^ deg;
            end

            y = lsim(filter, u, t);          
            [fft_u, f] = myfft(u, t);
            [fft_y, f] = myfft(y, t);
            figure(1)
            subplot(nfilters, ndegs, n*ndegs + deg);
            plot(t, u, 'r', t, y, 'b');
            text(0, -1.5, sprintf('Tau=%0.5f',tau));
            
            figure(2)
            subplot(nfilters, ndegs, n*ndegs + deg);
            plot(f, fft_u, 'r', f, fft_y, 'b');
        end
    end
end