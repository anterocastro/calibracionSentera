clear all; close all; clc

I_telas_NIR = imread('telas_NIR.jpg');
I_telas_R = imread('telas_rgb.jpg');
I_teflon_NIR = imread('teflon_NIR.jpg');
I_teflon_R = imread('teflon_RGB.jpg');


NDVI_gris = 0.477;
NDVI_negra= 0.863;
NDVI_roja = 0.098; 
NDVI_teflon = 0;

p_teflon_NIR = mean(mean(I_teflon_NIR(1597:1621,1939:2044,3)));
p_teflon_R = mean(mean(I_teflon_R(1467:1483,1953:2077,1)));
n4 = p_teflon_NIR;
r4 = p_teflon_R;

p_tela_gris_NIR =  mean(mean(I_telas_NIR(1491:1574,1672:1783,3)));
p_tela_gris_R =  mean(mean(I_telas_R(1334:1421,1631:1750,1)));
n3=p_tela_gris_NIR;
r3=p_tela_gris_R;

p_tela_negra_NIR = mean(mean(I_telas_NIR(1525:1617,1508:1631,3))); 
p_tela_negra_R = mean(mean(I_telas_R(1340:1463,1443:1594,1)));
n2=p_tela_negra_NIR;
r2=p_tela_negra_R;

p_tela_roja_NIR =mean(mean(I_telas_NIR(1570:1645,1358:1459,3)));
p_tela_roja_R = mean(mean(I_telas_R(1392:1463,1319:1414,1)));
n1=p_tela_roja_NIR;
r1=p_tela_roja_R;

A=[n1,-r1;n2,-r2;n3,-r3;n4,-r4];
B=[n1+r1;n2+r2;n3+r3;n4+r4].*[NDVI_roja;NDVI_negra;NDVI_gris;NDVI_teflon];

m=inv((A'*A))*A'*B;
a=m(1);
b=m(2);

 II_nir=imread('arbol_NIR.jpg');
 nx=mean(mean(II_nir(687:1203,1388:2198,3)));
 II_red=imread('arbol_RGB.jpg');
 rx=mean(mean(II_red(585:945,1418:2108,1)));
% analizamos NDVI de teflon
%   II_nir=imread('teflon_NIR.jpg');
%  nx=mean(mean(II_nir(1597:1621,1939:2044,3)));
%  II_red=imread('teflon_RGB.jpg');
%  rx=mean(mean(II_red(1467:1483,1953:2077,1)));
 
NDVI = a*(nx/(nx+rx))  -  b*(rx/(nx+rx));

II_nir(687:1203,1388:2198,:)=ones(size(II_nir(687:1203,1388:2198,:)))*255;
II_red(585:945,1418:2108,:)=ones(size(II_red(585:945,1418:2108,:)))*255;

figure(1)
subplot(1,2,1)
imshow(II_nir)

subplot(1,2,2)
imshow(II_red)

