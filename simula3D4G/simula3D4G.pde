import controlP5.*;

ControlP5 cp5;
Slider2D vXY;
Slider  vZ;


PShape base, brazo, antebrz, mano;
float rotX, rotY;
//float posX=1, posY=50, posZ=50;
//float posX=1, posY=230, posZ=50;
float alpha, beta, gamma;

int gridSize = 50;

int longBrazo = 215;
int longAntBrazo = 215;
int longMunec = 65;

//Angulos
float angGiro;
float angBrz;
float angAntBrz;
float angMano;

//posición inicial
float X;
float Y;
float Z;
float Cabeceo = 0;

float destX;
float destY;
float destZ;

float Xaux;
float Yaux;
float modX;

void dibujaEscenario(){
   fill(#FFE308);  

//   rotateX(PI/2);
   strokeWeight(3);   
   //coordinate system
   stroke(255,0,0); //red, x-axis
   line(0,0,0,500,0,0);
   stroke(0,255,0); //green, y-axis
   line(0,0,0,0,500,0);
   stroke(0,0,255); //blue, z-axis
   line(0,0,0,0,0,500);
   
   strokeWeight(2);
   stroke(0,197,205); 
   pushMatrix();
   for(int i = -width/2; i <width/2; i+=gridSize) {
    for(int j = -height/2; j < height/2; j+=gridSize) {
      int y = 0; int x = 300;
      line(i+x,          y, j,           i+x+gridSize, y, j          );
      line(i+x+gridSize, y, j,           i+x+gridSize, y, j+gridSize );
      line(i+x+gridSize, y, j+gridSize,  i+x,          y, j+gridSize );
      line(i+x,          y, j,           i+x,          y, j+gridSize );
    }
   }
  popMatrix();
  noStroke();
  rotateX(-PI/2);
}

void posicionaRobot(){
  
//Base
   translate(0,0,0);
  rotateZ(angGiro);
   shape(base);


//brazo
  translate(0, 0, 100); //(rojo, azul, verde)
  rotateY(angBrz);
  shape(brazo);

//antebrazo
  translate(0, 0, 200);
  rotateY(angAntBrz);
  shape(brazo);
 
//mano
  translate(0, 0, 200);
  rotateY(angMano);
  shape(mano);
  
}

void setup(){
   size(1200, 700, P3D);
   cp5 = new ControlP5(this);
   vXY = cp5.addSlider2D("RobotXZ")
         .setPosition(30,40)
         .setSize(200,100)
         .setMinMax(0,0,360,360)
         .setArrayValue(new float[] {120, 250})
         ;
         
   vZ = cp5.addSlider("RobotY")
          .setPosition(250,40)
          .setRange(0,360)
          .setValue(180)
       ;         
   
   base = loadShape("base2.obj");
   brazo = loadShape("brazo.obj");
   antebrz = loadShape("brazo.obj");
   mano = loadShape("mano.obj");
   
   brazo.disableStyle();
   antebrz.disableStyle();
   mano.disableStyle();

   destX = map(vXY.getArrayValue()[0],0, 360, -360, 360);
   destY = map(vXY.getArrayValue()[1],0, 360, -360, 360);
   destZ = map(vZ.getValue(),0, 360, -360, 360);
  
   modX = destX/abs(destX);
//  println("modX: ", modX);
  
  X = abs(destX);
  Y = destY;
  /*
  println("destX: ", destX);
  println("destY: ", destY);
  println("X: ", X);
  println("Y: ", Y);
*/
  cinematicInv(); 
/*  
  println("angGiro: ", degrees(angGiro));
  println("angBrz: ", degrees(angBrz));
  println("angAntBrz: ", degrees(angAntBrz));
  println("angMano: ", degrees(angMano));
*/  
}

void draw(){  
  
  destX = map(vXY.getArrayValue()[0],0, 360, 450, 80);
  destY = map(vXY.getArrayValue()[1],0, 360, 430, 0);
  destZ = map(vZ.getValue(),0, 360, -360, 360);
  X = abs(destX);
  Y = destY;
  
  cinematicInv();
  
  hint(ENABLE_DEPTH_TEST);
  pushMatrix();
   background(32);
   smooth();
   lights();
   directionalLight(51, 102, 126, -1, 0, 0);
   
   translate(width/1.5, height/1.5);
   rotateX(rotX);
   rotateY(-rotY);
   scale(-0.8);
   dibujaEscenario();
   posicionaRobot();
  popMatrix();
  hint(DISABLE_DEPTH_TEST); 
  
  println("angGiro: ", degrees(angGiro));
  println("angBrz: ", degrees(angBrz));
  println("angAntBrz: ", degrees(angAntBrz));
  println("angMano: ", degrees(angMano));
  println("destX: ", destX);
  println("destY: ", destY);
  println("destZ: ", destZ);

}