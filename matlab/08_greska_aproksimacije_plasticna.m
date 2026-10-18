% Novi realni podaci
udaljenost = [1.2, 2.2, 3.2, 4.2, 7.2, 11.2, 16.2, 21.2, 26.2, 31.2, ...
              36.2, 41.2, 46.2, 51.2, 56.2, 61.2, 66.2, 71.2, 76.2, ...
              81.2, 86.2, 91.2, 96.2, 101.2, 106.2, 111.2, 116.2, ...
              121.2, 126.2, 131.2, 136.2, 141.2, 146.2, 151.2];

vrijeme = [129, 179.5, 229.6, 369.7, 539.7, 679.7, 1029, 1279, 1619, ...
           1879, 2099, 2382, 2655, 2959, 3239, 3529, 3700, 4060, ...
           4347, 4630, 4891, 5230, 5572, 5830, 6130, 6397, 6732, ...
           6954, 7300, 7569, 7860, 8130, 8498, 8730];

% Linearna aproksimacija
udaljenost_lin = 0.01734 .* vrijeme - 0.844;

% Apsolutna greška
aps_greska = abs(udaljenost - udaljenost_lin);

% Relativna greška (u procentima)
rel_greska = aps_greska ./ udaljenost * 100;

% Ispis osnovnih statistika
fprintf('Maksimalna apsolutna greška: %.3f cm\n', max(aps_greska));
fprintf('Srednja apsolutna greška: %.3f cm\n', mean(aps_greska));
fprintf('Maksimalna relativna greška: %.2f %%\n', max(rel_greska));
fprintf('Srednja relativna greška: %.2f %%\n', mean(rel_greska));

% --- Prikaz grafikona ---
figure;

% Udaljenost u funkciji vremena
subplot(2,1,1);
plot(vrijeme, udaljenost, 'bo-', 'DisplayName', 'Realna karakteristika'); hold on;
plot(vrijeme, udaljenost_lin, 'r--', 'DisplayName', 'Linearna aproksimacija');
xlabel('Vrijeme [ms]');
ylabel('Udaljenost [cm]');
title('Udaljenost u funkciji vremena');
legend;
grid on;

% Apsolutna greška
subplot(2,1,2);
plot(vrijeme, aps_greska, 'k-o', 'DisplayName', 'Apsolutna greška');
xlabel('Vrijeme [ms]');
ylabel('Greška [cm]');
title('Apsolutna greška izmedju realne i linearne karakteristike');
grid on;