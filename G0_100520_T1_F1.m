clc; 
clear;

n = 255;
k = 247;
r = n - k;

%%% Exercício 2.6 %%%-----------------------------------------------------
non_power_of_2_indices = find(bitand(1:n, (1:n) - 1) ~= 0);  % índices que não são powers de 2
binary_m = dec2bin(non_power_of_2_indices, r);

P = flip(binary_m, 2) - '0';
I = eye(r);
H = [P; I];

%%% Exercício 2.7 %%%-----------------------------------------------------
index_min_col_sum_zero = index_find_3(H, n, k);
min_col_sum_zero = 3;

%%% Exercício 2.8 %%%-----------------------------------------------------
wav_filename = "Sindroma_G08_T1_F1";
Sindroma = load(wav_filename);
Sindroma = struct2cell(Sindroma);
Sindroma = cell2mat(Sindroma)';

num_rows = size(H, 1);
col_sum2_sind = [];

max_combinations = num_rows * (num_rows - 1) / 2;
col_sum2_sind = zeros(max_combinations, 2);  
combination_index = 1;

for i = 1:num_rows
    if compare(H(i, :), Sindroma)
        col_sum2_sind(combination_index, :) = [0, i];
        combination_index = combination_index + 1;
    end
    
    for j = i + 1:num_rows
        row_i = H(i, :);
        row_j = H(j, :);
        
        sum_ij = row_i + row_j;
        diff_ij = row_i - row_j;
        diff_ji = row_j - row_i;
        
        if compare(sum_ij, Sindroma)
            col_sum2_sind(combination_index, :) = [i, j];
            combination_index = combination_index + 1;
        end
        if compare(diff_ij, Sindroma)
            col_sum2_sind(combination_index, :) = [i, j];
            combination_index = combination_index + 1;
        end
        if compare(diff_ji, Sindroma)
            col_sum2_sind(combination_index, :) = [i, j];
            combination_index = combination_index + 1;
        end
    end
end

col_sum2_sind = col_sum2_sind(1:combination_index - 1, :);

clear i j k n r wav_filename Sindroma P I c row_i row_j sum_ij diff_ij diff_ji combination_index max_combinations binary_m non_power_of_2_indices num_rows;
save G0z_100520_T1_F1


%%% Função index_find_3 %%%-----------------------------------------------
function indices = index_find_3(H, n, k)
    column_sums = sum(H, 1);
    [~, sorted_indices] = sort(column_sums, 'ascend');
    indices = sorted_indices(1:3);
end

%%% Função isEqual %%%----------------------------------------------------
function isEqual = compare(vec1, vec2)
    isEqual = isequal(vec1, vec2);
end
