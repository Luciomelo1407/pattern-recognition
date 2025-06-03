function CLIris_decidaGradiente
  X = load('iris.txt');
  [padroes,rotulos] = turn_one_hot(X);

  alfa = 0.0001;
  w = 0.01*rand(4,3);
  b = 0.01*rand(1,3);
  w(5,:) = b;
  
  for m = 1:10000
    l = padroes'*(padroes*w - rotulos);
    w = w - alfa*l;
  endfor
  
  f = padroes*w;
  f = f';
  
  predict = zeros(size(f,2),3);
  for i = 1:size(f,2)
    findClass = find(f(:,i)==max(f(:,i)));
    predict(i,findClass)= 1;
  endfor
  
  counter = 0;
  for i = 1:length(predict)
    if(predict(i,1)==rotulos(i,1) && predict(i,2)==rotulos(i,2) && predict(i,3)==rotulos(i,3))
      counter+=1;
    end
  endfor

  taxa_acertos = counter/150;

  disp(["taxa de acertos: ",num2str(taxa_acertos*100),"%"])
  
end

function [padroes,rotulos] = turn_one_hot(X)
  classes = X(:,5);
  X(:,5:7) = zeros(size(X(:,1),1),3);
  index0 = find(classes==0);
  index1 = find(classes==1);
  index2 = find(classes==2);
  X(index0,5) = 1;
  X(index1,6) = 1;
  X(index2,7) = 1;
  padroes = X(:,1:4);
  padroes(:,5) = ones(size(X(:,1),1),1);
  rotulos = X(:,5:7);
end
