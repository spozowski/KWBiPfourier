clear;clc;

load drgania.mat

A = VCAP_DATA;
Fs = VCAP_SAMPLERATE;
czulosc = 100; % mV/g
g = 9.81;
x = A(:,1);

x1 = (x*1000/czulosc) * g;
z = A(:,2);

k = 1/Fs;
t_max = length(z)/Fs;
t = (0:k:t_max-k);

figure(1)
plot(t,x1, 'r-')
title('Przebieg czasowy sygnału')
xlabel('Czas, s')
ylabel('Przyspieszenie, m/s^2')
grid on;
 %% Zadanie 2

n = length(x1);
f = Fs*(0:(n/2)-1)/n;
y = abs(fft(x1))/(n/2);
y = y(1:n/2);

figure(2)
plot(f,y, 'b-')
title('Widmo amplitudowe sygnału x')
xlabel('Częstotliwość, Hz')
ylabel('Amplituda, m/s^2')
grid on;

%% Zadanie 3 

figure(3)
plot(z)

p = 895-600;
n1 = p/2;
f_0 = Fs/n1;

%% Zadanie 4

fod_1 = 99; %czestotliwosc odciecia 1
fod_2 = 101; %czestotliwosc odciecia 2 

N1 = 4; %rząd filtru
R1 = 40; % tłumienie w paśmie zaporowym, dB

Wst1 = fod_1/(Fs/2); %znormalizowana czestotliwosc odciecia 1 
Wst2 = fod_2/(Fs/2);

[B1,A1] = cheby2(N1,R1,[Wst1,Wst2],'stop');

figure(4)
freqz(B1,A1)

xp = filter(B1,A1,x1);

figure(5)
plot( t,xp, 'r')
grid on;
yp = abs(fft(xp)/(n/2));
yp = yp(1:n/2);

figure(6)
plot(f,yp, 'b')
grid on;

%% Zadanie 5 

harmoniczne = 50:50:400;
xp1 = x1;
for i = harmoniczne
    f_od_1 = i - 1;
    f_od_2 = i + 1;

    Wst_1 = f_od_1/(Fs/2);
    Wst_2 = f_od_2/(Fs/2);

    [B2, A2] = cheby2(N1, R1, [Wst_1, Wst_2], 'stop');
    
    xp1 = filter(B2, A2, xp1); 

   

end
figure(7)
freqz(B2,A2)


figure(8)
plot( t,xp1, 'r')
grid on;
yp1 = abs(fft(xp1)/(n/2));
yp1 = yp1(1:n/2);

figure(9)
plot(f,y,'r', f,yp1, 'b')
grid on;

%% Zostawiamy harmoniczne(może być na kolosie)
xp2 = x1;
for i = harmoniczne
    f_od_1 = i - 1;
    f_od_2 = i + 1;

    Wst_1 = f_od_1/(Fs/2);
    Wst_2 = f_od_2/(Fs/2);

    [B2, A2] = cheby2(N1, R1, [Wst_1, Wst_2]);
    
    xp2 = filter(B2, A2, xp2);
   
end
figure(8)
plot( t,xp2, 'r')
grid on;
yp2 = abs(fft(xp2)/(n/2));
yp2 = yp2(1:n/2);

figure(9)
plot(f,yp2, 'b')
grid on;