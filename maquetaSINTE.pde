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


//agregar metronomo
//ver como pasar de tempo de un sonido a otro (para encender quizas solo reiniciando se soluciona... 
//pero para apagar quizas suene raro)






import ddf.minim.*;
Minim minim;
AudioPlayer cumbia, bombo, tango, gotas, brasas, caracola, cantoMarosa, coroToba, cantoUnDia, cuenco, zumbido;

//AudioPlayer sHongo1, sHongo2, sHongo3, sHongo4, sHongo5, sHongo6;


String[] Ritmo = new String[3];
String[] Naturaleza = new String[3];
String[] Zumbido = new String[3];
String[] Voces = new String[3];
int sonido1, sonido2, sonido3, sonido4;
color PRENDIDO = color(0, 125, 0);
color APAGADO = color(125);

//boolean onRitmo1, onRitmo2, onRitmo3, onNat1, onNat2, onNat3, onZum1, onZum2, onZum3, onVoz1, onVoz2, onVoz3 = false;



void setup() {
  // Inicializa Minim
  minim = new Minim(this);
  //ritmos
  cumbia = minim.loadFile("data/Cuarteto.mp3");
  bombo = minim.loadFile("data/bombo.mp3");
  tango = minim.loadFile("data/tango.mp3");
  
  //naturaleza
  gotas = minim.loadFile("data/gotas.mp3");
  brasas = minim.loadFile("data/brasas.mp3");
  caracola = minim.loadFile("data/caracola.mp3");
  
  //zumbidos
  cuenco = minim.loadFile("data/cuenco.mp3");
  zumbido = minim.loadFile("data/zumbido.mp3");

  //voces
  cantoMarosa = minim.loadFile("data/cantoMarosa.mp3");
  coroToba = minim.loadFile("data/coroToba.mp3");
  cantoUnDia = minim.loadFile("data/cantoUnDia.mp3");

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
  //cumbia.setGain(-0.0);
  
  //println("onRitmo1: ", onRitmo1);
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
    /*onRitmo1=true;
    onRitmo2=false;
    onRitmo3=false;*/
    fill(PRENDIDO);
    rect(18, 35, 54, 20);
    fill(0);
    text(Ritmo[0], 30, 50);
  }
  if (sonido1==2) {
    /*onRitmo1=false;
    onRitmo2=true;
    onRitmo3=false;*/
    fill(PRENDIDO);
    rect(18, 85, 54, 20);
    fill(0);
    text(Ritmo[1], 30, 100);
  }
  if (sonido1==3) {
    /*onRitmo1=false;
    onRitmo2=false;
    onRitmo3=true;*/
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
  /*if (sonido3==9) {
    fill(PRENDIDO);
    rect(147, 135, 62, 20);
    fill(0);
    text(Zumbido[2], 150, 150);
  }*/
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

  /*if (onRitmo1==true) {
   
    onRitmo2=false;
    onRitmo3=false;
  }

  if (onRitmo2==true) {
    onRitmo1=false;
    onRitmo3=false;
  }
  if (onRitmo3 == true)
  {
    onRitmo1=false;
    onRitmo2=false;    
  }*/
} // cierre draw



void keyPressed() {
  if (key == 'a' || key == 'A') { //letra A mayuscula
     bombo.pause();
     tango.pause();
     cumbia.loop();
     sonido1=1; //guarda con este, quizas limitarlo todo a las variables "onRitmo" y definirlas en un condicional aparte (agregando el pause() y loop() de cada sonido)
  }
  if (key == 'b' || key == 'B') { // B
    cumbia.pause();
    tango.pause();
    bombo.loop();
    sonido1=2;
  } 
  if (key == 'c' || key == 'C') { //C
    bombo.pause();
    cumbia.pause();
    tango.loop();
    sonido1=3;
  } 
  if (key == 'd' || key == 'D') { // D
    brasas.pause();
    caracola.pause();
    gotas.loop();
    sonido2=4;
  }
  if (key == 'e' || key == 'E') { // fuego
    gotas.pause();
    caracola.pause();
    brasas.loop();
    sonido2=5;
  }
  if (key == 'f' || key == 'F') { //F caracola
    gotas.pause();    
    brasas.pause();
    caracola.loop();
    sonido2=6;
  }
  if (key == 'g' || key == 'G') { //cuenco
    zumbido.pause();
    cuenco.loop();
    sonido3=7;
  }
  if (key == 'h' || key == 'H') { //H
    cuenco.pause();
    zumbido.loop();
    sonido3=8;
  }
  /*if (key == 'i' || key == 'I') { //I
    sonido3=9;
  }*/
  if (key == 'j' || key == 'J') { //J
    cantoUnDia.pause();
    coroToba.pause();
    cantoMarosa.loop();
    sonido4=10;
  }
  if (key == 'k' || key == 'K') { //cantos toba
    cantoUnDia.pause();
    cantoMarosa.pause();
    coroToba.loop();
    sonido4=11;
  }
  if (key == 'l' || key == 'L') { //L
    cantoMarosa.pause();
    coroToba.pause();
    cantoUnDia.loop();
    sonido4=12;
  }
  
}
