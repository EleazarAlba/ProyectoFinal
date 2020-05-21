import processing.video.*;
import oscP5.*;
import netP5.*;
PImage img, cora, pul;
Organos higa, intes, estom;
Capture video;
//este es el objeto que recibe
OscP5 oscP5;

//esta será la dirección donde voy a enviar mis mensajes
NetAddress direccionRemota;

int x, y;
int c=1;
int p =1;
float k;
float r;
int o=0;
int op =255;
int col;
void setup() {
video = new Capture(this,640,480);
video.start();
  size(640,480);
  oscP5 = new OscP5(this, 12000);
  direccionRemota = new NetAddress("localhost", 12001);
 
cora = loadImage("corazon.png");
pul = loadImage("pulmones.png");
intes = new Organos (loadImage("intestino.png"),1270,1540,220,220,op);
higa = new Organos (loadImage("higado.png"), 2370,2390,110, 110,op);
estom = new Organos (loadImage("estomago.png"),2320,1980,130,130,op);
 
  x = 0;
  y = 0;
  k =0.2;
  r =0.1;
}
void captureEvent(Capture video) {  
  video.read();
}
void draw() {
  pushMatrix();
  imageMode(CENTER);
  if(col == 1){
  video.filter(GRAY);
  }
  tint(255);
  image(video, 320, 240);
  popMatrix();
  image(pul,340,220, p, p);
  intes.rotar(r,k,o);
  estom.rotar(r,k,o);
  higa.rotar(r,k,o);
  pushMatrix();
  image(cora,340,220, c, c);
  popMatrix();
  
  }

  void oscEvent(OscMessage theOscMessage){
   //Aumentar o disminuir la escala del corazón
  if (theOscMessage.checkAddrPattern("/corazon") == true) {
    c = theOscMessage.get(0).intValue();
  }
   //Aumentar o disminuir la escala de los pulmones
  if (theOscMessage.checkAddrPattern("/pulmones") == true) {
    p = theOscMessage.get(0).intValue();
  }
   //Rotar los órganos
    if (theOscMessage.checkAddrPattern("/k") == true) {
    k = theOscMessage.get(0).intValue();
  }
   //Mover los órganos
   if (theOscMessage.checkAddrPattern("/r") == true) {
    r= theOscMessage.get(0).intValue();
  } 
   //Opacidad
  if (theOscMessage.checkAddrPattern("/o") == true) {
    o= theOscMessage.get(0).intValue();
  } 
  
  if (theOscMessage.checkAddrPattern("/col") == true) {
    col= theOscMessage.get(0).intValue();
  } 
}
