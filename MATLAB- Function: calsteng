function steng=calsteng(x,Nlen,Nshft)

% ************************************
% function steng=calsteng(x,Nlen,Nshft)
% ************************************
% Sep 4, 2006
%
% This function calculates the short-time energy of a given signal vector
% 'x', where the short-time parameters are given by 'Nlen' and 'Nshft'

if size(x,1)>size(x,2)
    x=x.';
end
lx=size(x,2);steng=[];
for i=1:Nshft:lx-Nlen
    tmp=x(:,i:i+Nlen-1);
    steng=[steng mean(tmp.*tmp,2)];
%     i=i+Nshft-1;
end
end
