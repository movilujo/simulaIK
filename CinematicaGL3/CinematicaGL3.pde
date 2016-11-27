/* Cinematica Inversa brazo GL3 */

int widthScreen;
int highScreen;

float RAD = 180/PI;

int BaseX;
int BaseY;

int longBrazo = 150;
int longAntBrazo = 150;
int longMunec = 50;

//Puntos miniMax
float maxX;
float minX;
float maxY;
float minY;

//posición inicial
float X;
float Y;
float Cabeceo = 0;

float destX;
float destY;

//puntos finales Brazos
float BrazoPX;
float BrazoPY;
float antBrazoPX;
float antBrazoPY;
float munecPX;
float munecPY;
  
//Angulos
float angBrazo;
float angAntBrazo;
float angMunec;


float Xaux;
float Yaux;
float modX;
PFont f;
String txtDestX = "DestX: ";
String txtDestY = "DestY: ";
String txtAngBrz = "Ang. Brz: ";
String txtAngAntBrz = "Ang. AntBrz: ";
String txtAngMunec = "Ang. Muñeca: ";
float  wtxtDestX;
float  wtxtDestY;
float  wtxtAngBrz;
float  wtxtAngAntBrz;
float  wtxtAngMunec;

//

void cinematicInv(){
  float Beta;
  float Afx = cos(radians(Cabeceo))*longMunec;
  float ladoB = abs(X) - Afx;
  float Afy = sin(radians(Cabeceo))*longMunec;
  float ladoA = abs(Y) - Afy;
  float hipotenusa = sqrt(pow(ladoA,2)+pow(ladoB,2));
  float Alfa = atan2(ladoA, ladoB);
  Beta = acos((pow(longBrazo,2)-pow(longAntBrazo,2)+pow(hipotenusa,2))/(2*longBrazo*hipotenusa));
  angBrazo = Alfa + Beta; //Angulo del brazo en radianes
  float Gamma = acos((pow(longBrazo,2)+pow(longAntBrazo,2)-pow(hipotenusa,2))/(2*longBrazo*longAntBrazo));
  angAntBrazo = -(radians(180)-Gamma);  //Angulo del antebrazo en radianes
  angMunec = Cabeceo - angBrazo - angAntBrazo;
  Xaux = X;
  Yaux = Y;
}

void dibuja(){
  float PXa = longBrazo*cos(angBrazo);
  float PYa = longBrazo * (-sin(angBrazo));
  float PXb = longAntBrazo * cos(angAntBrazo+angBrazo);
  float PYb = longAntBrazo * (-sin(angAntBrazo+angBrazo));
  float PXc = longMunec * cos(angMunec+angAntBrazo+angBrazo);
  float PYc = longMunec * (-sin(angMunec+angAntBrazo+angBrazo));
  
  BrazoPX = (modX * PXa) + BaseX;
  BrazoPY = PYa + BaseY;
  antBrazoPX = (modX * PXb) + (modX * PXa) + BaseX;
  antBrazoPY = PYb + PYa + BaseY;
  munecPX = (modX * PXc) + (modX * PXb) + (modX * PXa) + BaseX;
  munecPY = PYc + PYb + PYa + BaseY;
  
  stroke(255);
  line(BaseX, BaseY, BrazoPX, BrazoPY);
  stroke(255,0,0);
  line(BrazoPX, BrazoPY, antBrazoPX, antBrazoPY);
  stroke(0,255,0);
  line(antBrazoPX, antBrazoPY, munecPX, munecPY);
  muestraDatos();
}

void setupTxt(){
  f = createFont("Verdana",14,true); 
  wtxtDestX = textWidth(txtDestX); 
  wtxtDestY = textWidth(txtDestY); 
  wtxtAngBrz = textWidth(txtAngBrz); 
  wtxtAngAntBrz = textWidth(txtAngAntBrz); 
  wtxtAngMunec = textWidth(txtAngMunec); 
}

void muestraDatos(){
  int oriX = 5;
  int oriY = 15;
  int desplX1 = oriX + 2;
  
  textFont(f,12);                
  fill(0);                       
  text(txtDestX,oriX,oriY*1); 
  fill(135, 0, 50);
  text(destX,wtxtDestX + desplX1, oriY*1);
  fill(0);                       
  text(txtDestY,oriX,oriY*2); 
  fill(135, 0, 50);
  text(destY,wtxtDestY + desplX1,oriY*2);
  fill(0);                       
  text(txtAngBrz,oriX,oriY*3); 
  fill(135, 0, 50);
  text(degrees(angBrazo),wtxtAngBrz + desplX1,oriY*3);
  fill(0);                       
  text(txtAngAntBrz,oriX,oriY*4); 
  fill(135, 0, 50);
  text(degrees(angAntBrazo),wtxtAngAntBrz + desplX1,oriY*4);
  fill(0);                       
  text(txtAngMunec,oriX,oriY*5); 
  fill(135, 0, 50);
  text(degrees(angMunec),wtxtAngMunec + desplX1,oriY*5);

}

void setup(){
  size(640, 360);
  setupTxt();
  
  BaseX = width / 2;
  BaseY = height - 50;

  maxX = BaseX + (longBrazo + longAntBrazo);
  minX = BaseX - (longBrazo + longAntBrazo); 
  maxY = BaseY;
  minY = BaseY - (longBrazo + longAntBrazo); 
 
  destX = -200;
  destY = 100;
  
  modX = destX/abs(destX);
  println("modX: ", modX);
  
  X = abs(destX);
  Y = destY;

  cinematicInv();
  dibuja();

}

void draw(){
  background(150);
  if (mouseX < BaseX){
    if (mouseX < minX){
      destX = (longBrazo + longAntBrazo)*(-1);
    } else {
      destX = mouseX - BaseX;
    }
  } else {
    if (mouseX > maxX){
      destX = (longBrazo + longAntBrazo);
    } else {
      destX = mouseX - BaseX;
    }
  }
  
  if (mouseY < BaseY){
    if (mouseY < minY){
      destY = (longBrazo + longAntBrazo);
    } else {
      destY = BaseY - mouseY;
    }
  } else {
      destY = 0;
  }  
  
  modX = destX/abs(destX);
  X = abs(destX);
  Y = destY;

  println("destX: ", destX);
  println("destY: ", destY);

  cinematicInv();
  dibuja();

}