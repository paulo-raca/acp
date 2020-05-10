fuzzy_pid = readfis("fuzzy_pid.fis");

% PID controller parameters
Tcr = 7;
h = 1;
l = 1.4;
Kcr = 4*h / (l*pi);


% PID parameters
Kp = 0.6 * Kcr;

Ti = Tcr / 2;
Td = Tcr / 8;

% Fuzzy-PID parameters
alpha_beta = sort(real(roots([1, -Ti, Ti * Td])));

fuzzy_Ke = 1;
fuzzy_Kd = alpha_beta(2) * fuzzy_Ke;
fuzzy_K0 = Kp / Ti;
fuzzy_K1 = fuzzy_K0 * alpha_beta(2);
