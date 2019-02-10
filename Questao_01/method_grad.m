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
%   Função que define o Método Gradiente
%
% Teste para questão 1.1:
%   method_grad(@func_obj_1, [-1.0 1.5], 1e-2, [-2 2 -2 2])
%   method_grad(@func_obj_1, [-1.2 1.0], 1e-2, [-2 2 -2 2])
%
% Teste para questão 1.2:
%   method_grad(@func_obj_2, [0  0], 1e-2, [-2 2 -2 2])
%   method_grad(@func_obj_2, [0  -0.6], 1e-2, [-2 2 -2 2])
%==========================================================================

function method_grad (fun, xo, e, xlimites)

% fun: função objetivo
% xo: vetor posição inicial [xo1 xo2 ... xon]
% e: precisão adotada pelo usuário
% xlimites: limites inferior e superior das variáveis 
%           [x1min x1max x2min x2max ... xnmin xnmax]

% Contador de iterações do método
    k = 0;

% Garante que xo seja um vetor coluna
    xo = xo(:);
    
% Estima o grandiente da função no ponto xo
    g = get_grad(fun, xo);  
    
% Determina a direção de busca    
    d = -g; 

% Estima o valor de 'alpha' usando o Algoritmo da Seção Áurea
    alpha = get_alpha(fun, xo, d);

% Armazena o caminho percorrido em direção ao ótimo
    caminho(k+1,:) = [xo' feval(fun, xo)];

% Imprime o resultado da busca encontrado até a iteração k
    percurso(fun, caminho, k, xlimites); 

    x = xo;

while ( abs( fun(x + alpha*d) - fun(x)) > e) 
        %fprintf('\n --------- fun(x)', fun(x), '----- fun(x+1)',fun(x + alpha*d)  )
        x = x + alpha*d;                    
        g = get_grad(fun, x);     
        d = -g;                      
        k = k + 1;                 
    
    % Estima um novo valor para 'alpha'
        alpha = get_alpha(fun, x, d); 
    
    % Armazena o caminho percorrido em direção ao ótimo
        caminho(k+1,:) = [x' feval(fun, x)];    
    % Atualiza o percusso em direção ao ótimo
        percurso(fun, caminho, k, xlimites);   
    
end

fprintf('\n')
figure
plot(0:k,caminho(:,end),'k-','linewidth',2)
xlabel('Número de Iterações')
ylabel('Valor da Função Objetivo')
