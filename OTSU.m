function [Im_bin, seuil_optimal, score_min, score] = OTSU (Image)
   
    Image = double(Image);
    %[M,N] = size(Image);
    score = zeros(1,255);

    for s = 1:255

        %Séparation des classes 
        %mask_1 = Image < seuil; mask_2 = Image >=seuil;
        %Classe_1 = Image .* mask_1; Classe_2 = Image .* mask_2;
        Classe_1 = Image(Image < s); 
        Classe_2 = Image(Image >= s);
        
        %Variances intra-classe
        var_intra_class_1 = var(Classe_1, 1); %variance non biaisé
        var_intra_class_2 = var(Classe_2, 1);

        w1 = numel(Classe_1)/ numel(Image);
        w2 = numel(Classe_2)/ numel(Image);

        %Score OTSU ou Var intra class pondérée

        score(s) = ((w1 * var_intra_class_1) + (w2 * var_intra_class_2));

    end

    [score_min, seuil_optimal] = min(score);

    %Il reste plus qu'à binariser l'image avec le seuil obtenu et la
    %retourner
    
    %Im_bin = zeros(M,N);
    Im_bin = Image >= seuil_optimal;
    %Im_bin = Image > seuil_optimal;
end