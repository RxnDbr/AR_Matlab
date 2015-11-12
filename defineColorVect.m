function colorVect = defineColorVect(Im, pointA, pointB)
%il faut cr�cupere donn�es colorim�trique pour chaque pixel dans ce
%rectange
%parcourir de A(x) � B(x) pour chacun de a(y) a b(y)

R = Im(pointA(2):pointB(2), pointA(1):pointB(1), 1);
G = Im(pointA(2):pointB(2), pointA(1):pointB(1), 2);
B = Im(pointA(2):pointB(2), pointA(1):pointB(1), 3);

R = R(:);
G = G(:);
B = B(:);

colorVect = [R,G,B];

end