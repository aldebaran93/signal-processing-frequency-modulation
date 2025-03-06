%******************************************************
%      Funtionsetwurf zur Generierung von x_FM(t)     
%
%   Parameter definition:
%   - w_c : trägerfrequenz
%   - s_int : integrierter signal s(t)
%   - Fs : Signal Frequenz
%   - freqdev : Frequenzdeviation
%******************************************************

% Funktionsdefinition
function y = gen_FM(w_c,s_int,Fs,A)
    t = (0:1/Fs:((size(s_int,1)-1)/Fs))';
    t = t(:,ones(1,size(s_int,2)));
    phi=0;
    
    y = A*cos(w_c*t + s_int + phi);
end
