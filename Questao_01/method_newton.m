%==========================================================================
% Universidade Federal de Minas Gerais
% Escola de Engenharia da UFMG
% Engenharia de Sistemas
%
% Autores:
%   Hernane Braga Pereira
%   Alexandre Ribeiro
%
%
%   Aproxima o ponto de �timo (minimiza��o) de um problema irrestrito
%   usando o Algoritmo do Newton modificado.
%
%
% Teste para quest�o 1.1:
%   method_newton(@func_obj_1, [-1.0 1.5], 1e-2, [-2 2 -2 2])
%   method_newton(@func_obj_1, [-1.2 1.0], 1e-2, [-2 2 -2 2])
%
% Teste para quest�o 1.2:
%   method_newton(@func_obj_2, [0  0], 1e-2, [-2 2 -2 2])
%   method_newton(@func_obj_2, [0  -0.6], 1e-2, [-2 2 -2 2])
%
% =========================================================================


function method_newton (fun, xo, e, xlimites)

%
% Sintaxe
% fun     : fun��o objetivo
% xo      : vetor solu��o inicial [xo1 xo2 ... xon]
% e       : precis�o adotada pelo usu�rio
% xlimites: limites inferior e superior das vari�veis 
%           [x1min x1max x2min x2max ... xnmin xnmax]
%



% Contador de itera��es do m�todo
k = 0;

% Garante que xo seja um vetor coluna
xo = xo(:);

g = get_grad(fun,xo);
H = get_hessiana(fun,xo);
%Inversa da Hessiana
Hinv = inv(H);
d = -Hinv * g;

% Estima o valor de 'alpha^*' usando o Algoritmo da Se��o �urea
alpha = get_alpha(fun, xo, d);

% Armazena o caminho percorrido em dire��o ao �timo
caminho(k+1,:) = [xo' feval(fun, xo)];

% Imprime o resultado da busca encontrado at� a itera��o k
percurso(fun, caminho, k, xlimites); 

x = xo;

% Crit�rio de parada: n�mero de itera��es maior que 200 ou a precis�o
% ser atendida.
while (abs(feval(fun,(x + alpha*d)) - feval(fun,(x))) > e)      
   
    x = x + alpha*d;            % Determina a nova solu��o
    g = get_grad(fun,x);
    H = get_hessiana(fun,x);
    Hinv = inv(H);
    d = -Hinv * g;
    k = k + 1;                  % Atualiza o contador
    
    % Estima um novo valor para 'alpha^*'
    alpha = get_alpha(fun, x, d);
    
    % Armazena o caminho percorrido em dire��o ao �timo
    caminho(k+1,:) = [x' feval(fun, x)];
    
    % Atualiza o percusso em dire��o ao �timo
    percurso(fun, caminho, k, xlimites);    
end
fprintf('\n')

figure
plot(0:k,caminho(:,end),'k-','linewidth',2)
xlabel('N�mero de Itera��es')
ylabel('Valor da Fun��o Objetivo')