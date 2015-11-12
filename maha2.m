function newIm = maha2(image, meanRGB, matCov)
    %Calcul de la distance de mahalanobis pour tous les pixels et créeation d'un masque
    hauteur = size(image, 1);
    largeur = size(image, 2);
    image=double(image);

    R = image(:,:,1);
    R = R(:);
    R = R.';

    G = image(:,:,2);
    G = G(:);
    G = G.';

    B = image(:,:,3);
    B = B(:);
    B = B.';

    M = [R - meanRGB(1); G - meanRGB(2); B - meanRGB(3)];

    D = (inv(matCov) * M).* M;
    D = sum(D);

    %newIm = (D<550);
    newIm = reshape(D, hauteur, largeur);
end