audio_file = "ST_G8_T2.wav";

%%% Exercício 2.5 %%%

[fluxo_simbolos,fs] = audioread(audio_file);
n_bits = audioinfo(audio_file).BitsPerSample;

%%% Exercício 2.6 %%%

simb = unique(fluxo_simbolos);
total_symbols = numel(fluxo_simbolos);

% Calcular a probabilidade de cada símbolo
prob_simb = zeros(size(simb)); % Inicializar o vetor de probabilidades
for i = 1:numel(simb)
    prob_simb(i) = sum(fluxo_simbolos == simb(i)) / total_symbols;
end


%%% Exercício 2.7 %%%

figure;
histogram(fluxo_simbolos, 2^n_bits, 'Normalization', 'probability', 'FaceColor', 'g');
xlabel('Símbolos');
ylabel('Frequência Relativa');
title('Histograma');
grid on;

%%% Exercício 2.8 %%%

figure;
plot(simb,prob_simb);
xlabel('Símbolos');
ylabel('Probabilidade');
title('Função de Densidade de Probabilidade');
grid on;

%%% Exercício 2.9 %%%

% Símbolos menos prováveis
prob_simb_min = min(prob_simb);
idx_min = find(prob_simb == prob_simb_min); % Índices de todos os símbolos menos prováveis
simb_prob_min = simb(idx_min); % Símbolos menos prováveis

% Símbolos mais prováveis
prob_simb_max = max(prob_simb);
idx_max = find(prob_simb == prob_simb_max); % Índices de todos os símbolos mais prováveis
simb_prob_max = simb(idx_max); % Símbolos mais prováveis

%%% Exercício 2.11 %%%

[prob_simb_no_zero, sort_idx] = sort(prob_simb);
simb_no_zero = simb(sort_idx);

%%% Exercício 2.12 %%%

Entropia = -sum(prob_simb_no_zero .* log2(prob_simb_no_zero));
Conteudo_Decisao = log2(size(simb,1));
Redundancia = Conteudo_Decisao - Entropia;

%%% Exercício 2.15 %%%

R = fs*Entropia;
Rd = fs*Conteudo_Decisao;
Db_Redund = fs*Redundancia;