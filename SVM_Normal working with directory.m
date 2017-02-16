

clc;
clear all;
close all;

listing = dir('C:\Users\Mosam\Desktop\Speech Processing part\STE\TIDIGITS\outputTest\*.wav');

    for g=1:length(listing);
        names{g} = listing(g).name;
    end
for xx=1:length(names) 
[x,Fs] = wavread([ 'C:\Users\Mosam\Desktop\Speech Processing part\STE\TIDIGITS\outputTest\' names{xx}]); 


%N = length(x); % signal length
%n = 0:N-1;
%ts = n*(1/Fs); % time for signal

%wintype = 'rectwin';
Nlen = 320;
Nshft = 160;

steng=calsteng(x,Nlen,Nshft);


%y=1/x;

disp([names{xx} num2str(length(steng))])
T = diff(steng(1:length(steng)));

t = (1/100)*max(steng);
max(T);
%M = max(find(abs(T) > (t)));
N = min(find(abs(T) > (t)))

S = fliplr(T);
%Sample=[T];
%OutSample=[];
%for lo=numel(Sample):-1:1
%OutSample=[OutSample Sample(lo)];
%end
%OutSample;
%OutSample = diff(steng(1:length(steng)));
s = (1/100)*max(steng);
max(S);
M = min(find(abs(S) > (s)));
ML = length(S)-M
%M = max(find(abs(OutSample) > (s)));

%find(T)
%M = max(find(T))

%N = min(find(T))


%idx = find(x>0);
%jumpidx = find(diff(idx)>5);

%out = (Nlen-1)/2:(N+Nlen-1)-(Nlen-1)/2;
%t = (out-(Nlen-1)/2)*(1/Fs);

%plot(ts,x); hold on;
%plot(steng(out),t,'r','Linewidth',2);

mo = length(x)/length(steng);

i = ML;
K = mo*i;

j = N;
L = mo*j;


ax1 = subplot(3,1,1);
plot(x); hold on;
%# vertical line
hx = graph2d.constantline(L, 'LineStyle',':', 'Color',[.7 .7 .7]);
changedependvar(hx,'x');
hx = graph2d.constantline(K, 'LineStyle',':', 'Color',[.7 .7 .7]);
changedependvar(hx,'x');
hold off;

title(names{xx})



subplot(3,1,2);
plot(steng,'r');


ax2 = subplot(3,1,3);
%axis([3500,9625,-1,1]);
plot(x);
xlim(ax2,[L K])



pause
%# horizontal line
%hy = graph2d.constantline(0, 'Color',[.7 .7 .7]);
%changedependvar(hy,'y');
        

end
 
 
