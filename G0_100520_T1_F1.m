clc;clear all;

%2.6
% hamming(7,4)
n = 255;
k = 247;

P = zeros(k,n-k);
I = eye(n-k);
c = 1:1:n;
m = zeros(k,1);

aux1=1;
for i=1:n
    if log2(c(i)) - round(log2(c(i))) ~=0
        m(aux1) = c(i);
        aux1 = aux1 + 1;
    end
end
m = dec2bin(m);
%aux = parity_sum(c);

for i=1:k
    aux = reverse(m(i,:));
    %bin = decimalToBinaryVector(bin2dec(aux(i)));
    for j=1:n-k    
        P(i,j) = str2num(aux(j));
    end
end

H = vertcat(P,I);

%2.7
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