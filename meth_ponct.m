%% METHODES PONCTUELLES TRAITEMENT D'IMAGE
%Prétraitement après acquisition( echantillonnage et quantification)
% Marlène ADEI

%Travail_1: Binarisation et Normalisation

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
colorbar();

%Histogramme de l'image
figure(2)
histogram(I(:), 0:15);
xlabel("Valeur du pixel");
ylabel("Occurences");
title("Histogramme avant normalisation");
grid on;

%Binarisation de l'image
I_bin1 = zeros(size(I));

%Seuillage heuristiques 
seuil_1 = (min(I(:))+max(I(:)))/2;
[M,N] = size(I);

%Avec une boucle
% for m = 1 : M
%     for n = 1: N
%         if I(m,n) <seuil
%             I_bin1(m,n) = 0;
%         else 
%             I_bin1(m,n) = 1;
%         end
%     end
% end

%Sans Boucle
I_bin2 = I >= seuil_1;

figure(3)
imshow(I_bin2, [], 'InitialMagnification', 'fit');
title("Image Binarisée par seuillage Heuristique")
colorbar();

%Seuillage methodes des modes(visuelle)
%On choisit un seuil par observation de l'histogramme 

seuil_2 = 9;
I_bin3 = I >= seuil_2;

figure(4)
imshow(I_bin3,'InitialMagnification','fit')
title("Image Binarisée par méthodes des modes")
colorbar();

%Seuillage par méthode de OTSU
%fond et objet relativement uniforme
%distributions fond et objet disjoints
%variance intraclasse faible et interclasse forte
%OTSU choisit le seuil qui respecte au mieux ces hypothèses

%%
clear, close,clc;
Image = [
      3 3 4 4 3 4;
      4 4 5 5 4 5;
      4 5 10 11 10 7;
      4 11 12 13 11 7;
      5 10 12 12 7 6;
      4 6 6 5 5 5;
];

seuil = 8;
% classe_1 = Image < seuil;
% classe_2 = Image >=seuil;
% 
% result_1 = classe_1 .* Image;
Classe_1 = Image(Image < seuil);

vect = [5 4 5 0 3 3 0];
vect = vect(vect > 0)
N = length(vect);
moy = mean(vect)

var_intra_class_1 = 0;
 for k = 1:N
    var_intra_class_1 = var_intra_class_1 + (vect(k) - moy)^2;
 end
var_intra_class_1 = var_intra_class_1/N;
score = []

for k = 1:N 
    score(k) = k + 1;
end

 [val_min, idx] = min(score)