

function diabete_tree
  X = load('diabeticos.txt');
  [padroes,rotulos] = separa_DS_1(X);
  [melhor_alfa,_] = calculo_melhor_alfa(padroes,rotulos);#127
  
  #Vendo a quantidade de elemento nas respostas
  index_sim = find(padroes<=melhor_alfa);
  index_nao = find(padroes>melhor_alfa);
  
  N0_y = sum(rotulos(index_sim)==0);
  N1_y = sum(rotulos(index_sim)==1);
  N0_n = sum(rotulos(index_nao)==0);
  N1_n = sum(rotulos(index_nao)==1);
  %{
  N0_y = 391
  N1_y = 94
  N0_n = 109
  N1_n = 174
  todos os elementos <= melhor_alfa serão da classe 0
  %}
  
  predicoes = zeros(length(padroes),1);
  for i = 1:length(padroes)
    x = padroes(i);
    if x <= melhor_alfa
      predicoes(i) = 0;
    else
      predicoes(i) = 1;
    endif
  endfor
  
  total_de_acertos = sum(predicoes==rotulos);
  taxa_de_acerto = total_de_acertos/length(predicoes);
  melhor_alfa
  disp(["taxa de acerto: ",num2str(taxa_de_acerto*100),"%"])
  
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
