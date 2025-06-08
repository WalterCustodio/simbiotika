/* Lista de tareas
 - Cargar sonidos
 -Mejorar el código XD hacerlo con booleanos capaz?
 >>>>if { aprieto tecla A -> boolean ritmo1 true -> suena sonido ritmo1 } <<<<
 Ese boolean tiene que pasar a FALSE cuando se apriete,en este caso, Ritmo2 o Ritmo3.
 - Probar los dos tipos de funcionamiento: ir desmuteando de a uno
 o ir reproduciendo de a uno.
 - Borrar todo lo que son cuadraditos verdes/grises una vez
 que ya este finalizado todo, asi el código solo carga
 audios y no dibujos, textos, etc.
 Por ahora dejemoslo asi, asi podemos visualizar
 qué es lo que se reproduce con cada tecla.
 06/06/2025
 */








import ddf.minim.*;
Minim minim, cumbia, tango;
AudioPlayer player;

String[] Ritmo = new String[3];
String[] Naturaleza = new String[3];
String[] Zumbido = new String[3];
String[] Voces = new String[3];
int sonido1, sonido2, sonido3, sonido4;
color PRENDIDO = color(0, 125, 0);
color APAGADO = color(125);

boolean onRitmo1, onRitmo2, onRitmo3, onNat1, onNat2, onNat3, onZum1, onZum2, onZum3, onVoz1, onVoz2, onVoz3 = false;



void setup() {

  // Inicializa Minim
  minim = new Minim(this);
  player = minim.loadFile("data/Cuarteto.mp3");


  size(300, 300);
  sonido1 = 50;
  sonido2 = 50;
  sonido3 = 50;
  sonido4 = 50;

  Ritmo[0] = "Ritmo1";
  Ritmo[1] = "Ritmo 2";
  Ritmo[2] = "Ritmo 3";
  Naturaleza[0] = "Naturaleza 1";
  Naturaleza[1] = "Naturaleza 2";
  Naturaleza[2] = "Naturaleza 3";
  Zumbido[0] = "Zumbido 1";
  Zumbido[1] = "Zumbido 2";
  Zumbido[2] = "Zumbido 3";
  Voces[0] = "Voces1";
  Voces[1] = "Voces2";
  Voces[2] = "Voces3";
}

void draw() {
  println("onRitmo1: ", onRitmo1);
  background(255);
  textSize(18);
  text("Ritmo:A,B,C\nNaturaleza:D,E,F\nZumbido:G,H,I\nVoces:J,K,L", 18, 200);

  textSize(12);

  fill(APAGADO);
  rect(18, 35, 54, 20);  //RITMO 1
  rect(18, 85, 54, 20);  //RITMO 2
  rect(18, 135, 54, 20); //RITMO 3
  // ---RITMO------//
  rect(18, 35, 54, 20);  //N1
  rect(18, 85, 54, 20);  //N2
  rect(18, 135, 54, 20); //N3
  //---NATURALEZA---//
  rect(79, 35, 62, 20);
  rect(79, 85, 62, 20);
  rect(79, 135, 62, 20);
  //---ZUMBIDO---//
  rect(147, 35, 62, 20);
  rect(147, 85, 62, 20);
  rect(147, 135, 62, 20);
  //-----ZUMBIDO---//
  rect(1470, 35, 62, 20);
  rect(147, 85, 62, 20);
  rect(147, 135, 62, 20);
  //----VOCES-------//
  rect(220, 35, 62, 20);
  rect(220, 85, 62, 20);
  rect(220, 135, 62, 20);






  //------INTERACCIÓN----------//
  /* AL APRETAR LA TECLA, EL CUADRADO SE ILUMINA Y MUESTRA EL NOMBRE DEL SONIDO.*/

  //----RITMO----//
  fill(0);
  if (sonido1==1) {
    onRitmo1=true;
    onRitmo2=false;
    onRitmo3=false;
    fill(PRENDIDO);
    rect(18, 35, 54, 20);
    fill(0);
    text(Ritmo[0], 30, 50);
  }
  if (sonido1==2) {
    onRitmo1=false;
    onRitmo2=true;
    onRitmo3=false;
    fill(PRENDIDO);
    rect(18, 85, 54, 20);
    fill(0);
    text(Ritmo[1], 30, 100);
  }
  if (sonido1==3) {
    fill(PRENDIDO);
    rect(18, 135, 54, 20);
    fill(0);
    text(Ritmo[2], 30, 150);
  }
  //-------NATURALEZA----------//
  if (sonido2==4) {
    fill(PRENDIDO);
    rect(79, 35, 62, 20);
    fill(0);
    text(Naturaleza[0], 80, 50);
  }
  if (sonido2==5) {
    fill(PRENDIDO);
    rect(79, 85, 62, 20);
    fill(0);
    text(Naturaleza[1], 80, 100);
  }
  if (sonido2==6) {
    fill(PRENDIDO);
    rect(79, 135, 62, 20);
    fill(0);
    text(Naturaleza[2], 80, 150);
  }
  //-----------ZUMBIDO-----------
  if (sonido3==7) {
    fill(PRENDIDO);
    rect(147, 35, 62, 20);
    fill(0);
    text(Zumbido[0], 150, 50);
  }
  if (sonido3==8) {
    fill(PRENDIDO);
    rect(147, 85, 62, 20);
    fill(0);
    text(Zumbido[1], 150, 100);
  }
  if (sonido3==9) {
    fill(PRENDIDO);
    rect(147, 135, 62, 20);
    fill(0);
    text(Zumbido[2], 150, 150);
  }
  //-------VOCES ---------------
  if (sonido4==10) {
    fill(PRENDIDO);
    rect(220, 35, 62, 20);
    fill(0);
    text(Voces[0], 230, 50);
  }
  if (sonido4==11) {
    fill(PRENDIDO);
    rect(220, 85, 62, 20);
    fill(0);
    text(Voces[1], 230, 100);
  }
  if (sonido4==12) {
    fill(PRENDIDO);
    rect(220, 135, 62, 20);
    fill(0);
    text(Voces[2], 230, 150);
  }

  //-------------------------------//

  if (onRitmo1==true) {
   // player.play();
   
    onRitmo2=false;
    onRitmo3=false;
  }

  if (onRitmo2==true) {
    onRitmo1=false;
    onRitmo3=false;
  }
} // cierre draw



void keyPressed() {
  if (keyCode == 65) { //letra A mayuscula
    sonido1=1;
     player.loop();
  }
  if (keyCode == 66) { // B
    sonido1=2;
    player.pause();
  }
  if (keyCode == 67) { //C
    sonido1=3;
  }
  if (keyCode == 68) { // D
    sonido2=4;
  }
  if (keyCode == 69) { // E
    sonido2=5;
  }
  if (keyCode == 70) { //F
    sonido2=6;
  }
  if (keyCode == 71) { //G
    sonido3=7;
  }
  if (keyCode == 72) { //H
    sonido3=8;
  }
  if (keyCode == 73) { //I
    sonido3=9;
  }
  if (keyCode == 74) { //J
    sonido4=10;
  }
  if (keyCode == 75) { //K
    sonido4=11;
  }
  if (keyCode == 76) { //L
    sonido4=12;
  }
}
