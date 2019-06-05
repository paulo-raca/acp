water_density = 1000  % kg/m�
water_specific_heat = 4200 % J/kg K

air_density = 1.3  % kg/m�
air_specific_heat = 1000 % J/kg K

Te = 20 % �C -- Temperatura externa
qe = 1000 % W -- Potencia do aquecedor

% Tamanho e volume dos compartimentos
A = 0.5 % m�
L1 = 0.25 % m
L2 = 0.2 % m
V1 = A * L1 % m�
V2 = A * L2 % m�

% Capacidade t�rmica dos compartimentos
C1 = V1*water_density*water_specific_heat % J/K
C2 = V2*air_density*air_specific_heat % J/K

% Espessura e condutividade das divis�rias
W1 = 0.025 % m
W2 = 0.05 % m
COND1 =  50 % W/m.K
COND2 = 385 % W/m.K

% Resistencia T�rmica das divis�rias
R1 = W1 / (COND1 * A) % K/W
R2 = W2 / (COND2 * A) % K/W

sym('aquecedor_2_salas')
