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

function Arvore_de_Decisao_1
  
   X = load("sinteticos1.txt");

  [padroes_1,padroes_2,rotulos] = separa_DS_2(X); 
  
  
  #calculando qual alfa de qual atibuto será melhor para perguntar
  #alfa = 2.3508 impureza = 0.2203
  [melhor_alfa_1,melhor_delta_1] = calculo_melhor_alfa(padroes_1,rotulos);
  #alfa = -1.5536 impureza = 0.2895
  [melhor_alfa_2,melhor_delta_2] = calculo_melhor_alfa(padroes_2,rotulos);
  
  melhor_alfa_t1 = melhor_alfa_2;
  
  #separando os index sim e não
  index_sim = find(X(:,2)<=melhor_alfa_t1);
  rotulos_sim = rotulos(index_sim);
  index_nao = find(X(:,2)>melhor_alfa_t1);
  rotulos_nao = rotulos(index_nao);
  
  N0_y = sum(rotulos_sim==0);
  N1_y = sum(rotulos_sim==1);
  N0_n = sum(rotulos_nao==0);
  N1_n = sum(rotulos_nao==1);
  
  %{
    N0_y = 3
    N1_y = 250
    N0_n = 497
    N1_n = 250
    
    seja todos os valores no atributo 2 <= -1.5536 serão da classe 1
  %}

  #Separando novo set de dados
  padroes_1t2 = padroes_1(index_nao);
  padroes_2t2 = padroes_2(index_nao);
  rotulost2 = rotulos(index_nao);
  
  #Novo calculo de alfa para o toco 2
  [melhor_alfa_1,melhor_delta_1] = calculo_melhor_alfa(padroes_1t2,rotulost2);#alfa = 2.3402 impureza = 0.1514
  [melhor_alfa_2,melhor_delta_2] = calculo_melhor_alfa(padroes_2t2,rotulost2);#alfa = 5.3607 impureza = 0.8442
  #para o prox toco a melhor pergunta ainda é no atributo 1
  melhor_alfa_t2 = melhor_alfa_2;
  
  #separando os index sim e não
  index_sim = find(X(:,2)<=melhor_alfa_t2);
  rotulos_sim = rotulos(index_sim);
  index_nao = find(X(:,2)>melhor_alfa_t2);
  rotulos_nao = rotulos(index_nao);
  
  N0_y = sum(rotulos_sim==0)
  N1_y = sum(rotulos_sim==1)
  N0_n = sum(rotulos_nao==0)
  N1_n = sum(rotulos_nao==1)
  %{
  N0_y = 491
  N1_y = 250
  N0_n = 9
  N1_n = 250
  sejam os valores do atributo 2 > 5.3607 enstao a classe é 1
  %}
  
    ### VERIFICANDO A TAXA DE ACERTOS ####
  previsoes = zeros(length(rotulos),1);
  for i = 1:size(X,1)
    x2 = padroes_2(i);
    if x2<=melhor_alfa_t1
      previsoes(i) = 1;
    elseif x2 > melhor_alfa_t2
      previsoes(i) = 1;
    else
      previsoes(i) = 0;
    endif
  endfor
  
  n_acertos = sum(previsoes==rotulos);
  acuracia = n_acertos/length(rotulos);

  disp(["Taxa de acertos: ", num2str(100*acuracia), "%"]);
  
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
    I = p0*log2(1/(p0+eps())) + p1*log2(1/(p1+eps()));
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
