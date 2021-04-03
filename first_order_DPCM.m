clear
fm=4;   % message freq
fs=20*fm;  % sampling freq
am=2;      % amplitude of signal
t=-1:1/fs:1;
m=am*cos(2*pi*fm*t);

figure(1);      
subplot(311),plot(t,m,'r-'); hold on;
xlabel('Time');
ylabel('Amplitude');
title('Input sinusoidal signal');
 
for k=1:length(m)   
    if k==1
        d(k) = m(k);     %  at the first step there is no prediction(because don't have any previous information of signal)
        dq(k) = round(d(k));  % quantization
        q(k) = d(k) - dq(k);  % quantization error
        mq(k) = dq(k);        % first predicted message
    else
        d(k) = m(k)-mq(k-1);  % difference between the message and the previous one
        dq(k) = round(d(k));  % quantization
        q(k) = d(k) - dq(k);  % quantization error
        mq(k) = dq(k) + 0.85*mq(k-1); % predicted message (0.85 prediction constant)
    end
end

a =  m + q;  % message + quantization error

subplot(312),plot(t,a,'g-');hold on;
xlabel('Time');
ylabel('Amplitude');
title('Perfect Predictiom');
% Receiver
for k=1:length(m)
    if k==1
        mqr(k) = dq(k);  % first received signal
    else
        mqr(k) = dq(k) + 0.85*mqr(k-1);  % predicted signal + difference
    end
end
subplot(313),plot(t,mqr,'b-');
xlabel('Time');
ylabel('Amplitude');
title('Reconstructed signal');
figure(2)

plot(t,m,'r-'); hold on; 
plot(t,a,'g-');hold on; 
plot(t,mqr,'b-'); 
xlabel('Time');
ylabel('Amplitude');
legend('Message','Perfect Pr.','received signal')