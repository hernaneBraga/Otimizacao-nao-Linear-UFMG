%==========================================================================
% Universidade Federal de Minas Gerais
% Escola de Engenharia da UFMG
% Engenharia de Sistemas
%
% Autores:
%   Hernane Braga Pereira
%   Alexandre Ribeiro
%
% Nota:
%   Função que define o Método BFGS
% Teste para questão 1.1:
%   method_bfgs(@func_obj_1, [-1.0 1.5], 1e-2, [-2 2 -2 2])
%   method_bfgs(@func_obj_1, [-1.2 1.0], 1e-2, [-2 2 -2 2])
%
% Teste para questão 1.2:
%   method_bfgs(@func_obj_2, [0  0], 1e-2, [-2 2 -2 2])
%   method_bfgs(@func_obj_2, [0  -0.6], 1e-2, [-2 2 -2 2])
%==========================================================================

function method_bfgs (fun, xo, e, xlimites)

% fun: função objetivo
% xo: vetor posição inicial [xo1 xo2 ... xon]
% e: precisão adotada pelo usuário, no caso 0.001
% xlimites: limites inferior e superior das variáveis 
%           [x1min x1max x2min x2max ... xnmin xnmax]


% Contador de iterações do método
    k = 0;
    
% Garante que xo seja um vetor coluna
    xo = xo(:);

    
    g = get_grad(fun, xo);     
    h = eye(length(xo)); 
    d = -inv(h)*g;             

% Armazena o caminho percorrido em direção ao ótimo
    caminho(k+1,:) = [xo' feval(fun, xo)];
% Imprime o resultado da busca encontrado até a iteração k
    percurso(fun, caminho, k, xlimites); 

    x = xo;
      
    d = -h*g;   
    alpha = get_alpha(fun, x, d); 
    
% Critério de parada:
% Enquanto o ponto é maior que a precisão mais o ponto ótimo  
    while (abs( fun(x + alpha*d) - fun(x)) > e)       
        d = -h*g;   
        alpha = get_alpha(fun, x, d); 
        
        xvelho = x;
        gvelho = g;
        
        x = x + alpha*d;
        vk = xvelho - x;
        g = get_grad(fun, x);
        
        rk = gvelho - g;
        
        if(norm(rk) >= e || norm(vk) >= e)
            method_bfgs = (1 + ((rk'*h*rk)/(rk'*vk)))*((vk*vk')/(vk'*rk)) - (((vk*rk'*h)+(h*rk*vk'))/(rk'*vk));
        else
            method_bfgs = 0;
        end
        h = h + method_bfgs;                               
        k = k + 1;  % soma o contador                
        
        caminho(k+1,:) = [x' feval(fun, x)];   
        percurso(fun, caminho, k, xlimites);    
    end
    fprintf('\n')

    figure
    plot(0:k,caminho(:,end),'k-','linewidth',2)
    xlabel('Número de Iterações')
    ylabel('Valor da Função Objetivo')
