%==========================================================================
% Universidade Federal de Minas Gerais
% Escola de Engenharia da UFMG
% Engenharia de Sistemas
%
% Autores:
%   Hernane Braga Pereira
%   Alexandre Ribeiro
% Nota:
%   Estima, numericamente, o gradiente de uma função no ponto especificado.
%==========================================================================

function g = get_grad (fun, x)

% Gradiente da função 'fun' no ponto x

    delta = 1e-10;
    n = length(x);
    E = eye(n);

    for i=1:n
        g(i)= (feval (fun, x+delta*E(:,i)) - feval(fun,x))/delta;
    end

%tGarante que g seja um vetor coluna
    g = g(:);
