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

 //ver como pasar de tempo de un sonido a otro (para encender quizas solo reiniciando se soluciona... 
//pero para apagar quizas suene raro)






import ddf.minim.*;
Minim minim;
AudioPlayer cumbia, bombo, tango, gotas, brasas, caracola, cantoMarosa, coroToba, cantoUnDia, cuenco, zumbido, sHongo1, sHongo2, sHongo3, sHongo4, sHongo5, sHongo6;


String[] Ritmo = new String[3];
String[] Naturaleza = new String[3];
String[] Zumbido = new String[3];
String[] Voces = new String[3];
int sonido1, sonido2, sonido3, sonido4;
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
int bpmF = bpm*2;
int intervaloF = 60000 / bpmF; // milisegundos entre beats
int ultimoGolpeBeatF = 0;
boolean seGolpeoBeatF = false; 


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
  
  //HONGOS-------------
  sHongo1 = minim.loadFile("data/hongos/do.mp3", 1024);
  sHongo2 = minim.loadFile("data/hongos/re.mp3", 1024);  
  sHongo3 = minim.loadFile("data/hongos/mi.mp3", 1024);
  sHongo4 = minim.loadFile("data/hongos/fa.mp3", 1024); 
  sHongo5 = minim.loadFile("data/hongos/sol.mp3", 1024);
  sHongo6 = minim.loadFile("data/hongos/la.mp3", 1024);

  sonido1 = 50;
  sonido2 = 50;
  sonido3 = 50;
  sonido4 = 50;
  
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
  InterfazSinInteraccion();

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
  
  //HONGOS---------------------
  if (modoFacilActivado) {
    HongosModoFacil();
  } else {
      HongosModoNormal();
  }
  
  //--------------Metronomo-----------------
  rect(199, 337, 20, 20);
  if (millis() - ultimoGolpeBeat >= intervalo) { 
      //println("Beat!");
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
  
} // cierre draw



void keyPressed() {
   if (keyCode == UP) {
    modoFacilActivado = true;
  } else if (keyCode == DOWN) {
    modoFacilActivado = false;
  }
  
  if (key == 'a' || key == 'A') { //letra A mayuscula
       sePideSonido = true;
    sonido1=1;    
  }
  if (key == 'b' || key == 'B') { // B
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
  if (key == '4') { // 4
    hongo1=4;
        
    if (modoFacilActivado) {
    estaApretado = true;
    }
  }
  if (key == '5') { // 5
    hongo1=5;
    
    if (modoFacilActivado) {
      estaApretado = true;
      }
    }
    if (key == '6') { //6
      hongo1=6;
      
    if (modoFacilActivado) {
    estaApretado = true;
    }
  }
}


void HongosModoNormal() {
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
      
      
      if (hongo1==4) {
        push();
        fill(PRENDIDO);
        rect(385, 35, 20, 20); 
        pop();      
 
        sHongo4.play();
 
      }else {
         sHongo4.pause();
         sHongo4.rewind();         
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
      
      if (hongo1==6) {
        push();
        fill(PRENDIDO);
        rect(385, 135, 20, 20); 
        pop();
  
        sHongo6.play();
 
      }else {
         sHongo6.pause();
         sHongo6.rewind();         
      } 
}






void HongosModoFacil() {
  println(mouseX, mouseY);
  text("Modo facil", 445, 13);
  
  if (millis() - ultimoGolpeBeatF >= intervaloF) { 
      println("Beat!");
      ultimoGolpeBeatF = millis();

      seGolpeoBeatF = true; //"se golpeó" se activa cada vez que el tempo golpea (hace pulso/beat)
      
      fill(PRENDIDOSinTocar); //luz celeste
      
      //----metronomo (Cuadrado negro)----
      //hongos
      rect(350, 35, 20, 20);  
      rect(350, 85, 20, 20);  
      rect(350, 135, 20, 20); 
      // ---------//
      rect(385, 35, 20, 20);  
      rect(385, 85, 20, 20); 
      rect(385, 135, 20, 20);      
     } else {
           seGolpeoBeatF = false;       
     } //fin metronomo
    
    println(ultimoGolpeBeatF);
    
        //-----HONGOS----AL PRESIONAR:
    if (estaApretado == true) {
      if (hongo1==1) {
        push();     
        fill(PRENDIDO);
        rect(350, 35, 20, 20);
        pop();     
        if (seGolpeoBeatF == true) {
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
        if (seGolpeoBeatF == true) {
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
        if (seGolpeoBeatF == true) {
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
        if (seGolpeoBeatF == true) {
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
        if (seGolpeoBeatF == true) {
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
        if (seGolpeoBeatF == true) {
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
}

















void InterfazSinInteraccion() {
    background(255);
  textSize(18);
  text("Ritmo:A,B,C\nNaturaleza:D,E,F\nZumbido:G,H\nVoces:J,K,L", 18, 200);
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
 // rect(147, 135, 62, 20);
  //-----ZUMBIDO---//
  rect(1470, 35, 62, 20);
  rect(147, 85, 62, 20);
  //rect(147, 135, 62, 20);
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
}
