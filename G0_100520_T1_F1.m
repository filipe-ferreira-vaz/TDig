clear;
clf;
clc;
%%% Exercício 2.6 %%%-----------------------------------------------------

n = 255; 
k = 247;
r = n - k;

non_power_of_2_indices = find(bitand(1:n, (1:n) - 1) ~= 0); % indices that are not powers of 2
binary_m = dec2bin(non_power_of_2_indices, r); % convert indices to 8-bit binary strings

P = flip(binary_m, 2) - '0'; % reverse binary string and convert to numeric array
I = eye(r);
H = [P; I];

%%% Exercício 2.7 %%%-----------------------------------------------------

index_min_col_sum_zero = index_find_3(H,n,k);
min_col_sum_zero =3;

%2.8

wav_filename = "Sindroma_G05_T1_F1";
%converter para string
Sindroma = load(wav_filename);
Sindroma = struct2cell(Sindroma);
Sindroma = cell2mat(Sindroma)';


col_sum2_sind=[];

for i=1:length(H)
    if compare(H(i,:),Sindroma)
        aux = [0,i];
        col_sum2_sind = vertcat(col_sum2_sind,aux);
    end
    for j=i+1:length(H)     
        sum = 0;
        sum = H(i,:) + H(j,:);
     
        if compare(sum,Sindroma)
            aux = [i,j];
            col_sum2_sind = vertcat(col_sum2_sind,aux);
        end
        sum = H(i,:) - H(j,:);
     
        if compare(sum,Sindroma)
            aux = [i,j];
            col_sum2_sind = vertcat(col_sum2_sind,aux);

        end
        sum = H(j,:) - H(i,:);
     
        if compare(sum,Sindroma)
            aux = [i,j];
            col_sum2_sind = vertcat(col_sum2_sind,aux);
        end
    end
end
clear aux aux1 i j k m n sum wav_filename Sindroma I P c
save G0z_110669_T1_F1