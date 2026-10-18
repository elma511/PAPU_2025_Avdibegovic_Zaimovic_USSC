udaljenost = 1:10:150;
trajanje = 57.13 * udaljenost + 52.59;
trajanje = trajanje / 1000;

figure;                             % Otvori novi prozor za graf
plot(udaljenost, trajanje);
xlabel('Udaljenost [cm]');
ylabel('Vrijeme [s]');
title('Linearizovana karakteristika HC-SR04 senzora');
set(gca, 'XTick', 0:10:150);        % Postavi ru?no oznake na x-osi
grid on;