
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
  bias = ones(3000,1);
  padroes(:,785) = bias;
  
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
  C4(1:3,:)

  
  
  
end

function out = turn_one_hot(rotulos)
  out = zeros(length(rotulos),max(+1));
  
  for i = 1:length(rotulos)
    out(i,rotulos(i)+1) = 1;
    endfor
  end
