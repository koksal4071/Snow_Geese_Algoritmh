
function [Best_score, Best_pos, Cong_Curve] = GOOSE(SearchAgents_no, Max_IT, lb, ub, dim, fobj)
    % Initialize parameters
    Best_pos = zeros(1, dim);
    Best_score = inf; % For minimization problems
    M_T = inf;
    Cong_Curve = zeros(1, Max_IT);

    % Initialize positions of search agents
    X = initialization(SearchAgents_no, dim, ub, lb);
    D_G = zeros(SearchAgents_no, dim);
    loop = 0;

    % Main loop
    while loop < Max_IT
        for i = 1:size(X, 1)
            % Ensure agents stay within boundaries
            X(i, :) = min(max(X(i, :), lb), ub);

            % Calculate objective function for each search agent
            fitness = fobj(X(i, :));
            if fitness < Best_score
                Best_score = fitness;
                Best_pos = X(i, :);
            end
        end

        for i = 1:size(X, 1)
            pro = rand;
            rnd = rand;
            coe = min(rand(), 0.17);

            % Speed weight
            S_W = randi([5, 25]);

            % Time of arrival
            T_o_A_O = rand(1, dim);
            T_o_A_S = rand(1, dim);

            % Time calculations
            T_T = (mean(T_o_A_S) + mean(T_o_A_O)) / 2;
            T_A = T_T / 2;

            % Free fall speed and sound travel
            F_F_S = T_o_A_O .* sqrt(S_W) * 9.81;
            S_S = 343.2;
            D_S_T = S_S * T_o_A_S;
            D_G(i, :) = 0.5 * D_S_T;

            % Position update
            if rnd >= 0.5
                if pro > 0.2
                    if S_W >= 12
                        X(i, :) = Best_pos - F_F_S + D_G(i, :) * T_A^2;
                    else
                        X(i, :) = Best_pos + F_F_S .* D_G(i, :) * T_A^2 * coe;
                    end
                end
            else
                if M_T > T_T
                    M_T = T_T;
                end
                alpha = 2 - (loop / (Max_IT / 2));
                X(i, :) = Best_pos + randn(1, dim) .* (M_T * alpha);
            end
        end

        loop = loop + 1;
        Cong_Curve(loop) = Best_score;
    end
end

