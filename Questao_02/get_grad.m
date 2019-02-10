%==========================================================================
% Universidade Federal de Minas Gerais
% Escola de Engenharia da UFMG
% Engenharia de Sistemas
%
% Autores:
%   Hernane Braga Pereira
%   Alexandre Ribeiro
% Nota:
%   Estima o gradiente de uma função no ponto especificado
%==========================================================================

function g = get_grad (fun, x)

% Gradiente da função 'fun'

    delta = 1e-10;
    n = length(x);
    
    e = eye(n); %Matriz Identidade

    for i=1:n
        g(i)= (feval (fun, x+delta*e(:,i)) - feval(fun,x))/delta;
    end

%transforma o vetor e vetor coluna
    g = g(:);
