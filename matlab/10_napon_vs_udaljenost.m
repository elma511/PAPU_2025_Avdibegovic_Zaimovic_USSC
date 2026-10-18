putanja_write = 'C:\Users\Elma\Desktop\WRITE2.lvm';
putanja_kraj = 'C:\Users\Elma\Desktop\KRAJ.lvm';

headerLines = 22;

% Otvori fajlove
fid_write = fopen(putanja_write, 'r');
if fid_write == -1
    error('Ne mogu otvoriti fajl WRITE: %s', putanja_write);
end

fid_kraj = fopen(putanja_kraj, 'r');
if fid_kraj == -1
    error('Ne mogu otvoriti fajl KRAJ: %s', putanja_kraj);
end

% Preskoci zaglavlje
for i = 1:headerLines
    fgetl(fid_write);
    fgetl(fid_kraj);
end

% U?itaj podatke (pretpostavka: jedan stupac brojeva u fajlu)
napon = fscanf(fid_write, '%f');
udaljenost = fscanf(fid_kraj, '%f');

% Zatvori fajlove
fclose(fid_write);
fclose(fid_kraj);

% Provjera jesu li podaci u?itani
if isempty(napon)
    error('Podaci za napon su prazni! Provjeri fajl i zaglavlje.');
end

if isempty(udaljenost)
    error('Podaci za udaljenost su prazni! Provjeri fajl i zaglavlje.');
end

disp(['Duljina napona: ', num2str(length(napon))]);
disp(['Duljina udaljenosti: ', num2str(length(udaljenost))]);

% Parametri vremena izme?u mjerenja
dt_napon = 1e-5;
dt_udaljenost = 1e-3;

% Kreiraj vremenske vektore
t_napon = (0:length(napon)-1)' * dt_napon;
t_udaljenost = (0:length(udaljenost)-1)' * dt_udaljenost;

% Ograni?i vremensku osu udaljenosti na interval napona
indeksi = t_udaljenost >= t_napon(1) & t_udaljenost <= t_napon(end);

t_udaljenost_smanjeno = t_udaljenost(indeksi);
udaljenost_smanjeno = udaljenost(indeksi);

% Interpolacija napona na novu vremensku osu udaljenosti
napon_interp = interp1(t_napon, napon, t_udaljenost_smanjeno, 'linear');

% Iscrtavanje grafa
figure;
plot(udaljenost_smanjeno, napon_interp, '-o');
xlabel('Udaljenost (cm)');
ylabel('Napon (V)');
title('Napon u funkciji udaljenosti');
grid on;