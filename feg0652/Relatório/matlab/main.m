%% Dados do experimento em malha aberta
U_exp = 30; % Potencia da planta durante o teste em malha aberta
T_amb = 24.9; % Temperatura ambiente durante o teste em malha aberta
experimental_data = [
    0	24.9
    5	24.8
    10	25.1
    15	25.9
    20	27
    25	28.3
    30	29.7
    35	31
    40	32.3
    45	33.5
    50	34.3
    55	35.4
    60	36.3
    65	37.2
    70	38.2
    75	39.2
    80	39.9
    85	40.7
    90	41.3
    95	41.6
    100	42.3
    105	43
    110	43.4
    115	43.7
    120	44.3
    125	44.6
    130	45.1
    135	45.2
    140	45.6
    145	46
    150	46.3
    155	46.6
    160	46.8
    165	47.1
    170	47.2
    175	47.4
    180	47.8
    185	47.8
    190	48
    195	48.2
    200	48.3
    205	48.4
    210	48.6
    215	48.7
    220	48.8
    225	49
    230	49.1
    235	49.2
    240	49.4
    245	49.5
    250	49.7
]


%% Constantes da planta
L = 13.4949;
K = 0.8609;
T = 77.7223;


%% Modelo para resposta ao degrau
model_t = 0:.1:250;
model_y = T_amb + U_exp * K * (1 - exp(-max(0, model_t - L) / T));

plot( ...
    model_t, model_y, "r",  ...
    experimental_data(:, 1), experimental_data(:, 2), "ko");
legend({'Modelo em malha aberta', 'Experimental'}, 'Location','northwest')

%% Função de transferencia da planta, com aproximação de Padé
G = tf([K], [T 1]);
atraso = tf([-L/2 1], [L/2 1]);
ftma = G * atraso;
[ftma_y, ftma_t] = step(U_exp*ftma, 250);
ftma_y = ftma_y + T_amb;

plot( ...
    ftma_t, ftma_y, "r",  ...
    experimental_data(:, 1), experimental_data(:, 2), "ko");
legend({'Função de Transferência em malha aberta', 'Experimental'}, 'Location','northwest')

%% Simulação da planta no Simulink
sim_out = sim("malha_aberta");

plot( ...
    sim_out.tout, sim_out.temperatura, "r", ...
    experimental_data(:, 1), experimental_data(:, 2), "ko");
legend({'Simulação em malha aberta', 'Experimental'}, 'Location','northwest')

%% Plota tudo junto
sim_out = sim("malha_aberta");

plot( ...
    model_t, model_y, "g",  ...
    ftma_t, ftma_y, "b",  ...
    sim_out.tout, sim_out.temperatura, "r", ...
    experimental_data(:, 1), experimental_data(:, 2), "ko");
legend({'Modelo em malha aberta', 'Função de Transferência em malha aberta', 'Simulação em malha aberta', 'Experimental'}, 'Location','northwest')


%% Simulando controlador P para várias temperaturas

Kp = 6.5;
clf
hold on
for T_setpoint = 25:5:50
    sim_out = sim("controlador_p", 180);
    plot(sim_out.tout, sim_out.temperatura, "b");
    text(sim_out.tout(end), sim_out.temperatura(end), sprintf("%dºC -> %.1f", T_setpoint, sim_out.temperatura(end)))
end
hold off


%% Criando controlador via Lugar Geométrico das Raízes

%rltool(ftma); % Salvo como controlador_pi
Ki = 0.04;
Kp = 3;
controlador_pi = tf([Kp Ki], [1 0]);

% Simulando controlador PI para várias temperaturas
clf
hold on
for T_setpoint = 25:5:80
    sim_out = sim("controlador_pi", 200);
    plot(sim_out.tout, sim_out.temperatura, "b");
    text(sim_out.tout(end), sim_out.temperatura(end), sprintf("%dºC", T_setpoint))
end
hold off