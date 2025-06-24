%% METHODES PONCTUELLES TRAITEMENT D'IMAGE
%Prétraitement après acquisition( echantillonnage et quantification)
% Marlène ADEI

%Travail_1: Binarisation et Normalisation image artificielle 

%Affichage de l'image
clear, close,clc;

I = [
      3 3 4 4 3 4;
      4 4 5 5 4 5;
      4 5 10 11 10 7;
      4 11 12 13 11 7;
      5 10 12 12 7 6;
      4 6 6 5 5 5;
];
figure(1)
imshow(I , [], 'InitialMagnification', 'fit');
title('Image Original');
colorbar();

%Histogramme de l'image
figure(2)
histogram(uint8(I(:)), 0:15);
xlabel("Valeur du pixel");
ylabel("Occurences");
title("Histogramme Image");
grid on;

%Normalisation de l'image 
figure(3)
[Im_norm] = Normalisation(I);
imshow(Im_norm, [], 'InitialMagnification', 'fit');
title("Image Normalisée");
colorbar();

figure(4)
histogram(uint8(Im_norm(:)), 0:15);
xlabel("valeur d'intensité");
ylabel("occurences");
title("Histogramme de l'image après normalisation");
grid on;

%% Binarisation de l'image avec seuillage heuristique et methodes des modes
I_bin1_heur = zeros(size(I));

%Seuillage heuristiques 
seuil_heur = (min(I(:))+max(I(:)))/2;
[M,N] = size(I);

%Avec une boucle
% for m = 1 : M
%     for n = 1: N
%         if I(m,n) <seuil
%             I_bin1_heur(m,n) = 0;
%         else 
%             I_bin1_heur(m,n) = 1;
%         end
%     end
% end

%Sans Boucle
I_bin2_heur = I >= seuil_heur;

figure(3)
imshow(I_bin2_heur, 'InitialMagnification', 'fit');
title(["Image Binarisée par seuillage Heuristique avec seuil de", num2str(seuil_heur)])
colorbar();

%Seuillage methodes des modes(visuelle)
%On choisit un seuil par observation de l'histogramme 

seuil_modes = 9;
I_bin_modes = I >= seuil_modes;

figure(4)
imshow(I_bin_modes,'InitialMagnification','fit')
title(["Image Binarisée par méthodes des modes avce seuil de",num2str(seuil_modes)])
colorbar();

%Seuillage par méthode de OTSU
%fond et objet relativement uniforme
%distributions fond et objet disjoints
%variance intraclasse faible et interclasse forte
%OTSU choisit le seuil qui respecte au mieux ces hypothèse
%On ecrit la fonction qui réalise le seuil avec OTSU et on l'appelle

[I_bin_OTSU, seuil_OTSU, score_OTSU, scores] = OTSU(I);

fprintf('le score minimale %.4f est obtenu avec le seuil optimal %d \n',score_OTSU, seuil_OTSU);

imshow(I_bin_OTSU, 'InitialMagnification', 'fit');
%title('Image binarisée avec OTSU');
title(['Binarisation OTSU, seuil = ', num2str(seuil_OTSU)]);
colorbar();

%% Binarisation et Normalisation image acquise(LENA et autres)
clc, clear, close;
% LENA
%Lecture de l'image
LENA = imread('lena.jpg');
LENA = rgb2gray(LENA);
figure(1)
imshow(LENA,[]);
colorbar();
%imshow(LENA,'InitialMagnification', 'fit');

%Affichage de l'histogramme
figure(2)
histogram(LENA(:));
title("histogramme Lena");
xlabel("Valeurs d'intensité");
ylabel("Occurences");
grid on;

%Normalisation de l'image 
[LENA_norm] = Normalisation(LENA);

figure(3)
imshow(uint8(LENA_norm), []);
title('Image LENA normalisée');
colorbar();

figure(4)
histogram(uint8(LENA_norm(:)))
title("histogramme Lena après normalisation");
xlabel("Valeurs d'intensité");
ylabel("Occurences");
grid on;

figure(5)
[Lena_bin, seuil_optimal, score, ~] = OTSU(LENA_norm);
imshow(Lena_bin, []);
title("Lena binarisée avec OTSU");

%% Autres1
Autres = imread("blue-scissors.jpg");
Autres = rgb2gray(Autres);

figure(1)
imshow(Autres, []);
title("Image Ciseaux");

figure(2)
histogram(Autres(:));
xlabel("valeur intensité");
ylabel("Occurences");
title("Histogramme du ciseaux");

figure(3)
Ciseaux_norm = Normalisation(Autres);
imshow(Ciseaux_norm,[]);

figure(4)
histogram(Ciseaux_norm(:));

figure(5)
[autres_bin, seuil_autres, score_autres, ~ ] = OTSU(Autres);
imshow(autres_bin, []);
title("Image binarisée")

%% Autres2
Autres = imread("pot.jpg");
Autres = rgb2gray(Autres);

figure(1)
imshow(Autres, []);
title("Image Pot");

figure(2)
histogram(Autres(:));
xlabel("valeur intensité");
ylabel("Occurences");
title("Histogramme du Pot");

figure(3)
[autres_bin, seuil_autres, score_autres, ~ ] = OTSU(Autres);
imshow(autres_bin, []);
title("Image binarisée")

%% Autres3
Autres = imread("eau.jpg");
Autres = rgb2gray(Autres);

figure(1)
imshow(Autres, []);
title("Image Ballon");

figure(2)
histogram(Autres(:));
xlabel("valeur intensité");
ylabel("Occurences");
title("Histogramme du ballon");

figure(3)
eau_norm = Normalisation(Autres);
imshow(eau_norm,[]);

figure(4)
histogram(eau_norm(:));

%%

figure(5)
[autres_bin, seuil_autres, score_autres, ~ ] = OTSU(Autres);
imshow(autres_bin, []);
title("Image binarisée")