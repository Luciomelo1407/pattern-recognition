%{
function [saida1, saida2, …] = nomeDaFuncao(entrada1, entrada2, …)
  % comentário: o que a função faz
  % corpo da função
  saida1 = …;  
  saida2 = …;
end
%}

%{
Remove os Padrões e rotulos de um dataSet X
%}

function iris_tree
  X = load('iris.txt');
  [padroes_1,padroes_2,padroes_3,padroes_4,rotulos] = separa_DS_5(X);
  [melhor_alfa_1,melhor_delta_1] = calculo_melhor_alfa(padroes_1,rotulos);
  [melhor_alfa_2,melhor_delta_2] = calculo_melhor_alfa(padroes_2,rotulos);
  [melhor_alfa_3,melhor_delta_3] = calculo_melhor_alfa(padroes_3,rotulos);
  [melhor_alfa_4,melhor_delta_4] = calculo_melhor_alfa(padroes_4,rotulos);
  %{
    melhor_alfa_1 = 5.5000
    melhor_delta_1 = 0.5572
    
    melhor_alfa_2 = 3.3000
    melhor_delta_2 = 0.2679
    
    melhor_alfa_3 = 1.9000
    melhor_delta_3 = 0.9183
    
    melhor_alfa_4 = 0.8000
    melhor_delta_4 = 0.9183
  %}

  melhor_alfa_t1 = melhor_alfa_3
  
  index_sim = find(padroes_3<=melhor_alfa_3);
  index_nao = find(padroes_3>melhor_alfa_3);
  
  
  N0_y = sum(rotulos(index_sim)==0);
  N1_y = sum(rotulos(index_sim)==1);
  N2_y = sum(rotulos(index_sim)==2);
  
  N0_n = sum(rotulos(index_nao)==0);
  N1_n = sum(rotulos(index_nao)==1);
  N2_n = sum(rotulos(index_nao)==2);
  %{
    N0_y = 50
    N1_y = 0
    N2_y = 0
    
    N0_n = 0
    N1_n = 50
    N2_n = 50
    para todos os registros padroes_3 todos <= melhor_alfa_t1 serão classe 0
  %}
  padroes_1_t2 = padroes_1(index_nao);
  padroes_2_t2 = padroes_2(index_nao);
  padroes_3_t2 = padroes_3(index_nao);
  padroes_4_t2 = padroes_4(index_nao);
  rotulos_t2 = rotulos(index_nao);
  
  [melhor_alfa_1,melhor_delta_1] = calculo_melhor_alfa(padroes_1_t2,rotulos_t2);
  [melhor_alfa_2,melhor_delta_2] = calculo_melhor_alfa(padroes_2_t2,rotulos_t2);
  [melhor_alfa_3,melhor_delta_3] = calculo_melhor_alfa(padroes_3_t2,rotulos_t2);
  [melhor_alfa_4,melhor_delta_4] = calculo_melhor_alfa(padroes_4_t2,rotulos_t2);
  %{
  melhor_alfa_1 = 6.1000
  melhor_delta_1 = 0.1605
  
  melhor_alfa_2 = 2.4000
  melhor_delta_2 = 0.058237
  
  melhor_alfa_3 = 4.7000
  melhor_delta_3 = 0.6574
  
  melhor_alfa_4 = 1.7000
  melhor_delta_4 = 0.6902
  %}
  melhor_alfa_t2 = melhor_alfa_4
  
  index_sim = find(padroes_4_t2<=melhor_alfa_t2);
  index_nao = find(padroes_4_t2>melhor_alfa_t2);
  
  N0_y = sum(rotulos_t2(index_sim)==0);
  N1_y = sum(rotulos_t2(index_sim)==1);
  N2_y = sum(rotulos_t2(index_sim)==2);
  
  N0_n = sum(rotulos_t2(index_nao)==0);
  N1_n = sum(rotulos_t2(index_nao)==1);
  N2_n = sum(rotulos_t2(index_nao)==2);
  
%{
  90%
  N0_y = 0
  N1_y = 49
  N2_y = 5
  
  97%
  N0_n = 0
  N1_n = 1
  N2_n = 45
  
  para todos os registros se o atributo 4 > melhor_alfa_4 será c;
  classe 2
%}
  
  
  prediction = zeros(length(X),1);
  for i = 1:length(rotulos)
    x3 = padroes_3(i);
    x4 = padroes_4(i);
    if x3 <= melhor_alfa_t1
      prediction(i) = 0;
      elseif x4 > melhor_alfa_t2
        prediction(i) = 2;
        else
          prediction(i) = 1;
    endif
  endfor
  
  acertos = sum(prediction==rotulos);
  taxa_acerto = acertos/length(rotulos);
  disp(["taxa de acertos: ",num2str(taxa_acerto*100),"%"])
  
end



function [padroes_1,padroes_2,padroes_3,padroes_4,rotulos] = separa_DS_5(X)
  padroes_1 = X(:,1);
  padroes_2 = X(:,2);
  padroes_3 = X(:,3);
  padroes_4 = X(:,4);
  rotulos = X(:,5);
end

function [padroes_1,rotulos] = separa_DS_1(X)
  padroes_1 = X(:,1);
  rotulos = X(:,2);
end

function [padroes_1,padroes_2,rotulos] = separa_DS_2(X)
  padroes_1 = X(:,1);
  padroes_2 = X(:,2);
  rotulos = X(:,3);
end

%{
Calcula impureza para determiando array de rotulos
%}

function [I] = calculo_impureza(rotulos) 
  
    p0 = sum(rotulos==0)/length(rotulos);
    p1 = sum(rotulos==1)/length(rotulos);
    p2 = sum(rotulos==2)/length(rotulos);
    I = p0*log2(1/(p0+eps())) + p1*log2(1/(p1+eps())) + p2*log2(1/(p2+eps()));
end

function [delta_I] = calcula_delta_I(I,rotulos_sim,rotulos_nao,tamanho)
  N_y = length(rotulos_sim);
  N_n = length(rotulos_nao);
  N_t = tamanho;
  
  I_y = calculo_impureza(rotulos_sim);
  I_n = calculo_impureza(rotulos_nao);
  
  delta_I = I - (N_y/N_t)*I_y - (N_n/N_t)*I_n;
end






function [melhor_alfa,melhor_delta] = calculo_melhor_alfa(padroes,rotulos)

  #ordena o padão
  [_,ordem] = sort(padroes);
  
  I = calculo_impureza(rotulos);
  
  melhor_alfa = 0;
  melhor_delta = 0;
  
  for i = 2:length(ordem)
    
    possivel_alfa = (padroes(ordem(i)) + padroes(ordem(i-1)))/2;
    
    #para Sim
    index_sim = find(padroes<=possivel_alfa);
    padroes_sim = padroes(index_sim);
    rotulos_sim = rotulos(index_sim);
    
    #paraNão:
    index_nao = find(padroes>possivel_alfa);
    padroes_nao = padroes(index_nao);
    rotulos_nao = rotulos(index_nao);
    
    I_y = calculo_impureza(padroes_sim);
    I_n = calculo_impureza(padroes_nao);
    
    #calculo delta_I
    delta_I = calcula_delta_I(I,rotulos_sim,rotulos_nao,length(padroes));
    
    if delta_I > melhor_delta
      melhor_delta = delta_I;
      melhor_alfa = possivel_alfa;
    end
    
  endfor
end
