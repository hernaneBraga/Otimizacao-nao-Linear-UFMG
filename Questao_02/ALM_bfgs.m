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
% fun     : função objetivo
% xo      : vetor solução inicial [xo1 xo2 ... xon]
% e       : precisão adotada pelo usuário
% xlimites: limites inferior e superior das variáveis 
%           [x1min x1max x2min x2max ... xnmin xnmax]
%

global u p mi lambda g h

u=1;  

mi= 0;

lambda=0;

alpha=2;  


% Contador de iterações do método
k = 0;

% Garante que xo seja um vetor coluna
xo=xo(:);

% Armazena o caminho percorrido em direção ao ótimo
caminho(k+1,:) = [xo' feval(fun, xo)];

% Imprime o resultado da busca encontrado até a iteração k
percurso(fun, caminho, k, xlimites); 

x=xo;

% Critério de parada: condição necessária de primeira ordem (||g|| = 0)
while (norm(u*p) >= e)            
    x = method_bfgs(fun, x, e ,xlimites);
    
    %calcula lambda e mi para o proximo ponto;
    mi = mi + u*max(g,(-mi/u));
    lambda = lambda + u*h;
    u=alpha*u;
    k=k+1;
    caminho(k+1,:) = [x' feval(fun, x)];
    
    % Atualiza o percusso em direção ao ótimo
    percurso(fun, caminho, k, xlimites);    
end
fprintf('\n')

figure
plot(0:k,caminho(:,end),'k-','linewidth',2)
xlabel('Número de iterações')
ylabel('Valor da função objectivo')



