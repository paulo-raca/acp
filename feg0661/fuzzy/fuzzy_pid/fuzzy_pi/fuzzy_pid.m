fuzzy_controller = readfis("../fuzzy_controller/fuzzy_controller.fis");

% PID controller parameters
Tcr = 6.4;
h = 1;
l = .43;
Kcr = 4*h / (l*pi);


% PID parameters
pid_Kp = 0.6 * Kcr;
pid_Ki = 2 / Tcr;
pid_Kd = Tcr / 8;
pid_Ti = 1 / pid_Ki;
pid_Td = pid_Kd;

% Fuzzy-PID parameters
baskhara = [1 -pid_Ti pid_Ti * pid_Td]
alpha_beta = [
    (-baskhara(2) + sqrt(baskhara(2)^2 - 4*baskhara(1)*baskhara(3)) / (2*baskhara(1)))
    (-baskhara(2) - sqrt(baskhara(2)^2 - 4*baskhara(1)*baskhara(3)) / (2*baskhara(1)))
]
fuzzy_Ke = 1;
fuzzy_Kd = alpha_beta(1) * fuzzy_Ke;
fuzzy_K0 = pid_Kp / pid_Ti
fuzzy_K1 = fuzzy_K0 * alpha_beta(1)
