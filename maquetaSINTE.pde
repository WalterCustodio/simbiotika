/* Lista de tareas
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

//agregar los sonidos de las teclas simples
//agregar en una funcion aparte un "modo facil" de las tacles con lo que ya tenemos del tempo, (pero usando un metronomo aparte). if (modoFacil = false {codigo en draw de las teclas peladas} else if (modoFacil = true){modoFacil();})
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
//--
color PRENDIDOSinTocar = 0; 
color PRENDIDOAlTocar = color(246, 255, 0); 

int bpm = 120;
int intervalo = 60000 / bpm; // milisegundos entre beats
int ultimoGolpeBeat = 0;

boolean seGolpeoBeat = false;  

boolean sePideSonido = false;  //se prende cada vez que se enchufa un cable
boolean sePideSonido2 = false;
boolean sePideSonido3 = false;
boolean sePideSonido4 = false;

//boolean onRitmo1, onRitmo2, onRitmo3, onNat1, onNat2, onNat3, onZum1, onZum2, onZum3, onVoz1, onVoz2, onVoz3 = false;



void setup() {
  size(500, 400);
  // Inicializa Minim
  minim = new Minim(this);
  //ritmos
  cumbia = minim.loadFile("data/op2/cumbia.mp3");
  bombo = minim.loadFile("data/op2/bombo.mp3");
  tango = minim.loadFile("data/op2/tango.mp3"); 
  
  //naturaleza
  gotas = minim.loadFile("data/gotas.mp3");
  brasas = minim.loadFile("data/brasas.mp3");
  caracola = minim.loadFile("data/op2/caracola.mp3");
  
  caracola.setGain(-10);
  
  //zumbidos
  cuenco = minim.loadFile("data/op2/cuenco.mp3");
  zumbido = minim.loadFile("data/zumbido.mp3");

  //voces
  cantoMarosa = minim.loadFile("data/cantoMarosa.mp3");
  coroToba = minim.loadFile("data/op2/coroToba.mp3");
  cantoUnDia = minim.loadFile("data/cantoUnDia.mp3");
  
  cantoMarosa.setGain(-10); //volumen
  coroToba.setGain(-10);
  cantoUnDia.setGain(-10);

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
  
  background(255);
  textSize(18);
  text("Ritmo:A,B,C\nNaturaleza:D,E,F\nZumbido:G,H,I\nVoces:J,K,L", 18, 200);
  text ("Tempo actual: "+bpm+ "BPM", 202, 373);

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
  //if (sePideSonido) {
    if (sonido1==1) {
      fill(PRENDIDO);
      rect(18, 35, 54, 20);
      fill(0);
      text(Ritmo[0], 30, 50);
      
      if (seGolpeoBeat == true && sePideSonido) { 
        cumbia.loop();
        bombo.pause();
        bombo.rewind();
        tango.pause();
        tango.rewind();
        
        sePideSonido = false;
      }
    }
  //}
  if (sonido1==2 ) {
    /*onRitmo1=false;
    onRitmo2=true;
    onRitmo3=false;*/
    fill(PRENDIDO);
    rect(18, 85, 54, 20);
    fill(0);
    text(Ritmo[1], 30, 100);
    
    if (seGolpeoBeat == true && sePideSonido) { 
        cumbia.pause();
        cumbia.rewind();
        bombo.loop();
        tango.pause();
        tango.rewind();
        
        sePideSonido = false;
    }
  }
  if (sonido1==3 ) {
    /*onRitmo1=false;
    onRitmo2=false;
    onRitmo3=true;*/
    fill(PRENDIDO);
    rect(18, 135, 54, 20);
    fill(0);
    text(Ritmo[2], 30, 150);
    
    if (seGolpeoBeat == true && sePideSonido) { 
        cumbia.pause();
        cumbia.rewind();
        bombo.pause();
        bombo.rewind();
        tango.loop();
        
        sePideSonido = false;
    }
  }
  //-------NATURALEZA----------//
  if (sonido2==4 ) {
    fill(PRENDIDO);
    rect(79, 35, 62, 20);
    fill(0);
    text(Naturaleza[0], 80, 50);
    
    if (seGolpeoBeat == true && sePideSonido2) { 
        gotas.loop();
        brasas.pause();
        brasas.rewind();
        caracola.pause();
        caracola.rewind();
        
        sePideSonido2 = false;
    }
  }
  if (sonido2==5  ) {
    fill(PRENDIDO);
    rect(79, 85, 62, 20);
    fill(0);
    text(Naturaleza[1], 80, 100);
    
    if (seGolpeoBeat == true && sePideSonido2) { 
        gotas.pause(); 
        gotas.rewind();
        brasas.loop();
        caracola.pause();
        caracola.rewind();

        
        sePideSonido2 = false;
    }
  }
  if (sonido2==6  ) {
    fill(PRENDIDO);
    rect(79, 135, 62, 20);
    fill(0);
    text(Naturaleza[2], 80, 150);
    
    if (seGolpeoBeat == true && sePideSonido2) { 
        gotas.pause(); 
        gotas.rewind();
        brasas.pause();
        brasas.rewind();
        caracola.loop();
        
        sePideSonido2 = false;
    }
  }
  //-----------ZUMBIDO-----------
  if (sonido3==7  ) {
    fill(PRENDIDO);
    rect(147, 35, 62, 20);
    fill(0);
    text(Zumbido[0], 150, 50);
    
    if (seGolpeoBeat == true && sePideSonido3) { 
        cuenco.loop();
        zumbido.pause();
        zumbido.rewind();
        
        sePideSonido3 = false;
    }
  }
  if (sonido3==8 ) {
    fill(PRENDIDO);
    rect(147, 85, 62, 20);
    fill(0);
    text(Zumbido[1], 150, 100);
    
    if (seGolpeoBeat == true && sePideSonido3) { 
        cuenco.pause();
        cuenco.rewind();
        zumbido.loop();
        
        sePideSonido3 = false;
    }
  }

  //-------VOCES ---------------
  if (sonido4==10  ) {
    fill(PRENDIDO);
    rect(220, 35, 62, 20);
    fill(0);
    text(Voces[0], 230, 50);

    if (seGolpeoBeat == true && sePideSonido4) {    
        cantoMarosa.loop();  
        coroToba.pause();
        coroToba.rewind();
        cantoUnDia.pause();
        cantoUnDia.rewind();
        
        sePideSonido4 = false;
    }
  }
  if (sonido4==11  ) {
    fill(PRENDIDO);
    rect(220, 85, 62, 20);
    fill(0);
    text(Voces[1], 230, 100);
    
    if (seGolpeoBeat == true && sePideSonido4) {    
        cantoMarosa.pause();
        cantoMarosa.rewind();
        coroToba.loop();
        cantoUnDia.pause();
        cantoUnDia.rewind();
        
        sePideSonido4 = false;
    }
  }
  if (sonido4==12 ) {
    fill(PRENDIDO);
    rect(220, 135, 62, 20);
    fill(0);
    text(Voces[2], 230, 150);
    
    if (seGolpeoBeat == true && sePideSonido4) {    
        cantoMarosa.pause();
        cantoMarosa.rewind();
        coroToba.pause();
        coroToba.rewind();
        cantoUnDia.loop();
        
        sePideSonido4 = false;
    }
  }

  
  //--------------Metronomo-----------------
  rect(199, 337, 20, 20);
  if (millis() - ultimoGolpeBeat >= intervalo) { 
      println("Beat!");
      ultimoGolpeBeat = millis();

      seGolpeoBeat = true; //"se golpeó" se activa cada vez que el tempo golpea (hace pulso/beat)
      
      push();
      PRENDIDOSinTocar = color(117, 195, 242);
      fill(PRENDIDOSinTocar); //luz celeste
      rect(199, 337, 20, 20);
      //hongos: ...
      pop();           
  } else {
      PRENDIDOSinTocar = 0; //luz celeste
      seGolpeoBeat = false;       
  }
  
} // cierre draw



