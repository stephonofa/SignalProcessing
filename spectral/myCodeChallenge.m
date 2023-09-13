%% Load in Variables
clc, clearvars, close all
load spectral_codeChallenge.mat

%% Plot Signal

figure(1), clf
subplot(4,1,1)
plot(time,signal, "LineWidth", 1)
xlabel("Time (s)")
title("Time-domain signal")

%% Compute Spectrogram

window_length = 500;
freqaxis = linspace(0,srate,window_length+1);
timeaxis = zeros(1,floor(length(time)/window_length)-1);
spcgrm = zeros(length(freqaxis), floor(length(time)/window_length)-1);

for i=1:floor(length(time)/window_length)-1
    wndow = signal(i*window_length:(i+1)*window_length);

    power = abs(fft(wndow)).^2;
    spcgrm(1:length(freqaxis), i) = power(1:length(freqaxis));
    timeaxis(i) = mean(time(i*window_length:(i+1)*window_length));
end

%% Plot Spectrogram

subplot(4,1,2:4)
imagesc(timeaxis,freqaxis,spcgrm)
set(gca, 'ylim', [0 40])
xlabel('Time (s)')
ylabel('Frequency (Hz)')
title("Timeseries Spectrogram")
colormap hot
axis xy