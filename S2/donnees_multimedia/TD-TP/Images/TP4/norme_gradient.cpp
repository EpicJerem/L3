#include <stdio.h>
#include <stdlib.h>
#include "image_ppm.h"
#include <math.h>

int main(int argc, char* argv[])
{
    char cNomImgLue[250];
    char cNomImgEcrite[250];
;
    int nH, nW, nTaille;
  
  if (argc != 3) 
     {
       printf("Usage: ImageIn.pgm ImageOut.pgm\n"); 
       exit (1) ;
     }
    
    sscanf (argv[1],"%s",cNomImgLue);
    sscanf (argv[2],"%s",cNomImgEcrite);

   OCTET *ImgIn, *ImgOut;
   
   lire_nb_lignes_colonnes_image_pgm(cNomImgLue, &nH, &nW);
   nTaille = nH * nW;
   
   printf("hauteur: %ipx , largeur: %ipx , total: %ipx\n",nH,nW,nTaille);
   
   allocation_tableau(ImgIn, OCTET, nTaille);
   lire_image_pgm(cNomImgLue, ImgIn, nTaille);
   allocation_tableau(ImgOut, OCTET, nTaille);

    // remplissage des bords 
    // for (int i=0; i < nW; i++){ImgOut[i]=ImgIn[i];} // haut horizontal
    // for (int i=0; i < nH; i++){ImgOut[i*nW]=ImgIn[i*nW];} // gauche vertical

   for (int i=1; i<nH-1; i++){
       for(int j=1; j<nW-1; j++){
           ImgOut[(i*nW)+j]=sqrt((ImgIn[(i*nW)+j]-ImgIn[(i*nW)+j-1])*(ImgIn[(i*nW)+j]-ImgIn[(i*nW)+j-1])+\
                            (ImgIn[(i*nW)+j]-ImgIn[((i-1)*nW)+j])*(ImgIn[(i*nW)+j]-ImgIn[((i-1)*nW)+j]));
       }
   }

   ecrire_image_pgm(cNomImgEcrite, ImgOut,  nH, nW);
   free(ImgIn);
   free(ImgOut);
   return 1;
}