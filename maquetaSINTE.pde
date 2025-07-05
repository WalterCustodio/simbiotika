
import ddf.minim.*;
Minim minim;

//AudioPlayer[] percus = new AudioPlayer[5];
AudioPlayer ambiente;
AudioPlayer sHongo1, sHongo2, sHongo3, sHongo4, sHongo5;

AudioPlayer[] jackSonidos = new AudioPlayer[9];
boolean[] jackConectado = new boolean[9];       // ===estado de cada jack (0 no se usa)



//int columna1, columna2, sonido3, sonido4;

int[] columna = new int[3]; //3 es la cantidad de columnas

int hongo1;
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

//----------------------MODO FACIL-----
boolean modoFacilActivado = false;

boolean estaApretado = false;
int bpmF = bpm*4;
int intervaloF = 60000 / bpmF; // milisegundos entre beats
int ultimoGolpeBeatF = 0;
boolean seGolpeoBeatF = false; 


void setup() {
  size(500, 400);
  
  // Inicializa Minim
  minim = new Minim(this);
  
  //sonido ambiente
  ambiente = minim.loadFile("data/ambiente.mp3");
  //ambiente.setGain(-5);
  
  //acordarse de que todo esta en la carpeta "sonidos", la proxima los dejo en data
    // ===Cargar sonidos de jacks (del 0 al 8)
  for (int i = 0; i <= 8; i++) {
    jackSonidos[i] = minim.loadFile("data/jack" + i + ".mp3");
  }
  
  //volumenes a
  jackSonidos[0].setGain(-20);
  jackSonidos[1].setGain(-20);
  jackSonidos[2].setGain(-20);
  //--
  jackSonidos[3].setGain(-5);
  jackSonidos[4].setGain(-5);
  jackSonidos[5].setGain(-5);
  //--
  jackSonidos[6].setGain(-10);
  jackSonidos[7].setGain(-10);
  jackSonidos[8].setGain(-10);
  //HONGOS-------------

  sHongo1 = minim.loadFile("data/percu1.mp3");
  sHongo2 = minim.loadFile("data/percu2tambores.mp3");
  sHongo3 = minim.loadFile("data/percu3.mp3");
  sHongo4= minim.loadFile("data/percu4.mp3"); 
  sHongo5= minim.loadFile("data/percu5.mp3");

  sHongo1.setGain(5);
  sHongo2.setGain(5);
  sHongo3.setGain(5);
  sHongo4.setGain(5);
  sHongo5.setGain(5);
  
  /*columna1 = 50;
  columna2 = 50;
  sonido3 = 50;
  sonido4 = 50;*/
  
  columna[0] = 50;
  columna[1] = 50;
  columna[2] = 50;
  
  hongo1 = 50;
  
  ambiente.loop();
}

