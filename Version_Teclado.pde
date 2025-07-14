
//jacks
int[] columnaDeJacks = new int[3]; //3 es la cantidad de columnaDeJackss de los jacks
boolean[] jackConectado = new boolean[9];       // ===estado de cada jack (0 no se usa)

//hongos:
boolean activarHongo1 = false;
boolean activarHongo2 = false;
boolean activarHongo3 = false;
boolean activarHongo4 = false;


//int hongo1;


color PRENDIDO = color(0, 125, 0);
color APAGADO = color(125);

//-- codigo para la logica bpm
color PRENDIDOSinTocar = 0; 
color PRENDIDOAlTocar = color(246, 255, 0); 
int bpm = 120;
int intervalo = 60000 / bpm; // milisegundos entre beats
int ultimoGolpeBeat = 0;
boolean seGolpeoBeat = false;  
//--

boolean sePideSonido = false;  //se prenden cada vez que se enchufa un jack
boolean sePideSonido2 = false;
boolean sePideSonido3 = false;
boolean sePideSonido4 = false;


void VersionTeclado() {
    InterfazSinInteraccion();
  
// Logica para que suene el sonido de ambiente
    if (columnaDeJacks[0] != 50 || columnaDeJacks[1] != 50 || columnaDeJacks[2] != 50) {
      ambiente.pause();
      ambiente.rewind();
    } else {
      ambiente.play();
      if (ambiente.position() >= ambiente.length()) {
        ambiente.rewind();
      }
    }


  //JACKS
  
  //quizas el problema es que si se mantiene con el sonidos activado de un numero anterior entra en conflicto
  
  // COLUMNA 2: jackSonidos[6], [7], [8]
  if (columnaDeJacks[2] >= 0 && columnaDeJacks[2] <= 2) {
    int i = columnaDeJacks[2] + 6; // calcula el índice correcto
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
    if (columnaDeJacks[2] == 50 && jackSonidos[i].isPlaying()) {
      jackSonidos[i].pause();
      jackSonidos[i].rewind();
      println("Detenido jackSonido " + i);
    }
  }
      
    // COLUMNA 1: jackSonidos[3], [4], [5]
  if (columnaDeJacks[1] >= 0 && columnaDeJacks[1] <= 2) {
    int i = columnaDeJacks[1] + 3; // calcula el índice correcto
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
    if (columnaDeJacks[1] == 50 && jackSonidos[i].isPlaying()) {
      jackSonidos[i].pause();
      jackSonidos[i].rewind();
      println("Detenido jackSonido " + i);
    }
  }

  

  //------INTERACCIÓN----------// 
  //COLUMNA 0
   for (int i = 0; i <= 2; i++) { //probar cambiando el largo de array   
     //--Conectado 0
     if (columnaDeJacks[0] == i) { 
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
     if (columnaDeJacks[0] == 50 && jackSonidos[i].isPlaying()) { //si se vuelve a pulsar A se desconecta
        jackSonidos[i].pause();
        jackSonidos[i].rewind();
        println("Detenido jackSonido" + i);
     }
   } //fin de for i
  
  
 //----HONGOS-------------------------- 


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

}

//
void detenerJacks(int columnaDeJacksIndex) {
  
  if (columnaDeJacksIndex == 2) {
    for (int i = 6; i <= 8; i++) {
      if (i != columnaDeJacks[2] + 6 && jackSonidos[i].isPlaying()) {
        jackSonidos[i].pause();
        jackSonidos[i].rewind();
      }
    }
  }

  
  if (columnaDeJacksIndex == 1) {
    for (int i = 3; i <= 5; i++) {
      if (i != columnaDeJacks[1] + 3 && jackSonidos[i].isPlaying()) {
        jackSonidos[i].pause();
        jackSonidos[i].rewind();
      }
    }
  }


  if (columnaDeJacksIndex == 0) {
    for (int i = 0; i <= 2; i++) { //columnaDeJacks0 (va de 0 a 3)
      if (i != columnaDeJacks[0] && jackSonidos[i].isPlaying()) {
        jackSonidos[i].pause();
        jackSonidos[i].rewind();
      }
    }
  }
}




void keyPressed() {
  //COLUMNA 0
  if (key == 'a' || key == 'A') {
      if (columnaDeJacks[0] == 0 && jackSonidos[0].isPlaying()) {
        //sePideSonido se desactiva solo
        columnaDeJacks[0] = 50;
      } else {
        sePideSonido = true;
        columnaDeJacks[0] = 0;
      }
  }
  
  if (key == 'b' || key == 'B') {
      if (columnaDeJacks[0] == 1 && jackSonidos[1].isPlaying()) {
        //sePideSonido se desactiva solo
        columnaDeJacks[0] = 50;
      } else {
        sePideSonido = true;
        columnaDeJacks[0] = 1;
      }
  }
  
  if (key == 'c' || key == 'C') {
      if (columnaDeJacks[0] == 2 && jackSonidos[2].isPlaying()) {
        //sePideSonido se desactiva solo
        columnaDeJacks[0] = 50;
      } else {
        sePideSonido = true;
        columnaDeJacks[0] = 2;
      }
  }
  
  //cada columnaDeJacks tiene su propia escala de 0 a 2
  //COLUMNA 1
  if (key == 'd' || key == 'D') {
      if (columnaDeJacks[1] == 0 && jackSonidos[3].isPlaying()) {
        //sePideSonido se desactiva solo
        columnaDeJacks[1] = 50;
      } else {
        sePideSonido2 = true;
        columnaDeJacks[1] = 0;
      }
  }
  
  if (key == 'e' || key == 'E') {
      if (columnaDeJacks[1] == 1 && jackSonidos[4].isPlaying()) {
        //sePideSonido se desactiva solo
        columnaDeJacks[1] = 50;
      } else {
        sePideSonido2 = true;
        columnaDeJacks[1] = 1;
      }
  }
  
   if (key == 'f' || key == 'F') {
      if (columnaDeJacks[1] == 2 && jackSonidos[5].isPlaying()) {
        //sePideSonido se desactiva solo
        columnaDeJacks[1] = 50;
      } else {
        sePideSonido2 = true;
        columnaDeJacks[1] = 2;
      }
  }
  
  
  // COLUMNA 2
  if (key == 'j' || key == 'J') {
    if (columnaDeJacks[2] == 0 && jackSonidos[6].isPlaying()) {
      columnaDeJacks[2] = 50;
    } else {
      sePideSonido3 = true;
      columnaDeJacks[2] = 0;
    }
  }
  
  if (key == 'k' || key == 'K') {
    if (columnaDeJacks[2] == 1 && jackSonidos[7].isPlaying()) {
      columnaDeJacks[2] = 50;
    } else {
      sePideSonido3 = true;
      columnaDeJacks[2] = 1;
    }
  }
  
  if (key == 'l' || key == 'L') {
    if (columnaDeJacks[2] == 2 && jackSonidos[8].isPlaying()) {
      columnaDeJacks[2] = 50;
    } else {
      sePideSonido3 = true;
      columnaDeJacks[2] = 2;
    }
  }

  
    ///-------------------------------- HONGOS ----------------------------//
  if (key == '1') activarHongo1 = true;
  if (key == '2') activarHongo2 = true;
  if (key == '3') activarHongo3 = true;
  if (key == '4') activarHongo4 = true;
}


void detener(AudioPlayer sonido) { //se usa para jacks
  if (sonido != null && sonido.isPlaying()) {
    sonido.pause();
    sonido.rewind();
  }
}



void HongosModoNormal() {
  if (activarHongo1 == true ) {
    capacitivos[0].rewind();
    capacitivos[0].play();
    fill(PRENDIDO);
    rect(350, 35, 20, 20);
    activarHongo1 = false; // desactivar después de tocar
  }

  if (activarHongo2) {
    capacitivos[1].rewind();
    capacitivos[1].play();
    fill(PRENDIDO);
    rect(350, 85, 20, 20);
    activarHongo2 = false;
  }

  if (activarHongo3) {
    capacitivos[2].rewind();
    capacitivos[2].play();
    fill(PRENDIDO);
    rect(350, 135, 20, 20);
    activarHongo3 = false;
  }

  if (activarHongo4) {
    capacitivos[3].rewind();
    capacitivos[3].play();
    fill(PRENDIDO);
    rect(385, 85, 20, 20);
    activarHongo4 = false;
  }
}



void InterfazSinInteraccion() {
    background(255);
  textSize(18);
  text("Ritmo:A,B,C\nNaturaleza:D,E,F\nVoces:J,K,L", 18, 200);
  text("Percu: 1, 2, 3, 4", 354, 200);

  text ("Tempo actual: "+bpm+ "BPM", 202, 373);

  textSize(12);
      text("columnaDeJacks 0      columnaDeJacks 1        columnaDeJacks 2", 17, 25);
  
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
