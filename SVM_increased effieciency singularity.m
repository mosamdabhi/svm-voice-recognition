% Author: Mosam

clc;
clear all;
close all;

listing = dir('C:\Users\Mosam\Desktop\Speech Processing part\STE\Increase Efficiency\Train1\*.wav');

for g=1:length(listing);
    names{g} = listing(g).name;
end

labels=[];
TrainingSet=[];
Accuracy=[];

for xx=1:length(listing);
    [x,Fs] = wavread([ 'C:\Users\Mosam\Desktop\Speech Processing part\STE\Increase Efficiency\Train1\' names{xx}]);
    
    
    
    %N = length(x); % signal length
    %n = 0:N-1;
    %ts = n*(1/Fs); % time for signal
    
    %wintype = 'rectwin';
    Nlen = 320;
    Nshft = 160;
    
    steng=calsteng(x,Nlen,Nshft);
    
    Characterstring = names{xx};
    Characterstring = Characterstring(1:end-4);
    thisLab = str2num([Characterstring(4)]);
    labels = [labels thisLab];
    GroupVariable = labels';
    
    
    
    %labels_row = cellstr(R)
    %y=1/x;
    
    %disp([names{xx} num2str(length(steng))])
    InitDiff = diff(steng(1:length(steng)));
    
    InitDiffthreshold = (1/100)*max(steng);
    max(InitDiff);
    %M = max(find(abs(T) > (t)));
    stengmin = min(find(abs(InitDiff) > (InitDiffthreshold)));
    
    FlippedInitDiff = fliplr(InitDiff);
    max(FlippedInitDiff);
    Thresholdcut = min(find(abs(FlippedInitDiff) > (InitDiffthreshold)));
    stengmax = length(FlippedInitDiff)-Thresholdcut;
    
    
    factor = length(x)/length(steng);
    
    %i = stengmax;
    xlimupper = factor*stengmax;
    
    %j = stengmin;
    xlimlower = factor*stengmin;
    
    
    ax1 = subplot(3,1,1);
    plot(x); hold on;
    %# vertical line
    hx = graph2d.constantline(xlimlower, 'LineStyle',':', 'Color',[.7 .7 .7]);
    changedependvar(hx,'x');
    hx = graph2d.constantline(xlimupper, 'LineStyle',':', 'Color',[.7 .7 .7]);
    changedependvar(hx,'x');
    hold off;
    
    title(names{xx})
    
    
    
    subplot(3,1,2);
    plot(steng,'r');
    
    
    ax2 = subplot(3,1,3);
    %axis([3500,9625,-1,1]);
    plot(x);
    xlim(ax2,[xlimlower xlimupper]);
    
    Tw = 25;                % analysis frame duration (ms)
    Ts = 10;                % analysis frame shift (ms)
    alpha = 0.97;           % preemphasis coefficient
    M = 20;                 % number of filterbank channels
    C = 12;                 % number of cepstral coefficients
    L = 22;                 % cepstral sine lifter parameter
    LF = 300;               % lower frequency limit (Hz)
    HF = 3700;              % upper frequency limit (Hz)
    wav_file = ([ 'C:\Users\Mosam\Desktop\Speech Processing part\STE\Increase Efficiency\Train1\' names{xx}]);   % input audio filename
    
    [ speech, fs, nbits ] = wavread( wav_file );
    
    
    % Feature extraction (feature vectors as columns)
    [ MFCCs, FBEs, frames ] = ...
        mfcc( speech, fs, Tw, Ts, alpha, @hamming, [LF HF], M, C+1, L );
    
    
    % Generate data needed for plotting
    [ Nw, NF ] = size( frames );                % frame length and number of frames
    time_frames = [0:NF-1]*Ts*0.001+0.5*Nw/fs;  % time vector (s) for frames
    time = [ 0:length(speech)-1 ]/fs;           % time vector (s) for signal samples
    logFBEs = 20*log10( FBEs );                 % compute log FBEs for plotting
    logFBEs_floor = max(logFBEs(:))-50;         % get logFBE floor 50 dB below max
    logFBEs( logFBEs<logFBEs_floor ) = logFBEs_floor; % limit logFBE dynamic range
    
    
    % Generate plots
    %figure('Position', [30 30 800 600], 'PaperPositionMode', 'auto', ...
     %   'color', 'w', 'PaperOrientation', 'landscape', 'Visible', 'on' );
    
    ax2 = subplot(3,1,1);
    plot(x);
    xlim(ax2,[xlimlower xlimupper])
    xlabel( 'Time (s)' );
    ylabel( 'Amplitude' );
    title( 'Speech waveform');
    
    subplot(3,1,2);
    imagesc( time_frames, [1:M], logFBEs );
    axis( 'xy' );
    xlim( [ min(time_frames) max(time_frames) ] );
    xlabel( 'Time (s)' );
    ylabel( 'Channel index' );
    title( 'Log (mel) filterbank energies');
    
    subplot(3,1,3);
    imagesc( time_frames, [1:C], MFCCs(2:end,:) ); % HTK's TARGETKIND: MFCC
    %imagesc( time_frames, [1:C+1], MFCCs );       % HTK's TARGETKIND: MFCC_0
    %R = imagesc
    
    axis( 'xy' );
    xlim( [ min(time_frames) max(time_frames) ] )
    xlabel( 'Time (s)' );
    ylabel( 'Cepstrum index' );
    title( 'Mel frequency cepstrum' );
    Energy = MFCCs';
    R1 = Energy;
    R1 = R1(1:15:length(Energy),:);
    
    
    %Energy = MFCCs(4,:);
    %R2 = Energy';
    %R1 = R2;
    
    %Feature1 = var(R1);
    %Feature2 = mean(R1);
    %CovarianceFeat = cov(R1);
    %Feature3 = CovarianceFeat(:)';
    %Feature4 = std(R1);
    %CorrcoefFeat = corrcoef(R1);
    %Feature5 = CorrcoefFeat(:)';
    %Feature6 = mode(R1);
    %Feature7 = median(R1);
    %Feature8 = min(R1);
    %Feature9 = max(R1);
    %NetFeatures = [Feature1 Feature2 Feature3 Feature4 Feature6 Feature7 Feature8 Feature9];
    
    
    
    TrainingSet = [R1; TrainingSet];
    
    
end

labels_rows = GroupVariable(1,:);
labels_appending_matrix = [];
for i1=1:size(TrainingSet,1)
    labels_appending_matrix = [labels_rows; labels_appending_matrix]; 
end

listing3 = dir('C:\Users\Mosam\Desktop\Speech Processing part\STE\Increase Efficiency\Train2\*.wav');

for g3=1:length(listing3); 
    names{g3} = listing3(g3).name;
end

TrainingSet_Train2=[];
labels3=[];


for xx3=1:length(listing3);
    [x3,Fs] = wavread([ 'C:\Users\Mosam\Desktop\Speech Processing part\STE\Increase Efficiency\Train2\' names{xx3}]);
    
    
    
    %N = length(x); % signal length
    %n = 0:N-1;
    %ts = n*(1/Fs); % time for signal
    
    %wintype = 'rectwin';
    Nlen = 320;
    Nshft = 160;
    
    steng3=calsteng(x3,Nlen,Nshft);
    
    Characterstring3 = names{xx3};
    Characterstring3 = Characterstring3(1:end-4);
    thisLab3 = str2num([Characterstring3(4)]);
    labels3 = [labels3 thisLab3];
    GroupVariable3 = labels3';
    
    
    InitDiff3 = diff(steng3(1:length(steng3)));
    
    InitDiffthreshold3 = (1/100)*max(steng3);
    max(InitDiff3);
    %M = max(find(abs(T) > (t)));
    stengmin3 = min(find(abs(InitDiff3) > (InitDiffthreshold3)));
    
    FlippedInitDiff3 = fliplr(InitDiff3);
    max(FlippedInitDiff3);
    Thresholdcut3 = min(find(abs(FlippedInitDiff3) > (InitDiffthreshold3)));
    stengmax3 = length(FlippedInitDiff3)-Thresholdcut3;
    
    
    factor3 = length(x3)/length(steng3);
    
    %i = stengmax;
    xlimupper3 = factor3*stengmax3;
    
    %j = stengmin;
    xlimlower3 = factor3*stengmin3;
    
    
    ax123 = subplot(3,1,1);
    plot(x3); hold on;
    %# vertical line
    hx3 = graph2d.constantline(xlimlower3, 'LineStyle',':', 'Color',[.7 .7 .7]);
    changedependvar(hx3,'x');
    hx3 = graph2d.constantline(xlimupper3, 'LineStyle',':', 'Color',[.7 .7 .7]);
    changedependvar(hx3,'x');
    hold off;
    
    title(names{xx3})
    
    
    
    subplot(3,1,2);
    plot(steng3,'r');
    
    
    ax223 = subplot(3,1,3);
    %axis([3500,9625,-1,1]);
    plot(x3);
    xlim(ax223,[xlimlower3 xlimupper3])
    
    Tw = 25;                % analysis frame duration (ms)
    Ts = 10;                % analysis frame shift (ms)
    alpha = 0.97;           % preemphasis coefficient
    M = 20;                 % number of filterbank channels
    C = 12;                 % number of cepstral coefficients
    L = 22;                 % cepstral sine lifter parameter
    LF = 300;               % lower frequency limit (Hz)
    HF = 3700;              % upper frequency limit (Hz)
    wav_file = ([ 'C:\Users\Mosam\Desktop\Speech Processing part\STE\Increase Efficiency\Train2\' names{xx3}]);   % input audio filename
    
    [ speech3, fs3, nbits3 ] = wavread( wav_file );
    
    
    % Feature extraction (feature vectors as columns)
    [ MFCCs3, FBEs3, frames3 ] = ...
        mfcc( speech3, fs3, Tw, Ts, alpha, @hamming, [LF HF], M, C+1, L );
    
    
    % Generate data needed for plotting
    [ Nw3, NF3 ] = size( frames3 );                % frame length and number of frames
    time_frames3 = [0:NF3-1]*Ts*0.001+0.5*Nw3/fs3;  % time vector (s) for frames
    time3 = [ 0:length(speech3)-1 ]/fs3;           % time vector (s) for signal samples
    logFBEs3 = 20*log10( FBEs3 );                 % compute log FBEs for plotting
    logFBEs_floor3 = max(logFBEs3(:))-50;         % get logFBE floor 50 dB below max
    logFBEs3( logFBEs3<logFBEs_floor3 ) = logFBEs_floor3; % limit logFBE dynamic range
    
    
    % Generate plots
    %figure('Position', [30 30 800 600], 'PaperPositionMode', 'auto', ...
     %   'color', 'w', 'PaperOrientation', 'landscape', 'Visible', 'on' );
    
    ax223 = subplot(3,1,1);
    plot(x3);
    xlim(ax223,[xlimlower3 xlimupper3]);
    xlabel( 'Time (s)' );
    ylabel( 'Amplitude' );
    title( 'Speech waveform');
    
    subplot(3,1,2);
    imagesc( time_frames3, [1:M], logFBEs3 );
    axis( 'xy' );
    xlim( [ min(time_frames3) max(time_frames3) ] );
    xlabel( 'Time (s)' );
    ylabel( 'Channel index' );
    title( 'Log (mel) filterbank energies');
    
    subplot(3,1,3);
    imagesc( time_frames3, [1:C], MFCCs3(2:end,:) ); % HTK's TARGETKIND: MFCC
    %imagesc( time_frames, [1:C+1], MFCCs );       % HTK's TARGETKIND: MFCC_0
    %R = imagesc
    
    axis( 'xy' );
    xlim( [ min(time_frames3) max(time_frames3) ] );
    xlabel( 'Time (s)' );
    ylabel( 'Cepstrum index' );
    title( 'Mel frequency cepstrum' );
    Energy3 = MFCCs3';
    R3 = Energy3;
    R3 = R3(1:15:length(Energy3),:);
    
    %R223 = Energy3';
    
    
    %R123 = R223;
    
    %Feature1_3 = var(R123);
    %Feature2_3 = mean(R123);
    %CovarianceFeat = cov(R123);
    %Feature3_3 = CovarianceFeat(:)';
    %Feature4_3 = std(R123);
    %CorrcoefFeat = corrcoef(R12);
    %Feature5_2 = CorrcoefFeat(:)';
    %Feature6_3 = mode(R123);
    %Feature7_3 = median(R123);
    %Feature8_3 = min(R123);
    %Feature9_3 = max(R123);
    %NetFeatures1_3 = [Feature1_3 Feature2_3 Feature3_3 Feature4_3 Feature6_3 Feature7_3 Feature8_3 Feature9_3];
    
    
    
    TrainingSet_Train2 = [R3; TrainingSet_Train2];
 
    
end


labels_rows3 = GroupVariable3(1,:);
labels_appending_matrix3 = [];
for i3=1:size(TrainingSet_Train2,1)
    labels_appending_matrix3 = [labels_rows3; labels_appending_matrix3]; 
end

net_TrainingSet = [TrainingSet; TrainingSet_Train2];
net_Labels = [labels_appending_matrix; labels_appending_matrix3];
trainedSVM = svmtrain(net_TrainingSet,net_Labels);


testSet = dir('C:\Users\Mosam\Desktop\Speech Processing part\STE\Singular_testing\*.wav');

for g2=1:length(testSet); 
    names{g2} = testSet(g2).name;
end

TrainingSet_Test=[];
output=[];
labels2=[];
for xx2=1:length(testSet);
    [x2,Fs] = wavread([ 'C:\Users\Mosam\Desktop\Speech Processing part\STE\Singular_testing\' names{xx2}]);
    
    
    
    %N = length(x); % signal length
    %n = 0:N-1;
    %ts = n*(1/Fs); % time for signal
    
    %wintype = 'rectwin';
    Nlen = 320;
    Nshft = 160;
    
    steng2=calsteng(x2,Nlen,Nshft);
    
    Characterstring2 = names{xx2};
    Characterstring2 = Characterstring2(1:end-4);
    thisLab2 = str2num([Characterstring2(4)]);
    labels2 = [labels2 thisLab2];
    GroupVariable2 = labels2';
    
    
    InitDiff2 = diff(steng2(1:length(steng2)));
    
    InitDiffthreshold2 = (1/100)*max(steng2);
    max(InitDiff2);
    %M = max(find(abs(T) > (t)));
    stengmin2 = min(find(abs(InitDiff2) > (InitDiffthreshold2)));
    
    FlippedInitDiff2 = fliplr(InitDiff2);
    max(FlippedInitDiff2);
    Thresholdcut2 = min(find(abs(FlippedInitDiff2) > (InitDiffthreshold2)));
    stengmax2 = length(FlippedInitDiff2)-Thresholdcut2;
    
    
    factor2 = length(x2)/length(steng2);
    
    %i = stengmax;
    xlimupper2 = factor2*stengmax2;
    
    %j = stengmin;
    xlimlower2 = factor2*stengmin2;
    
    
    ax12 = subplot(3,1,1);
    plot(x2); hold on;
    %# vertical line
    hx2 = graph2d.constantline(xlimlower2, 'LineStyle',':', 'Color',[.7 .7 .7]);
    changedependvar(hx2,'x');
    hx2 = graph2d.constantline(xlimupper2, 'LineStyle',':', 'Color',[.7 .7 .7]);
    changedependvar(hx2,'x');
    hold off;
    
    title(names{xx2})
    
    
    
    subplot(3,1,2);
    plot(steng2,'r');
    
    
    ax22 = subplot(3,1,3);
    %axis([3500,9625,-1,1]);
    plot(x2);
    xlim(ax22,[xlimlower2 xlimupper2])
    
    Tw = 25;                % analysis frame duration (ms)
    Ts = 10;                % analysis frame shift (ms)
    alpha = 0.97;           % preemphasis coefficient
    M = 20;                 % number of filterbank channels
    C = 12;                 % number of cepstral coefficients
    L = 22;                 % cepstral sine lifter parameter
    LF = 300;               % lower frequency limit (Hz)
    HF = 3700;              % upper frequency limit (Hz)
    wav_file = ([ 'C:\Users\Mosam\Desktop\Speech Processing part\STE\Singular_testing\' names{xx2}]);   % input audio filename
    
    [ speech2, fs2, nbits2 ] = wavread( wav_file );
    
    
    % Feature extraction (feature vectors as columns)
    [ MFCCs2, FBEs2, frames2 ] = ...
        mfcc( speech2, fs2, Tw, Ts, alpha, @hamming, [LF HF], M, C+1, L );
    
    
    % Generate data needed for plotting
    [ Nw2, NF2 ] = size( frames2 );                % frame length and number of frames
    time_frames2 = [0:NF2-1]*Ts*0.001+0.5*Nw2/fs2;  % time vector (s) for frames
    time2 = [ 0:length(speech2)-1 ]/fs2;           % time vector (s) for signal samples
    logFBEs2 = 20*log10( FBEs2 );                 % compute log FBEs for plotting
    logFBEs_floor2 = max(logFBEs2(:))-50;         % get logFBE floor 50 dB below max
    logFBEs2( logFBEs2<logFBEs_floor2 ) = logFBEs_floor2; % limit logFBE dynamic range
    
    
    % Generate plots
    %figure('Position', [30 30 800 600], 'PaperPositionMode', 'auto', ...
     %   'color', 'w', 'PaperOrientation', 'landscape', 'Visible', 'on' );
    
    ax22 = subplot(3,1,1);
    plot(x2);
    xlim(ax22,[xlimlower2 xlimupper2]);
    xlabel( 'Time (s)' );
    ylabel( 'Amplitude' );
    title( 'Speech waveform');
    
    subplot(3,1,2);
    imagesc( time_frames2, [1:M], logFBEs2 );
    axis( 'xy' );
    xlim( [ min(time_frames2) max(time_frames2) ] );
    xlabel( 'Time (s)' );
    ylabel( 'Channel index' );
    title( 'Log (mel) filterbank energies');
    
    subplot(3,1,3);
    imagesc( time_frames2, [1:C], MFCCs2(2:end,:) ); % HTK's TARGETKIND: MFCC
    %imagesc( time_frames, [1:C+1], MFCCs );       % HTK's TARGETKIND: MFCC_0
    %R = imagesc
    
    axis( 'xy' );
    xlim( [ min(time_frames2) max(time_frames2) ] );
    xlabel( 'Time (s)' );
    ylabel( 'Cepstrum index' );
    title( 'Mel frequency cepstrum' );
     
    Energy2 = MFCCs2'
    %Energy2 = MFCCs2';
    %R2 = Energy2;
    %R2 = R2(1:15:length(Energy2),:);
    
    
    
    
    TrainingSet_Test = [Energy2; TrainingSet_Test];
 
   

    
end

%net_TrainingSet = [TrainingSet; TrainingSet_Train2];


labels_rows2 = GroupVariable2(1,:);
labels_appending_matrix2 = [];
for i2=1:size(TrainingSet_Test,1)
    labels_appending_matrix2 = [labels_rows2; labels_appending_matrix2]; 
end



%trainedSVM = svmtrain(net_TrainingSet,net_Labels);
for i=1:size(TrainingSet_Test,1)
    tmp = svmclassify(trainedSVM,TrainingSet_Test(i,:));
    output = [output tmp];
end
 %TRY=[];
 output = mode(output)
 %acctf = ((output-labels2)./labels2);
 %accsum = sum(((acctf')/i)*100);
 %accuracy = 100 - accsum;
 TRY = [output' labels_appending_matrix2(1,:)];
 EVAL = Evaluate(labels_appending_matrix2(1,:),output'); 
 %stats = confusionmatStats(labels2,output);

%Accuracy = [output-labels]
%[svmstruct,level] = Train_DSVM(TrainingSet,GroupVariable)
