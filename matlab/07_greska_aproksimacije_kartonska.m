% Realna mjerenja
d = [2.2, 3.2, 4.2, 5.2, 6.2, 7.2, 8.2, 9.2, 10.2, 11.2, ...
     16.2, 21.2, 26.2, 31.2, 36.2, 41.2, 51.2, 61.2, ...
     71.2, 81.2, 91.2, 101.2, 111.2, 121.2, 131.2, 141.2, 151.2];

t = [189, 229.6, 249.6, 329.7, 369.6, 509.71, 569.7, 589.6, ...
     669.7, 697.8, 1090, 1329, 1562, 1857.9, 2089.6, 2410.3, ...
     2948, 3510, 4120, 4665, 5267, 5840.9, 6420, 7050, ...
     7635.1, 8240, 8849];

% Linearna aproksimacija
d_lin = 0.01734 .* t - 0.844;

% Apsolutna greška
abs_error = abs(d - d_lin);

% Relativna greška (u procentima)
rel_error = abs_error ./ d * 100;

% Ispis maksimalne i srednje greške
fprintf('Maksimalna apsolutna greška: %.3f cm\n', max(abs_error));
fprintf('Srednja apsolutna greška: %.3f cm\n', mean(abs_error));
fprintf('Maksimalna relativna greška: %.2f %%\n', max(rel_error));
fprintf('Srednja relativna greška: %.2f %%\n', mean(rel_error));

% --- Crtanje grafikona ---
figure;
subplot(2,1,1);
plot(t, d, 'bo-', 'DisplayName', 'Realna karakteristika'); hold on;
plot(t, d_lin, 'r--', 'DisplayName', 'Linearna aproksimacija');
xlabel('Vrijeme [ms]');
ylabel('Udaljenost [cm]');
title('Udaljenost u funkciji vremena');
legend;
grid on;

subplot(2,1,2);
plot(t, abs_error, 'k-o', 'DisplayName', 'Apsolutna greška');
xlabel('Vrijeme [ms]');
ylabel('Greška [cm]');
title('Apsolutna greška izmedju realne i linearne karakteristike');
grid on;