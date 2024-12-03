clear;
clf;
clc;
audio_file = "ST_G8_T2.wav";

%%% Exercício 2.5 %%%

[fluxo_simbolos,fs] = audioread(audio_file);
n_bits = audioinfo(audio_file).BitsPerSample;

%%% Exercício 2.6 %%%-----------------------------------------------------

simb = unique(fluxo_simbolos);
total_symbols = numel(fluxo_simbolos);

% Calcular a probabilidade de cada símbolo
prob_simb = zeros(size(simb)); % Inicializar o vetor de probabilidades
for i = 1:numel(simb)
    prob_simb(i) = sum(fluxo_simbolos == simb(i)) / total_symbols;
end


%%% Exercício 2.7 %%%-----------------------------------------------------

histogram(fluxo_simbolos, 2^n_bits, 'Normalization', 'probability', 'FaceColor', 'g');
xlabel('Símbolos');
ylabel('Frequência Relativa');
title('Histograma');
grid on;

%%% Exercício 2.8 %%%-----------------------------------------------------

figure;
plot(simb,prob_simb);
xlabel('Símbolos');
ylabel('Probabilidade');
title('Função de Densidade de Probabilidade');
grid on;

%%% Exercício 2.9 %%%-----------------------------------------------------

% Símbolos menos prováveis
prob_simb_min = min(prob_simb);
idx_min = find(prob_simb == prob_simb_min); % Índices de todos os símbolos menos prováveis
simb_prob_min = simb(idx_min); % Símbolos menos prováveis

% Símbolos mais prováveis
prob_simb_max = max(prob_simb);
idx_max = find(prob_simb == prob_simb_max); % Índices de todos os símbolos mais prováveis
simb_prob_max = simb(idx_max); % Símbolos mais prováveis

%%% Exercício 2.11 %%%-----------------------------------------------------

[prob_simb_no_zero, sort_idx] = sort(prob_simb);
simb_no_zero = simb(sort_idx);

%%% Exercício 2.12 %%%-----------------------------------------------------

Entropia = -sum(prob_simb_no_zero .* log2(prob_simb_no_zero));
Conteudo_Decisao = log2(size(simb,1));
Redundancia = Conteudo_Decisao - Entropia;

%%% Exercício 2.15 %%%-----------------------------------------------------

R = fs*Entropia;
Rd = fs*Conteudo_Decisao;
Db_Redund = fs*Redundancia;

%%% Exercício 2.17 %%%-----------------------------------------------------

simb_huff = flip(simb_no_zero);
prob_simb_huff = flip(prob_simb_no_zero);

[dict, L_med] = huffmandict(simb_huff, prob_simb_huff);

n = numel(simb_huff);

tabela_final = table('Size', [n, 4], 'VariableTypes', {'double', 'double', 'double', 'string'}, 'VariableNames', {'Symbol', 'Probability', 'NumBits', 'BinaryCode'});

for i = 1:n
    tabela_final.Symbol(i) = simb_huff(i);
    tabela_final.Probability(i) = prob_simb_huff(i);
    tabela_final.NumBits(i) = length(dict{i, 2});
    tabela_final.BinaryCode(i) = strjoin(string(dict{i, 2}), '');
end

%%% Exercício 2.18 %%%-----------------------------------------------------

Eficiencia = Entropia/L_med;

%%% Exercício 2.19 %%%-----------------------------------------------------

fluxo_bin = strings(length(fluxo_simbolos), 1);

for i = 1:length(fluxo_simbolos)
    row_idx = find([tabela_final{:, 1}] == fluxo_simbolos(i));
    
    binary_code = tabela_final{row_idx, 4};

    fluxo_bin(i) = binary_code;
end

%%% Exercício 2.20 %%%-----------------------------------------------------

n_fluxo_bin = sum(strlength(fluxo_bin));

%%% Exercício 2.21 %%%-----------------------------------------------------

R_cod_med = n_fluxo_bin / audioinfo(audio_file).Duration;

%%% Exercício 2.22 %%%-----------------------------------------------------

fluxo_simbolo_descod = zeros(length(fluxo_bin), 1);

posicao = 1;

for i = 1:length(fluxo_simbolo_descod)
    for j = 1:size(tabela_final, 1)
        codeword = tabela_final{j, 4};
        code_length = length(codeword);
        
        if strcmp(fluxo_bin(posicao:posicao+code_length-1), codeword)
            fluxo_simbolo_descod(i) = tabela_final{j, 1};
            
            posicao = posicao + code_length;
            
            break;
        end
    end
end

%%% Exercício 2.23 %%%-----------------------------------------------------

figure;
t = linspace(0,1,fs);
plot(t,fluxo_simbolo_descod(1:fs));
hold on
plot(t,fluxo_simbolos(1:fs));
grid on
xlabel('Tempo [s]');
ylabel('Amplitude');
legend('fluxo simbolos descod','fluxo simbolos');

%%%%%%%%%%%%%%%%%%%%%%-----------------------------------------------------
clear audio_file binary_code code_length codeword dict i idx_max idx_min j posicao prob_simb_huff row_idx simb_huff sort_idx t total_symbols n
save 100520_T1.mat