void keyPressed() {
  //sePideSonido = true;
  
  if (key == 'a' || key == 'A') { //letra A mayuscula
    //sePideSonido = true;
      sePideSonido = true;
    sonido1=1;    
  }
  if (key == 'b' || key == 'B') { // B
    //sePideSonido = true;
      sePideSonido = true;
    sonido1=2;
  } 
  if (key == 'c' || key == 'C') { //C
    sePideSonido = true;
    sonido1=3;
  } 
  
  //NATURALEZA
  if (keyCode == 68) { // D
     sePideSonido2 = true;
    sonido2=4;
  }
  if (key == 'e' || key == 'E') { // fuego
    sePideSonido2 = true;
    sonido2=5;
  }
  if (keyCode == 70) { //F caracola
    sePideSonido2 = true;
    sonido2=6;
  }
  
  //ZUMBIDOS
  if (key == 'g' || key == 'G') { //cuenco
      sePideSonido3 = true; 
    sonido3=7;
  }
  if (key == 'h' || key == 'H') { //H
      sePideSonido3 = true;
    sonido3=8;
  }
 
 //VOCES
  if (keyCode == 74) { //J
    sePideSonido4 = true;     
    sonido4=10;
  }
  if (keyCode == 75) { //cantos toba
     sePideSonido4 = true;  
    sonido4=11;
  }
  if (keyCode == 76) { //L
    sePideSonido4 = true;  
    sonido4=12;
  }
  
}
