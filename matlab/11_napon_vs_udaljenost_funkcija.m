function plot_napon_udaljenost()

    % --- Funkcija za ?itanje podataka iz LVM fajla ---
    function values = read_lvm(file_path)
        fid = fopen(file_path, 'r');
        values = [];
        header_done = false;

        while ~feof(fid)
            line = strtrim(fgetl(fid));
            if ~header_done && ~isempty(strfind(line, '***End_of_Header***'))
                header_done = true;
                fgetl(fid); % presko?i red sa imenima kolona
                continue;
            end
            if header_done && ~isempty(line)
                nums = sscanf(line, '%f');
                if ~isempty(nums)
                    values(end+1) = nums(1); %#ok<AGROW>
                end
            end
        end
        fclose(fid);
    end

    % --- Definicije putanja do fajlova ---
    putanja_napon = 'C:\Users\Elma\Desktop\KRAJ.lvm';
    putanja_udaljenost = 'C:\Users\Elma\Desktop\WRITE2.lvm';

    % --- U?itavanje podataka ---
    v = read_lvm(putanja_napon);
    d = read_lvm(putanja_udaljenost);

    % --- Provjera podudarnosti dužina ---
    if isempty(v) || isempty(d)
        error('Jedan od fajlova je prazan ili nije u?itan ispravno.');
    end

    % --- Definicija vremenskih intervala izme?u uzoraka ---
    delta_t_v = 0.01;  % npr. 10 ms izme?u uzoraka napona
    delta_t_d = 0.05;  % npr. 50 ms izme?u uzoraka udaljenosti

    % --- Generisanje vremenskih vektora ---
    t_v = (0:length(v)-1) * delta_t_v;
    t_d = (0:length(d)-1) * delta_t_d;

    % --- Interpolacija napona u vremenske ta?ke udaljenosti ---
    v_interp = interp1(t_v, v, t_d, 'linear');

    % --- Plot zavisnosti napona od udaljenosti ---
    figure;
    plot(d, v_interp, 'bo-', 'LineWidth', 1.5, 'MarkerSize', 6);
    xlabel('Udaljenost (cm)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Napon (V)', 'FontSize', 12, 'FontWeight', 'bold');
    title('Zavisnost napona od udaljenosti', 'FontSize', 14, 'FontWeight', 'bold');
    grid on;

end