function CLIris_decidaGradiente
  X = load('iris.txt');
  [padroes,rotulos] = turn_one_hot(X);

  alfa = 0.001;
  w = 0.01*rand(4,1);
  b = 0.01*rand();
  w(5) = b;
  size(padroes)
  size(w)

  for m = 2:length(X)
    #w(m) = w(m-1)-alfa*
  endfor

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
