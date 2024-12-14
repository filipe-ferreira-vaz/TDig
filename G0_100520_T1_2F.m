clc;
clear all;

load("G0z_100520_T1_F1.mat")

%%% Exercício 2.1 %%%-----------------------------------------------------

k = 247;
n = 255;
[a, b] = size(H);
P = H(1:a-(n-k),:);
G = [P eye(k)];

save("G0_100520_T1_2F_G.mat", 'G');

%%% Exercício 2.2 %%%-----------------------------------------------------

load("ST_Dados_G08_T1.mat")

%%% Exercício 2.3 %%%-----------------------------------------------------

m_aux = ST_Dados_G08_T3;
clear ST_Dados_G08_T3

c_vectors = zeros(length(m_aux)/k,n);

for i=1:length(m_aux)/k
    aux = m_aux((i-1)*k+1:i*k);
    c_vectors(i,:) = rem(aux*G,2);
end

n_vectors = size(c_vectors, 1);
c = reshape(c_vectors', [], n_vectors)';

save("G0_100520_T1_2F_C.mat", 'c');

%%% Exercício 2.5 %%%-----------------------------------------------------

e = zeros(length(c(:,1)), n);

for i=1:length(c(:,1))
    index=randi([1,n],1);
    e(i,index) = 1;
end

save("G0_100520_T1_2F_E.mat", 'e');

%%% Exercício 2.6 %%%-----------------------------------------------------
r = rem(c + e, 2);
save("G0_100520_T1_2F_R.mat", 'r');

%%% Exercício 2.7 %%%-----------------------------------------------------

s = rem(r*H,2);
save("G0_100520_T1_2F_S.mat", 's');

matrizmatch=zeros(n,length(s(:,1)));
for j=1:length(s(:,1))
    aux= s(j,:);
    for i = 1:n
        if isequal(H(i, :), aux)
            matrizmatch(i,j) = 1;
        end
    end
end

clear cnt cntt m_aux;