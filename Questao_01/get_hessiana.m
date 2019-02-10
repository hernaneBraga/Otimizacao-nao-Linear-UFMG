%==========================================================================
% Universidade Federal de Minas Gerais
% Escola de Engenharia da UFMG
% Engenharia de Sistemas
%
% Autores:
%   Hernane Braga Pereira
%   Alexandre Ribeiro
%
%   Nota:
%   Estima a matriz hessiana de uma função no ponto especificado.
% =========================================================================


function h = get_hessiana (fun, x)

% Hessiana analítica da função 'func'
x=x(:); %Garante que x seja um vetor coluna
n_var = length(x);
delta = 1e-4;
E = eye(n_var); %Matriz identidade

for i=1:n_var
  h(:,i) = (get_grad(fun, x + delta * E(:,i)) - get_grad(fun, x))/delta;
end

