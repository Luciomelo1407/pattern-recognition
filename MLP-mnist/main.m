
function main
  clear all
  clc
  load("mnist_3000.mat");
  %im = reshape(X(3, 2:end), 28, 28)';
  %imshow(im, cmap = "gray")
  rotulos = X(:,1);
  rotulos = turn_one_hot(rotulos);
  padroes = X(:,2:end);
  padroes = padroes/255;
  bias = ones(length(X),1);
  padroes(:,785) = bias;

  w1 = 1/100*rand(785,120);
  w2 = 1/100*rand(120,84);
  w3 = 1/100*rand(84,10);
  w4 = 1/100*rand(10,10);

  alfa = 0.01;

  [padroes_treino,rotulos_treino,padroes_teste,rotulos_teste] = split4test(rotulos,padroes);

  for m = 1:10
    randomIndex = randperm(size(padroes_treino,1));
    for i=1:size(randomIndex,1)
      xi = padroes_treino(randomIndex(i),:);
      yi = rotulos_treino(randomIndex(i),:);

      [c1,c2,c3,c4] = modelo(xi, w1, w2, w3, w4);

      e = c4 - yi;
      w4 = w4 - alfa*(c4 - yi);
      dw3 = (e*w4').*c3;
      w3 = w3 - alfa*(c2'*dw3);
      dw2 = (dw3*w3').*c2.*(1-c2);
      w2 = w2 - alfa*(c1'*dw2);
      dw1 = (dw2*w2').*c1.*(1-c1);
      w1 = w1 - alfa*(xi'*dw1);
    endfor
    [c1,c2,c3,c4] = modelo(padroes_treino, w1, w2, w3, w4);
    size(rotulos_treino);
    tamanhoc4 = size(c4);
    c413 = c4(1:3,:);
    somac413 = sum(c4(1:3,:),2);
    taxa_acerto = predicao(c4,rotulos_treino);

  endfor
taxa_acerto






end

function taxa_acertos = predicao(f,rotulos)
  f = f';
  rotulos = rotulos';
  acertos = 0;
  for i=1:size(rotulos,2)
    resultado = f(:,i);
    rotule = rotulos(:,i);
    if find(resultado==max(resultado)) == find(rotule==max(rotule))
    acertos+=1;
    endif
  endfor
  taxa_acertos = acertos / size(rotulos,2);
end

function [c1,c2,c3,c4] = modelo(xi, w1, w2, w3, w4)
      %camada 1
      sum1 = xi*w1;
      c1 = logistica(sum1);
      %camada 2
      sum2 = c1*w2;
      c2 = logistica(sum2);
      %camada 3
      sum3 = c2*w3;
      c3 = sum3;
      size(c3);
      %camada 4
      sum4 = c3*w4;
      c4 = exp(sum4)./sum(exp(sum4),2);
      size(c4);
  end

function y = logistica(x)
  y = 1./(1 + exp(-x));
endfunction

function [padroes_treino,rotulos_treino,padroes_teste,rotulos_teste] = split4test(rotulos,padroes)
  randIndex = randperm(length(rotulos));
  rotulos = rotulos(randIndex,:);
  padroes = padroes(randIndex,:);
  padroes_treino = padroes(1:floor(length(padroes)*0.7)-1,:);
  rotulos_treino = rotulos(1:floor(length(padroes)*0.7)-1,:);
  padroes_teste = padroes(floor(length(padroes)*0.7):end,:);
  rotulos_teste = rotulos(floor(length(padroes)*0.7):end,:);
  end

function out = turn_one_hot(rotulos)
  out = zeros(length(rotulos),max(+1));

  for i = 1:length(rotulos)
    out(i,rotulos(i)+1) = 1;
    endfor
  end

function bagunca
  w1 = 1/1000*rand(785,121);
  w2 = 1/1000*rand(121,85);
  w3 = 1/1000*rand(85,11);
  w4 = 1/1000*rand(11,10);

  #camada 1
  somatorioC1 = padroes*w1;
  size(somatorioC1);
  C1 = 1./(1+exp(-somatorioC1));

  #camada 2
  somatorioC2 = C1*w2;
  size(somatorioC2);
  C2 = 1./(1+exp(-somatorioC2));

  #camada 3
  somatorioC3 = C2*w3;
  size(somatorioC3);
  C3 = somatorioC3;

  #camada saída
  somatorioC4 = C3*w4;
  somatorioC4(1:3,:);
  C4 = exp(somatorioC4 - max(somatorioC4, [], 2)) ./ sum(exp(somatorioC4 - max(somatorioC4, [], 2)), 2);
  C4(1:3,:);
  end