void draw() {
  InterfazSinInteraccion();
  
  //boolean algunoReproduciendo = false;

  // Reviso todos los jackSonidos
  //for (int i = 0; i < 2; i++) {
    if (columna[0] != 50 || columna[1] != 50 || columna[2] != 50) {
      ambiente.pause();
    }
    //} else {
      //ambiente.pause();
    //}
  //}
  
  // Reviso los sonidos de hongos también
  /*if (sHongo1.isPlaying() || sHongo2.isPlaying() || sHongo3.isPlaying() || sHongo4.isPlaying() || sHongo5.isPlaying()) {
    algunoReproduciendo = true;
  }
  
  // Si ninguno está reproduciéndose, activo ambiente
  if (!algunoReproduciendo && !ambiente.isPlaying()) {
    ambiente.loop();
  }*/

  
  /*for (int i = 0; i <= 8; i++) {
    if (!jackSonidos[i].isPlaying || !sHongo1.isPlaying || !sHongo2.isPlaying || !sHongo3.isPlaying || !sHongo4.isPlaying || !sHongo5.isPlaying) {
      ambiente.loop();
    }
  }*/
  
  //quizas el problema es que si se mantiene con el sonidos a ctivado de un numero anterior entra en conflicto
  // COLUMNA 2: jackSonidos[6], [7], [8]
  if (columna[2] >= 0 && columna[2] <= 2) {
    int i = columna[2] + 6; // calcula el índice correcto
    if (seGolpeoBeat && sePideSonido3) {
      if (!jackSonidos[i].isPlaying()) {
        detenerJacks(2);
        jackSonidos[i].loop();
        sePideSonido3 = false;
        println("Reproduciendo jackSonido " + i);
      }
    }
  }
  
  // Detener sonidos si se desconectan
  for (int i = 6; i <= 8; i++) {
    if (columna[2] == 50 && jackSonidos[i].isPlaying()) {
      jackSonidos[i].pause();
      jackSonidos[i].rewind();
      println("Detenido jackSonido " + i);
    }
  }
  
    //HAY UN BUG CON LA TELCLA D, no prende hasta que se haya prendido una de la columna 0
    // COLUMNA 1: jackSonidos[3], [4], [5]
  if (columna[1] >= 0 && columna[1] <= 2) {
    int i = columna[1] + 3; // calcula el índice correcto
    if (seGolpeoBeat && sePideSonido2) {
      if (!jackSonidos[i].isPlaying()) {
        detenerJacks(1);
        jackSonidos[i].loop();
        sePideSonido2 = false;
        println("Reproduciendo jackSonido " + i);
      }
    }
  }
  
  // Detener sonidos si se desconectan
  for (int i = 3; i <= 5; i++) {
    if (columna[1] == 50 && jackSonidos[i].isPlaying()) {
      jackSonidos[i].pause();
      jackSonidos[i].rewind();
      println("Detenido jackSonido " + i);
    }
  }

  

  //------INTERACCIÓN----------//
   for (int i = 0; i <= 3; i++) { //probar cambiando el largo de array   
     //--Conectado 0
     if (columna[0] == i) { 
       if (seGolpeoBeat == true && sePideSonido) {
        if (!jackSonidos[i].isPlaying()) {
          
          detenerJacks(0);
          jackSonidos[i].loop();
          sePideSonido = false;
          

          //detenerJacks(0);
          println("Reproduciendo jackSonido " + i);
        }
       }
     } 
     //--Desconectado
     if (columna[0] == 50 && jackSonidos[i].isPlaying()) { //si se vuelve a pulsar A se desconecta
        jackSonidos[i].pause();
        jackSonidos[i].rewind();
        println("Detenido jackSonido" + i);
     }
   } //fin de for i
  
  
 //------------------------------ 


  HongosModoNormal();

  
  //--------------Metronomo-----------------
  rect(199, 337, 20, 20);
  if (millis() - ultimoGolpeBeat >= intervalo) { 
      ultimoGolpeBeat = millis();

      seGolpeoBeat = true; //"se golpeó" se activa cada vez que el tempo golpea (hace pulso/beat)
      
      push();
      PRENDIDOSinTocar = color(117, 195, 242);
      fill(PRENDIDOSinTocar); //luz celeste
      rect(199, 337, 20, 20);
      pop();           
  } else {
      PRENDIDOSinTocar = 0; //luz celeste
      seGolpeoBeat = false;       
  }
  
  println("columna 0 = " + columna[0]);
  println("columna 1 = " + columna[1]);
  println("columna 2 = " + columna[2]);

} // cierre draw




//modificar esto:
void detenerJacks(int columnaIndex) {
  
  if (columnaIndex == 2) {
    for (int i = 6; i <= 8; i++) {
      if (i != columna[2] + 6 && jackSonidos[i].isPlaying()) {
        jackSonidos[i].pause();
        jackSonidos[i].rewind();
      }
    }
  }

  
  if (columnaIndex == 1) {
    for (int i = 3; i <= 5; i++) {
      if (i != columna[1] + 3 && jackSonidos[i].isPlaying()) {
        jackSonidos[i].pause();
        jackSonidos[i].rewind();
      }
    }
  }


  if (columnaIndex == 0) {
    for (int i = 0; i <= 2; i++) { //columna0 (va de 0 a 3)
      if (i != columna[0] && jackSonidos[i].isPlaying()) {
        jackSonidos[i].pause();
        jackSonidos[i].rewind();
      }
    }
  }
}




