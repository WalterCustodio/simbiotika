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
Minim minim;
AudioPlayer sHongo1, sHongo2, sHongo3, sHongo4, sHongo5, sHongo6;



String[] Ritmo = new String[3];
String[] Naturaleza = new String[3];
String[] Zumbido = new String[3];
String[] Voces = new String[3];
int sonido1, sonido2, sonido3, sonido4;
int hongo1;
color PRENDIDO = color(0, 125, 0);
color APAGADO = color(125);
color PRENDIDOSinTocar = color(117, 195, 242); 
color PRENDIDOAlTocar = color(246, 255, 0); 

int bpm = 120;
int intervalo = 60000 / bpm; // milisegundos entre beats
int ultimoGolpe = 0; 

boolean seGolpeo = false;
boolean estaApretado = false;

void setup() {
  //frameRate(3);
  minim = new Minim(this);
  
  sHongo1 = minim.loadFile("data/do.mp3", 1024);
  sHongo2 = minim.loadFile("data/re.mp3", 1024);  
  sHongo3 = minim.loadFile("data/mi.mp3", 1024);
  sHongo4 = minim.loadFile("data/fa.mp3", 1024); 
  sHongo5 = minim.loadFile("data/sol.mp3", 1024);
  sHongo6 = minim.loadFile("data/la.mp3", 1024);  
  
  size(500, 400);
  sonido1 = 50;
  sonido2 = 50;
  sonido3 = 50;
  sonido4 = 50;
  
  hongo1 = 50;
  hongo1 = 50;

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
  background(255);
  fill(0);
  textSize(18);
  text("Ritmo:A,B,C\nNaturaleza:D,E,F\nZumbido:G,H,I\nVoces:J,K,L", 18, 200);
  text ("Tempo actual: "+bpm+ "BPM", 202, 373);
  
  textSize(12);
  
  //1)--------CABLES:---------//
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

  //2)--------HONGOS/bombos:---------//
    fill(APAGADO);
    rect(350, 35, 20, 20);  //1
    rect(350, 85, 20, 20);  //2
    rect(350, 135, 20, 20); //3
    // ---------//
    rect(385, 35, 20, 20);  //4
    rect(385, 85, 20, 20);  //5
    rect(385, 135, 20, 20); //6



  //------INTERACCIÓN----------//
  
  //1)--------CABLES:---------//
  /* AL APRETAR LA TECLA, EL CUADRADO SE ILUMINA Y MUESTRA EL NOMBRE DEL SONIDO.*/
  fill(0);
  if (sonido1==1) {
    fill(PRENDIDO);
    rect(18, 35, 54, 20);
    fill(0);
    text(Ritmo[0], 30, 50);
    
    //sHongo1.play();
  } else {
    //sHongo1.rewind();
    //sHongo1.pause();
  }
  if (sonido1==2) {
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
  //-------NATURALEZA----------
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
  
    

  //2)--------HONGOS/bombos:---------//    
    /* SE ILUMINAN LOS CUADRADOS (en celeste) SEGUN EL BPM ELEGIDO.*/
    if (millis() - ultimoGolpe >= intervalo) { 
      println("Beat!");
      ultimoGolpe = millis();

      seGolpeo = true; //"se golpeó" se activa cada vez que el tempo golpea (hace pulso/beat)
      
      fill(PRENDIDOSinTocar); //luz celeste
      
      //metronomo (Cuadrado negro)
      rect(199, 337, 20, 20);
      //hongos
      rect(350, 35, 20, 20);  
      rect(350, 85, 20, 20);  
      rect(350, 135, 20, 20); 
      // ---------//
      rect(385, 35, 20, 20);  
      rect(385, 85, 20, 20); 
      rect(385, 135, 20, 20);
           
     } else {
           seGolpeo = false;       
     }
    
    //-----HONGOS----AL PRESIONAR:
    if (estaApretado == true) {
      if (hongo1==1) {
        push();     
        fill(PRENDIDO);
        rect(350, 35, 20, 20);
        pop();     
        if (seGolpeo == true) {
          push(); 
          fill(PRENDIDOAlTocar);
          rect(350, 35, 20, 20);
          pop();
          
          sHongo1.play();

          estaApretado = false;
        } else {
          sHongo1.rewind();
          sHongo1.pause();
        }
      }    
      if (hongo1==2) {
        push(); 
        fill(PRENDIDO);
        rect(350, 85, 20, 20);
        pop();      
        if (seGolpeo == true) {
          push(); 
          fill(PRENDIDOAlTocar);
          rect(350, 85, 20, 20);
          pop();
          
          sHongo2.play();
           
          estaApretado = false;
        } else {
          sHongo2.rewind();
          sHongo2.pause();
        }
      }
     
      if (hongo1==3) {
        push();
        fill(PRENDIDO);
        rect(350, 135, 20, 20); 
        pop();     
        if (seGolpeo == true) {
          push(); 
          fill(PRENDIDOAlTocar);
          rect(350, 135, 20, 20); 
          pop();
          
          sHongo3.play();
           
          estaApretado = false;
        } else {
          sHongo3.rewind();
          sHongo3.pause();
        }
      }
      if (hongo1==4) {
        push();
        fill(PRENDIDO);
        rect(385, 35, 20, 20); 
        pop();      
        if (seGolpeo == true) {
          push(); 
          fill(PRENDIDOAlTocar);
          rect(385, 35, 20, 20); 
          pop();
          
          sHongo4.play();
           
          estaApretado = false;
        } else {
          sHongo4.rewind();
          sHongo4.pause();
        }
      }
      if (hongo1==5) {
        push();
        fill(PRENDIDO);
        rect(385, 85, 20, 20);
        pop();
        if (seGolpeo == true) {
          push(); 
          fill(PRENDIDOAlTocar);
          rect(385, 85, 20, 20);
          pop();
          
          sHongo5.play();
           
          estaApretado = false;
        } else {
          sHongo5.rewind();
          sHongo5.pause();
        }    
      }
      if (hongo1==6) {
        push();
        fill(PRENDIDO);
        rect(385, 135, 20, 20); 
        pop();
        if (seGolpeo == true) {
          push(); 
          fill(PRENDIDOAlTocar);
          rect(385, 135, 20, 20); 
          pop();
          
          sHongo6.play();
           
          estaApretado = false;
        } else {
          sHongo6.rewind();
          sHongo6.pause();
        }
      }
    }

   int contador = 1;
    
   rect(199, 337, 20, 20);
   
   println("LAST BEAT: "+ultimoGolpe);
   
   println(contador); 

   println("X "+mouseX + "Y "+mouseY);
   
  // para pasar BPM a millis:
  // 60000 / BPM = millis
  // para pasar millis a BPM: 
  // 60000 / millis = BPM  
}

void keyPressed() {
  if (key == 'a' || key == 'A') { //letra A mayuscula
    sonido1=1;
  }
  if (key == 'b' || key == 'B') { // B
    sonido1=2;
  }
  if (key == 'c' || key == 'C') { //C
    sonido1=3;
  }
  if (key == 'd' || key == 'D') { // D
    sonido2=4;
  }
  if (key == 'e' || key == 'E') { // E
    sonido2=5;
  }
  if (key == 'f' || key == 'F') { //F
    sonido2=6;
  }
  if (key == 'g' || key == 'G') { //G
    sonido3=7;
  }
  if (key == 'h' || key == 'H') { //H
    sonido3=8;
  }
  if (key == 'i' || key == 'I') { //I
    sonido3=9;
  }
  if (key == 'j' || key == 'J') { //J
    sonido4=10;
  }
  if (key == 'k' || key == 'K') { //K
    sonido4=11;
  }
  if (key == 'l' || key == 'L') { //L
    sonido4=12;
  }
  
  ///-------------------------------- HONGOS
  
  if (key == '1') { //1
    hongo1=1;
    
    estaApretado = true;
  }
  if (key == '2') { // 2
    hongo1=2;
    
    estaApretado = true;
  }
  if (key == '3') { //3
    hongo1=3;
    
    estaApretado = true;
  }
  if (key == '4') { // 4
    hongo1=4;
    
    estaApretado = true;
  }
  if (key == '5') { // 5
    hongo1=5;
    
    estaApretado = true;
  }
  if (key == '6') { //6
    hongo1=6;
    
    estaApretado = true;
  }
  
  
}
