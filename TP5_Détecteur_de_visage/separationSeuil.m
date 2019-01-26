%N: separationSeuil
%P: F (features/caracteristiques pour differentes images), V (valeur de v�rit� terrain
%correspondante), IMG (indices du sous ensemble d'images testees pour la determination du seuil)
%S: seuil: seuil s�parant au mieux les images selon la classe � laquelle
%elles appartiennent - ind: indice de ce seuil 
function [ind,seuil] = separationSeuil(IMG,F,V)
     T = [IMG F V];
     %% Tri par ordre croissant selon les valeurs de F
     sortrows(T,2);
    
     %% Recherche du seuil optimal pour separer les features
     eMin = inf;
     seuil = 0;
     [nbImg,~] = size(T);
     for i=1:nbImg-1    
         if T(i,1) > 0%Images associ�es au noeud courant
             seuilCand = (T(i,2)+T(i+1,2))/2;%Moyenne feature courante et feature suivante
             seuil = seuilCand;
             
             %% Evaluation du seuil 
             Sm = 0; Sp = 0; Tm = 0; Tp = 0;
             for j=1:nbImg
                if T(j,1) > 0%Images associ�es au noeud courant
                    %Calcul Sm et Sp
                    if T(j,2) < seuilCand %Exemples inferieurs a la position du seuil
                       if T(j,3) == 0
                           Sm = Sm + 1;
                       else
                           Sp = Sp + 1;
                       end         
                    end

                    %Calcul Tm et Tp
                    if T(j,3) == 0
                        Tm = Tm + 1;   
                    else
                        Tp = Tp + 1;
                    end 
                end
             end
             e = min(Sp+(Tm-Sm),Sm+(Tp-Sp));

             if e < eMin
                eMin = e;
                seuil = seuilCand;
                ind = i;
             end

             end
     end
end