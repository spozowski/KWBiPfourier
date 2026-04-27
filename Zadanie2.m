clear;clc;
%% Zadanie 1
load rozbieg_wirnik.mat;
A = VCAP_DATA;
Fs = VCAP_SAMPLERATE;
k = 1/Fs;

x = A(:,1); %drgania premieszczeń w V
z = A(:,2); %sygnał znacznika obrotów

t_max = length(z)/(Fs);
t = 0:k:t_max-k;
x = (x/8)*1000; %um
N20 = Fs*20;
t20 = t(1:N20);
x20 = x(1:N20);

figure(1)
grid on;
plot(t20,x20,'r')
title('Wyskalowany przebieg czasowy')
xlabel('Czas')
ylabel('Przemieszczenie, um')

%% Zadanie 2 

n = length(x);
n_vector = 0:1:n;
f = Fs*(0:(n/2)-1)/n;
y = abs(fft(x))/(n/2);
y = y(1:n/2);

figure(2)
plot(f,y, 'b-')
title('Widmo amplitudowe sygnału x')
xlabel('Częstotliwość, Hz')
ylabel('Amplituda, m/s^2')
grid on;

%% Zadanie 3

x1 = x(Fs*4:Fs*5-1);
t1 = t(Fs*4:Fs*5-1);
z1 = z(Fs*4:Fs*5-1);

x2 = x(Fs*19:Fs*20-1);
t2 = t(Fs*19:Fs*20-1);
z2 = z(Fs*19:Fs*20-1);

x3 = x(Fs*35:Fs*36-1);
t3 = t(Fs*35:Fs*36-1);
z3 = z(Fs*35:Fs*36-1);

figure(3)
subplot(3,1,1)
plot(t1, x1, 'r')
title('Przebieg od 4 do 5 sekundy')
xlabel('Czas[s]')
ylabel('Przemieszczenie[um]')
grid on;
subplot(3,1,2)
plot(t2, x2, 'r')
title('Przebieg od 19 do 20 sekundy')
xlabel('Czas[s]')
ylabel('Przemieszczenie[um]')
grid on;
subplot(3,1,3)
plot(t3, x3, 'r')
title('Przebieg od 35 do 36 sekundy')
xlabel('Czas[s]')
ylabel('Przemieszczenie[um]')
grid on;

%% Zadanie 4

n1 = length(x1);
f1 = Fs*(0:(n1/2)-1)/n1;

y1 = abs(fft(x1))/(n1/2);
y1 = y1(1:n1/2);
y2 = abs(fft(x2))/(n1/2);
y2 = y2(1:n1/2);
y3 = abs(fft(x3))/(n1/2);
y3 = y3(1:n1/2);

figure(4);hold on;grid on;
plot(f1,y1,'r')
plot(f1,y2,'b')
plot(f1,y3,'g')

%% Zadanie 5

%ilości próbek w przedziałach czasowych

n1 = n_vector(Fs*4:Fs*5-1);
n2 = n_vector(Fs*19:Fs*20-1);
n3 = n_vector(Fs*35:Fs*36-1);

figure(5)
subplot(3,1,1)
plot(n1,z1, 'r')
title('Przebieg sygnału znacznika obrotów od 4 do 5 sekundy')
xlabel('Ilość próbek')
ylabel('Obroty')
subplot(3,1,2)
plot(n2,z2, 'r')
title('Przebieg sygnału znacznika obrotów od 19 do 20 sekundy')
xlabel('Ilość próbek')
ylabel('Obroty')
subplot(3,1,3)
plot(n3,z3, 'r')
title('Przebieg sygnału znacznika obrotów od 35 do 36 sekundy')
xlabel('Ilość próbek')
ylabel('Obroty')

% f1,f2,f3 częstotliwości obrotowe odpowiadające sygnalom x1,x2,x3

p1 = 10994 - 10668;
a1 = p1/2;
f1 = Fs/a1;

p2 = 49172-49059;
a2 = p2/2;
f2 = Fs/a2;

p3 = 90050 - 89976;
a3 = p3/2;
f3 = Fs/a3;

%% Zadanie 6

[S,F,T] = stft(x, Fs);

figure;
imagesc(T, F, abs(S));
axis xy;
xlabel('Czas [s]');
ylabel('Częstotliwość [Hz]');
title('Spektrogram (STFT)');
colorbar;

