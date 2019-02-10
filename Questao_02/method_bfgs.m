%==========================================================================
% Universidade Federal de Minas Gerais
% Escola de Engenharia da UFMG
% Engenharia de Sistemas
%
% Autores:
%   Hernane Braga Pereira
%   Alexandre Ribeiro
% Nota:
%   Função que define o Método BFGS
% =========================================================================


function x = method_bfgs (fun, xo, e, xlimites)

% fun: função objetivo
% xo: vetor posição inicial [xo1 xo2 ... xon]
% e: precisão adotada pelo usuário
% xlimites: limites inferior e superior das variáveis 
%           [x1min x1max x2min x2max ... xnmin xnmax]
% xotimo: avaliacao da funcao objetivo no ponto otimo (x* = 1 e f(x*) = 0)
% número max de iterações = 200
%
% Teste:
% bfgs(@fobj1, [-1.2 1.0], 0.001, [-2 2 -2 2],0)
%   
% Funções:
% eye(x): constroi a matriz identidade
% length(x): retorna o tamanho do vetor x 
% inv(x): retorna a matriz inversa
% feval(x,y): permite que se tenha uma string (sequência de caracteres) como uma variável de entrada, como nome de uma outra função.

    k = 0; %Inicia o contador
    
    xo = xo(:); % Garante que seja um vetor coluna

    g = get_grad(fun, xo); 
    
    h = eye(length(xo)); %Matriz Identidade
    
    d = -inv(h)*g;             

    %caminho(k+1,:) = [xo' feval(fun, xo)];
    %percurso(fun, caminho, k, xlimites); 

    x = xo;
    
  
% Enquanto o ponto é maior que a precisão mais o ponto ótimo.  
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
    %xlabel('Número de iterações')
    %ylabel('Valor da função objectivo')



