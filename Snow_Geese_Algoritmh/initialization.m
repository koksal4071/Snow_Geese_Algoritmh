function X = initialization(SearchAgents_no, dim, ub, lb)
    % Arama ajanlarının başlangıç pozisyonlarını oluşturur
    X = rand(SearchAgents_no, dim) .* (ub - lb) + lb;
end