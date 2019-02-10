%==========================================================================
% Universidade Federal de Minas Gerais
% Escola de Engenharia da UFMG
% Engenharia de Sistemas
%
% Autores:
%   Hernane Braga Pereira
%   Alexandre Ribeiro
% Nota:
%   Fun��o que define o M�todo BFGS
% =========================================================================


function x = method_bfgs (fun, xo, e, xlimites)

% fun: fun��o objetivo
% xo: vetor posi��o inicial [xo1 xo2 ... xon]
% e: precis�o adotada pelo usu�rio
% xlimites: limites inferior e superior das vari�veis 
%           [x1min x1max x2min x2max ... xnmin xnmax]
% xotimo: avaliacao da funcao objetivo no ponto otimo (x* = 1 e f(x*) = 0)
% n�mero max de itera��es = 200
%
% Teste:
% bfgs(@fobj1, [-1.2 1.0], 0.001, [-2 2 -2 2],0)
%   
% Fun��es:
% eye(x): constroi a matriz identidade
% length(x): retorna o tamanho do vetor x 
% inv(x): retorna a matriz inversa
% feval(x,y): permite que se tenha uma string (sequ�ncia de caracteres) como uma vari�vel de entrada, como nome de uma outra fun��o.

    k = 0; %Inicia o contador
    
    xo = xo(:); % Garante que seja um vetor coluna

    g = get_grad(fun, xo); 
    
    h = eye(length(xo)); %Matriz Identidade
    
    d = -inv(h)*g;             

    %caminho(k+1,:) = [xo' feval(fun, xo)];
    %percurso(fun, caminho, k, xlimites); 

    x = xo;
    
  
% Enquanto o ponto � maior que a precis�o mais o ponto �timo.  
   while (norm(g) >= e) 
        d = -h*g;   
        alpha = get_alpha(fun, x, d); 
        
        xvelho = x;
        gvelho = g;
        
        x = x + alpha*d;
        vk = xvelho - x;
        g = get_grad(fun, x);
        
        rk = gvelho - g;
        
        if(norm(rk) >= e || norm(vk) >= e)
            bfgs = (1 + ((rk'*h*rk)/(rk'*vk)))*((vk*vk')/(vk'*rk)) - (((vk*rk'*h)+(h*rk*vk'))/(rk'*vk));
        else
            bfgs = 0;
        end
        h = h + bfgs;   
                            
        k = k + 1;                  
        
        %caminho(k+1,:) = [x' feval(fun, x)];   
        %percurso(fun, caminho, k, xlimites);    
    end
    %fprintf('\n')

    %figure
    %0:k = [0,1,..., k]
    %plot(0:k,caminho(:,end),'k-','linewidth',2)
    %xlabel('N�mero de itera��es')
    %ylabel('Valor da fun��o objectivo')



