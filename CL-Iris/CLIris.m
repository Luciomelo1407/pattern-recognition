function CLIris 
  X = load("iris.txt");
  X = turn_one_hot(X);
  padroes = X(:,1:4);
  padroes(:,5) = ones(size(X(:,1),1),1);
  rotulos = X(:,5:7);
  w=(inv((padroes)'*padroes)*padroes')*rotulos;
  teste = padroes*w
  
end





function [X] = turn_one_hot(X)
  classes = X(:,5);
  X(:,5:7) = zeros(size(X(:,1)),3);
  index0 = find(classes==0);
  index1 = find(classes==1);
  index2 = find(classes==2);
  X(index0,5) = 1;
  X(index1,6) = 1;
  X(index2,7) = 1;
end

