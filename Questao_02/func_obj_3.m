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
%   Define a função objetivo.
% =========================================================================


function F = func_obj_3(x)

global u p mi lambda g h

x=x(:);
h=[];
g=[];

f=x(1)^4 + 2*(x(1)^2)*x(2) + x(1)^2 + x(1)*(x(2)^2) - 2*x(1) + 4;
h(1)=(x(1)^2) + x(2)^2 - 2;
g(1)= 0.25*(x(1)^2) + 0.75*(x(2)^2) - 1;

%p = sum((max(0,g)).^2) + sum((h.^2)); % Funcao penalidade
p=sum(mi*g) + sum(lambda*h) + (u/2)*sum(max(0,g).^2) + (u/2)*sum((h.^2)); %função Lagrangeana Aumentada

F = f + p; %função objetivo penalizada

