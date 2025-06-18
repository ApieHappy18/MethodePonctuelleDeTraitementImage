function [Im_bin, seuil, score] = OTSU (Image)
   
    Image = double(Image);
    [M,N] = size(Image);
    score = zeros(1,256);
    for seuil = 1:256

        %Séparation des classes 
        %mask_1 = Image < seuil; mask_2 = Image >=seuil;
        %Classe_1 = Image .* mask_1; Classe_2 = Image .* mask_2;
        Classe_1 = Image(Image < seuil); Classe_2 = Image(Image > seuil);
        
        %Moyennes classes
        mean_Classe_1 = mean(Classe_1); 
        mean_Classe_2 = mean(Classe_2);

        %Variances intra-classe
        var_intra_class_1 = 0;
        var_intra_class_2 = 0;

        nbre_elem_classe_1 = length(Classe_1);
        nbre_elem_classe_2 = length(Classe_2);
        total_pixel = nbre_elem_classe_1 + nbre_elem_classe_2;

        if (total_pixel == M*N)

            for k = 1:length(Im_vect)
                var_intra_class_1 = var_intra_class_1 + (Classe_1(k) - mean_Classe_1)^2;
                var_intra_class_2 = var_intra_class_2 + (Classe_2(k) - mean_Classe_2)^2;
            end
            var_intra_class_1 = var_intra_class_1/nbre_elem_classe_1;
            var_intra_class_2 = var_intra_class_2/nbre_elem_classe_2;

        else
            disp('Erreur! Nombres de pixels incorrect');
        end

        score(seuil) = ((nbre_elem_classe_1 * var_intra_class_1) + (nbre_elem_classe_2 * var_intra_class_2)) / (M*N);

    end
    [val_min, idx] = min(score);
    seuil = idx;
    score = val_min;

    %Il reste plus qu'à binariser l'image avec le seuil obtenu et la
    %retourner
end