function CL_brincos_pseudoinversa
  X = load('brincos.txt');
  c1 = find(X(:,3)==1);
  c2 = find(X(:,3)==-1);
  #plot(X(c1),'r*',X(c2),'bo');
  padroes = X(:,1:2);
  #padroes(:,3) = padroes(:,1).^2;
  #padroes(:,4) = padroes(:,2).^2;
  #padroes(:,5) = padroes(:,1).*padroes(:,2);
  #padroes(:,6) = padroes(:,4).*padroes(:,3);
  #padroes(:,3) = padroes(:,1).^3; #95%
  #padroes(:,4) = padroes(:,2).^3; #95%
  padroes(:,3) = sin(2*pi*1/10*padroes(:,1)); #96,4%
  padroes(:,4) = sin(2*pi*1/100*padroes(:,2)); #96,4%
  padroes(:,5) = ones(size(X(:,1),1),1);
  rotulos = zeros(length(c1),2);
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
