fid = fopen('C:\Users\Elma\Desktop\KRAJ.lvm', 'r');

% Inicijalizacija
v = [];

% ?itaj red po red
zaglavlje_gotov = false;

while ~feof(fid)
    linija = strtrim(fgetl(fid));
    
    % Ako nai?emo na kraj zaglavlja
    if ~zaglavlje_gotov && ~isempty(strfind(linija, '***End_of_Header***'))
        zaglavlje_gotov = true;
        fgetl(fid); % Presko?i red sa nazivima kolona (X_Value DC Comment)
        continue;
    end
    
    % Ako smo prošli zaglavlje i došli do podataka
    if zaglavlje_gotov && ~isempty(linija)
        brojevi = sscanf(linija, '%f');
        if ~isempty(brojevi)
            v(end+1) = brojevi(1); %#ok<AGROW>
        end
    end
end

fclose(fid);

% Kreiraj vremenski vektor
delta_t = 0.01;             % 10 ms izme?u uzoraka
n = length(v);              % Broj uzoraka
t = (0:n-1) * delta_t;      % Vremenska osa

% Prikaz informacija
fprintf('Broj mjerenja: %d\n', n);
fprintf('Trajanje signala: %.2f sekundi\n', max(t));

% Plot
figure;
plot(t, v, 'b', 'LineWidth', 1.5);
xlabel('Vrijeme (s)');
ylabel('Napon (V)');
title('Promjena napona kroz vrijeme');
grid on;

%xlim([0 max(t)]);
%ylim([floor(min(v)) ceil(max(v))]);

% Postavi xticks i yticks u koracima po 1
%xticks(0:1:ceil(max(t)));
%yticks(floor(min(v)):1:ceil(max(v)));


x_min = 0;
x_max = ceil(max(t));
y_min = floor(min(v));
y_max = ceil(max(v));
xlim([x_min x_max]);
ylim([y_min y_max]);

% Postavi oznake na osi sa korakom 1
set(gca, 'XTick', x_min:1:x_max);
set(gca, 'YTick', y_min:1:y_max);

% Poja?aj font na osama da se bolje vidi
set(gca, 'FontSize', 12, 'FontWeight', 'bold');