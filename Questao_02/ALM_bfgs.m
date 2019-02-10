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
% Exemplo
% ALM_bfgs(@func_obj_3, [+3.0 +3.0], 0.01, [0 4 0 4])
% =========================================================================


function ALM_bfgs (fun, xo, e, xlimites)

%
% fun     : fun��o objetivo
% xo      : vetor solu��o inicial [xo1 xo2 ... xon]
% e       : precis�o adotada pelo usu�rio
% xlimites: limites inferior e superior das vari�veis 
%           [x1min x1max x2min x2max ... xnmin xnmax]
%

global u p mi lambda g h

u=1;  

mi= 0;

lambda=0;

alpha=2;  


% Contador de itera��es do m�todo
k = 0;

% Garante que xo seja um vetor coluna
xo=xo(:);

% Armazena o caminho percorrido em dire��o ao �timo
caminho(k+1,:) = [xo' feval(fun, xo)];

% Imprime o resultado da busca encontrado at� a itera��o k
percurso(fun, caminho, k, xlimites); 

x=xo;

% Crit�rio de parada: condi��o necess�ria de primeira ordem (||g|| = 0)
while (norm(u*p) >= e)            
    x = method_bfgs(fun, x, e ,xlimites);
    
    %calcula lambda e mi para o proximo ponto;
    mi = mi + u*max(g,(-mi/u));
    lambda = lambda + u*h;
    u=alpha*u;
    k=k+1;
    caminho(k+1,:) = [x' feval(fun, x)];
    
    % Atualiza o percusso em dire��o ao �timo
    percurso(fun, caminho, k, xlimites);    
end
fprintf('\n')

figure
plot(0:k,caminho(:,end),'k-','linewidth',2)
xlabel('N�mero de itera��es')
ylabel('Valor da fun��o objectivo')



