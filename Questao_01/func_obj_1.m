%==========================================================================
% Universidade Federal de Minas Gerais
% Escola de Engenharia da UFMG
%
% Autores:
%   Hernane Braga
%   Alexandre Ribeiro
% Nota:
%   Define a função objetivo 1.1
% =========================================================================

function f = func_obj_1(x)

    f = 100*((x(2)-(x(1)^2))^2) + ((1-x(1))^2);   
