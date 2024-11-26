% Parametrelerin tanımlanması
SearchAgents_no = 30;   % Kaz sayısı (ajan sayısı)
Max_IT = 100;           % Maksimum iterasyon sayısı
lb = -10;               % Alt sınır
ub = 10;                % Üst sınır
dim = 5;                % Çözüm uzayının boyutu (değişken sayısı)



% Hedef test fonksiyonları

fobj = @(x) -20 * exp(-0.2 * sqrt(sum(x.^2) / length(x))) - exp(sum(cos(2 * pi * x)) / length(x)) + 20 + exp(1);
% fobj = @(x) 10 * length(x) + sum(x.^2 - 10 * cos(2 * pi * x));
% fobj = @(x) sum(x.^2);  % Sphere fonksiyonu

% Algoritmayı çalıştırma
[Best_score, Best_pos, Cong_Curve] = GOOSE(SearchAgents_no, Max_IT, lb, ub, dim, fobj);

% Sonuçların yazdırılması
disp('En iyi uygunluk değeri:');
disp(Best_score);
disp('En iyi pozisyon:');
disp(Best_pos);

% Uygunluk eğrisini çizdirme
figure;
plot(Cong_Curve, 'LineWidth', 2);
xlabel('İterasyon');
ylabel('Uygunluk Değeri');
title('Snow Geese Algoritması - Uygunluk Eğrisi');