void keyPressed() {
  //COLUMNA 0
  if (key == 'a' || key == 'A') {
      if (columna[0] == 0 && jackSonidos[0].isPlaying()) {
        //sePideSonido se desactiva solo
        columna[0] = 50;
      } else {
        sePideSonido = true;
        columna[0] = 0;
      }
  }
  
  if (key == 'b' || key == 'B') {
      if (columna[0] == 1 && jackSonidos[1].isPlaying()) {
        //sePideSonido se desactiva solo
        columna[0] = 50;
      } else {
        sePideSonido = true;
        columna[0] = 1;
      }
  }
  
  if (key == 'c' || key == 'C') {
      if (columna[0] == 2 && jackSonidos[2].isPlaying()) {
        //sePideSonido se desactiva solo
        columna[0] = 50;
      } else {
        sePideSonido = true;
        columna[0] = 2;
      }
  }
  
  //cada columna tiene su propia escala de 0 a 2
  //COLUMNA 1
  if (key == 'd' || key == 'D') {
      if (columna[1] == 0 && jackSonidos[3].isPlaying()) {
        //sePideSonido se desactiva solo
        columna[1] = 50;
      } else {
        sePideSonido2 = true;
        columna[1] = 0;
      }
  }
  
  if (key == 'e' || key == 'E') {
      if (columna[1] == 1 && jackSonidos[4].isPlaying()) {
        //sePideSonido se desactiva solo
        columna[1] = 50;
      } else {
        sePideSonido2 = true;
        columna[1] = 1;
      }
  }
  
   if (key == 'f' || key == 'F') {
      if (columna[1] == 2 && jackSonidos[5].isPlaying()) {
        //sePideSonido se desactiva solo
        columna[1] = 50;
      } else {
        sePideSonido2 = true;
        columna[1] = 2;
      }
  }
  
  //--etc...
  
  // COLUMNA 2
  if (key == 'j' || key == 'J') {
    if (columna[2] == 0 && jackSonidos[6].isPlaying()) {
      columna[2] = 50;
    } else {
      sePideSonido3 = true;
      columna[2] = 0;
    }
  }
  
  if (key == 'k' || key == 'K') {
    if (columna[2] == 1 && jackSonidos[7].isPlaying()) {
      columna[2] = 50;
    } else {
      sePideSonido3 = true;
      columna[2] = 1;
    }
  }
  
  if (key == 'l' || key == 'L') {
    if (columna[2] == 2 && jackSonidos[8].isPlaying()) {
      columna[2] = 50;
    } else {
      sePideSonido3 = true;
      columna[2] = 2;
    }
  }

  
    ///-------------------------------- HONGOS ----------------------------//
  
  if (key == '1') { //1
      hongo1=1;
      
      if (modoFacilActivado) {
        estaApretado = true;
      }
  }
  
  if (key == '2') { // 2
    hongo1=2;
        
    if (modoFacilActivado) {
    estaApretado = true;
    }
  }
  if (key == '3') { //3
    hongo1=3;
        
    if (modoFacilActivado) {
    estaApretado = true;
    }
  }
  if (key == '4') { // 5
    hongo1=5;
    
    if (modoFacilActivado) {
      estaApretado = true;
      }
    }
}


void detener(AudioPlayer sonido) { //se usa para jacks
  if (sonido != null && sonido.isPlaying()) {
    sonido.pause();
    sonido.rewind();
  }
}


void HongosModoNormal() {
  //--
        if (hongo1==1) {
        push(); 
        fill(PRENDIDO);
        rect(350, 35, 20, 20);
        pop();      
 
        sHongo1.play();
 
      } else {
         sHongo1.pause();
         sHongo1.rewind();         
      }
      
      
      if (hongo1==2) {
        push(); 
        fill(PRENDIDO);
        rect(350, 85, 20, 20);
        pop();      
 
        sHongo2.play();
 
      } else {
         sHongo2.pause();
         sHongo2.rewind();         
      } 
     
      if (hongo1==3) {
        push();
        fill(PRENDIDO);
        rect(350, 135, 20, 20); 
        pop();     
 
        sHongo3.play();
 
      }else {
         sHongo3.pause();
         sHongo3.rewind();         
      } 
      
      
      if (hongo1==5) {
        push();
        fill(PRENDIDO);
        rect(385, 85, 20, 20);
        pop();
 
        sHongo5.play();
   
      }else {
         sHongo5.pause();
         sHongo5.rewind();         
      }   
}

















void InterfazSinInteraccion() {
    background(255);
  textSize(18);
  text("Ritmo:A,B,C\nNaturaleza:D,E,F\nVoces:J,K,L", 18, 200);
  text("Percu: 1, 2, 3, 4", 354, 200);

  text ("Tempo actual: "+bpm+ "BPM", 202, 373);

  textSize(12);
      text("columna 0      columna 1        columna 2", 17, 25);
  
  //println(mouseX, mouseY);

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
  //----NATURALEZA-------//
  rect(150, 35, 62, 20);
  rect(150, 85, 62, 20);
  rect(150, 135, 62, 20);

  //2)--------HONGOS/percusion:---------//
    fill(APAGADO);
    rect(350, 35, 20, 20);  //1
    rect(350, 85, 20, 20);  //2
    rect(350, 135, 20, 20); //3
    // ---------//
    rect(385, 85, 20, 20);  //5
}
