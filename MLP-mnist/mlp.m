function mlp
  clear all
  clc
  load("mnist_3000.mat");
  rotulos = X(:,1);
  rotulos = turn_one_hot(rotulos);
  padroes = X(:,2:end);
  %padroes = padroes/255;
  bias = ones(length(X),1);

  [padroes_treino,rotulos_treino,padroes_teste,rotulos_teste] = split4test(rotulos,padroes);

  %{
    TESTE DE SEPARACAO
    numero = 10
    im = reshape(padroes_treino(numero, :), 28, 28)';
    imshow(im, cmap = "gray")
    rotulos_treino(numero,:)
  %}

  w1 = randn(784,120);
  w2 = randn(120,84);
  w3 = randn(84,10);
  w4 = randn(10,10);

  b1 = randn(120);
  b2 = randn(84);
  b3 = randn(10);
  b4 = randn(10);

  for m=1:1
    randIndex = randperm(size(padroes_treino,1));
    for i = 1:size(padroes_treino,1)
      xi = padroes_treino(randIndex(i),:);
      yi = rotulos_treino(randIndex(i),:);
      #camada 1
      sum1 = xi*w1 + b1


    endfor
  endfor

endfunction

function out = turn_one_hot(rotulos)
  out = zeros(length(rotulos),max(+1));

  for i = 1:length(rotulos)
    out(i,rotulos(i)+1) = 1;
    endfor
endfunction

function [padroes_treino,rotulos_treino,padroes_teste,rotulos_teste] = split4test(rotulos,padroes)
  randIndex = randperm(length(rotulos));
  rotulos = rotulos(randIndex,:);
  padroes = padroes(randIndex,:);
  padroes_treino = padroes(1:floor(length(padroes)*0.7)-1,:);
  rotulos_treino = rotulos(1:floor(length(padroes)*0.7)-1,:);
  padroes_teste = padroes(floor(length(padroes)*0.7):end,:);
  rotulos_teste = rotulos(floor(length(padroes)*0.7):end,:);
endfunction

function y = logistica(x)
  y = 1./(1 + exp(-x));
endfunction


