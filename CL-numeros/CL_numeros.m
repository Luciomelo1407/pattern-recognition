function CL_numeros
  X = load('numeros.txt');
  size(X);
  rotulos = X(:,257);
  padroes = X(:,1:256);
  padroes(:,257) = ones(length(padroes),1);
  rotulos = turn_one_hot(rotulos);

  w = 0.01*rand(257,size(rotulos,2));
  alfa = 0.00001;

  for i = 1:3500
    l = (padroes*w - rotulos)
    w = w-alfa*padroes'*l;
  endfor
  f = padroes*w;
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
  #taxa de acertos: 100%
  disp(['taxa de acertos: ',num2str(taxa_acertos*100),'%']);



end

function out = turn_one_hot(rotulos)
  out = zeros(length(rotulos),max(+1));
  
  for i = 1:length(rotulos)
    out(i,rotulos(i)+1) = 1;
    endfor
  end