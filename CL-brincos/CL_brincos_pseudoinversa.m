function CL_brincos_pseudoinversa 
  X = load('brincos.txt');
  c1 = find(X(:,3)==1);
  c2 = find(X(:,3)==-1);
  #plot(X(c1),'r*',X(c2),'bo');
  padroes = X(:,1:2);
  padroes(:,3) = ones(size(X(:,1),1),1);
  rotulos = zeros(size(c1),2);
  rotulos(c1,1)=1;
  rotulos(c2,2)=1;
  
  w = inv(padroes'*padroes)*padroes'*rotulos;
  f = padroes*w;
  f = f';
  rotulos = rotulos';
  acertos = 0;
  
  for i =1:length(padroes(:,1))
    resultado = f(:,i);
    resposta = rotulos(:,i);
    if find(resultado==max(resultado)) == find(resposta==max(resposta))
      acertos+=1;
    endif
  endfor
  
  taxa_acertos = acertos / length(padroes);
  disp(['taxa de acertos: ',num2str(taxa_acertos*100),'%']) #100%
  
  end