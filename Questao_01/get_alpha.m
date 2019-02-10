%==========================================================================
% Universidade Federal de Minas Gerais
% Escola de Engenharia da UFMG
% Engenharia de Sistemas
%
% Autores:
%   Hernane Braga
%   Alexandre Ribeiro
%
% Nota:
%   Estima o valor �timo de 'alpha'. 
%   Primeiro � executado o algoritimo de busca irrestrita para escolher os
%   pontos e posteriormente � utilizado o m�todo da Se��o �urea para 
%   determinar o valor de alfa.
% =========================================================================


function alpha = get_alpha(fun, xo, d)

%Busca Irrestrita
    a = 0;
    b = 1e-3;
    epslon = 1e-2; %crit�rio de parada
    nfe  = 2; %n�mero de avalia��es da fun��o
    
    ta = feval(fun, xo + a*d);
    tb = feval(fun, xo + b*d);
    
    while (tb < ta)
        a = b;
        ta = tb;
        b = 2*b;
        tb = feval(fun, xo + b*d);
        nfe = nfe + 1;
    end
    if (nfe <= 3)
        a = 0;
    else
        a = a/2;
    end
        
%  Se��o �urea
    xa = b - 0.618*(b - a);
    xb = a + 0.618*(b - a);

    ta = feval(fun, xo + xa*d);
    tb = feval(fun, xo + xb*d);

while((b - a) > epslon)
    if(ta > tb)
        a = xa;
        xa = xb;
        xb = a + 0.618*(b - a);
        ta = tb;
        tb = feval(fun, xo + xb*d);
    else
        b = xb;
        xb = xa;
        xa = b - 0.618*(b - a);
        tb = ta;
        ta = feval(fun, xo + xa*d);
    end
end
    alpha = (a + b)/2;
end
