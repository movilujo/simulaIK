void cinematicInv(){
  float Beta;
  float Afx = cos(radians(Cabeceo))*longMunec;
  float ladoB = destX - Afx;
  float Afy = sin(radians(Cabeceo))*longMunec;
  float ladoA = abs(Y) - Afy;
  float hipotenusa = sqrt(pow(ladoA,2)+pow(ladoB,2));
  float Alfa = atan2(ladoA, abs(ladoB));
  Beta = acos((pow(longBrazo,2)-pow(longAntBrazo,2)+pow(hipotenusa,2))/(2*longBrazo*hipotenusa));
  if (ladoB < 0){
    angBrz = -((PI/2) - (Alfa - Beta)); //Angulo del brazo
  } else {
    angBrz = (PI/2) - (Alfa + Beta);
  }
  float Gamma = acos((pow(longBrazo,2)+pow(longAntBrazo,2)-pow(hipotenusa,2))/(2*longBrazo*longAntBrazo));
  angAntBrz = radians(180)-Gamma;  //Angulo del antebrazo en radianes
  angMano = (Cabeceo + (PI/2)) - angBrz - angAntBrz;
  angGiro = atan2(destZ, destX);
  Xaux = X;
  Yaux = Y;
}