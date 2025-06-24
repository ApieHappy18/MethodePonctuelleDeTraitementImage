function [Image_sortie] = Normalisation(Image_entree)

    I_vect = Image_entree(:);
    [M,N] = size(Image_entree) ;

    g_max = double(max(I_vect));
    g_min = double(min(I_vect));

    disp(['g_min = ', num2str(g_min)]);
    disp(['g_max = ', num2str(g_max)]);

    w0 = 255/(g_max - g_min);

    if g_max == g_min
        Image_sortie = Image_entree;
    else
        Image_entree = double(Image_entree);
        Image_sortie = w0 * (I_vect - g_min);
        Image_sortie = round(Image_sortie);           
        Image_sortie = uint8(Image_sortie); 
    end

    Image_sortie = reshape(Image_sortie, M,N);

end


