% Exercise 1
% Create an array that contains a periodic signal, which is generated from the sum of two sine and two cosine functions. 
% The frequency and amplitude of the sine and cosine components are arbitrary.
% Plot the resulting signal

Fs = 1000;                    
T = 1/Fs;                     
L = 1000;                     
t = (0:L-1)*T;                
x1 = 0.3*sin(2*pi*50*t) ;
x2=sin(2*pi*120*t) ;
y1=0.7*cos(2*pi*100*t);
y2=cos(2*pi*150*t);
sumsine= x1+x2;
sumcosine= y1+y2;
sum = sumsine + sumcosine;
subplot(3,1,1)
plot (sumsine(1:50),'c')
title('Sum Sine Signals')
subplot(3,1,2)
plot(sumcosine(1:50),'m')
title('Sum Cosine Signals ')
subplot(3,1,3)
plot(sum(1:50),'k')
title(' Sum Sine Signals + Sum Cosine Signals ')


% Exercise 2 
% Plot the resulting signal . Calculate the FFT components of the signal and plot them.

NFFT = 2^nextpow2(L);
sum_signal_fft = fft(sum,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
% Plot single-sided amplitude spectrum.
plot(f,2*abs(sum_signal_fft (1:NFFT/2+1))); 
title('Single-Sided Amplitude Spectrum of sum Signal')
xlabel('Frequency')
ylabel('|sum_signal_fft(f)|')


% Exercise 3. Add white noise to the original signal (sum signal) in MATLAB


signal_with_noise = awgn(sum,0.4,'measured'); % Add white Gaussian noise.
subplot(2,1,1)
plot (sum(1:50),'c')
title('Sum Sine Signals + Sum Cosine Signals')
subplot(2,1,2)
plot(signal_with_noise(1:50),'m')
title('Original signal and Signal with AWGN')

%  Exercise 4. Standardize the original and the noisy signal to have zero mean and unit variance. 
% Plot the resulting signals, In MATLAB
% This below: zero-mean by removing the average

a= sum - mean(sum);	
b= signal_with_noise - mean(signal_with_noise);
% This below, calculating unit variance
m = sum/(std(sum));	
n= (signal_with_noise)/(std(signal_with_noise));
% Normalized signal
sum_norm = (sum-mean(sum))/std(sum);
signal_with_noise_norm =( signal_with_noise - mean(signal_with_noise))/std(signal_with_noise);
subplot(2,1,1)
plot(sum_norm(1:50),'b')
title('Standardized sum Signal')
subplot(2,1,2)
plot(signal_with_noise(1:50),'m')
title(' Standardized c sum Signal + white noise ')

%  Exercise 5. Create two arbitrary signals as sum of sines and cosines and use a clustering algorithm 
%  to automatically classify them.
%  For clustering -> Using K-Means
%  Import "sumsine" & "sumcosine" from Exercise 1.

input=zeros(2,1000);
input(1,:)=sumsine;
input(2,:)=sumsine;
input4kmeans=input;
[idx,c]=kmeans(input4kmeans,1);
kmeans.cluster_centers_=c;
plot(kmeans.cluster_centers_,'ro')
title('Clusters Centers')
