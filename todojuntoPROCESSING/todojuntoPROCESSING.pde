import ddf.minim.*;
import processing.serial.*;

Minim minim;
AudioPlayer do_, re, mi, fa, sol;
AudioPlayer[] jackSonidos = new AudioPlayer[10]; // índices del 0 al 9 (no usaremos el 0)
boolean[] jackConectado = new boolean[10];       // estado de cada jack (0 no se usa)

Serial arduino;

void setup() {
  size(400, 200);
  minim = new Minim(this);

  // Cargar sonidos de sensores capacitivos
  do_ = minim.loadFile("percu1.mp3");
  re  = minim.loadFile("percu2tambores.mp3");
  mi  = minim.loadFile("percu3.mp3");
  fa  = minim.loadFile("percu4.mp3"); 
  sol = minim.loadFile("percu5.mp3");

  // Cargar sonidos de jacks (del 1 al 9)
  for (int i = 1; i <= 9; i++) {
    jackSonidos[i] = minim.loadFile("jack" + i + ".mp3");
  }

  // Conectar al puerto serie (elige el puerto correcto según Serial.list())
  String[] puertos = Serial.list();
  println("Puertos disponibles:");
  for (int i = 0; i < puertos.length; i++) {
    println(i + ": " + puertos[i]);
  }

  // Cambia el índice aquí si necesitas usar otro puerto
  arduino = new Serial(this, puertos[0], 9600);
}

void draw() {
  while (arduino.available() > 0) {
    int dato = arduino.read();

    // Mostrar el dato recibido (debug)
    println("Dato recibido: " + dato + " (" + (char)dato + ")");

    // Ignorar valores no válidos
    if ((dato < 1 || dato > 9) && 
        (dato < 101 || dato > 109) && 
        (dato != 'A' && dato != 'B' && dato != 'C' && dato != 'D' && dato != 'E')) {
      println("Dato ignorado: fuera de rango esperado.");
      return;
    }

    // Sensores capacitivos (percusión)
    if (dato == 'A') reproducir(do_);
    else if (dato == 'B') reproducir(re);
    else if (dato == 'C') reproducir(mi);
    else if (dato == 'D') reproducir(fa);
    else if (dato == 'E') reproducir(sol);

    // Jacks conectados (valores del 1 al 9)
    else if (dato >= 1 && dato <= 9) {
      if (!jackConectado[dato]) {
        if (jackSonidos[dato] != null) {
          jackSonidos[dato].loop(); // Reproduce en bucle
        }
        jackConectado[dato] = true;
        println("Jack " + dato + " conectado.");
      }
    }

    // Jacks desconectados (valores 101 a 109)
    else if (dato >= 101 && dato <= 109) {
      int jack = dato - 100;
      if (jack >= 1 && jack <= 9 && jackConectado[jack]) {
        detener(jackSonidos[jack]);
        jackConectado[jack] = false;
        println("Jack " + jack + " desconectado.");
      }
    }
  }
}

void reproducir(AudioPlayer sonido) {
  if (sonido != null && !sonido.isPlaying()) {
    sonido.rewind();  // Para que empiece desde el principio
    sonido.play();
  }
}

void detener(AudioPlayer sonido) {
  if (sonido != null && sonido.isPlaying()) {
    sonido.pause();
    sonido.rewind();
  }
}



/*
import ddf.minim.*;
import processing.serial.*;

Minim minim;
AudioPlayer do_, re, mi, fa, sol;
AudioPlayer[] jackSonidos = new AudioPlayer[10]; // jack1 a jack9
boolean[] jackConectado = new boolean[10];       // Estado de cada jack

Serial arduino;

void setup() {
  size(400, 200);
  minim = new Minim(this);

  // Cargar sonidos de sensores capacitivos
  do_ = minim.loadFile("percu1.mp3");
  re  = minim.loadFile("percu2tambores.mp3");
  mi  = minim.loadFile("percu3.mp3");
  fa  = minim.loadFile("percu4.mp3"); 
  sol = minim.loadFile("percu5.mp3");
  
  //sol.setGain(-30);

  // Cargar sonidos de jacks
  for (int i = 1; i <= 9; i++) {
    jackSonidos[i] = minim.loadFile("jack" + i + ".mp3");
      //jackSonidos[i].setGain(-30);
  }
  
  //jackSonidos[0].setGain(-30);


  arduino = new Serial(this, Serial.list()[0], 9600);
  //println(Serial.list());
}

void draw() {
  
  
  //println(jackSonidos[0].isPlaying());
  
  while (arduino.available() > 0) {
    int dato = arduino.read();

    // Sensores capacitivos
    if (dato == 'A') reproducir(do_);
    else if (dato == 'B') reproducir(re);
    else if (dato == 'C') reproducir(mi);
    else if (dato == 'D') reproducir(fa);
    else if (dato == 'E') reproducir(sol);

    // Jacks conectados
    else if (dato >= 1 && dato <= 9) {
      if (!jackConectado[dato]) {
        if (jackSonidos[dato] != null) {
          jackSonidos[dato].play(); // Reproduce en bucle
        }
        jackConectado[dato] = true;
      }
    }

    // Jacks desconectados
    else if (dato >= 101 && dato <= 109) {
      int jack = dato - 100;
      if (jackConectado[jack]) {
        detener(jackSonidos[jack]);
        jackConectado[jack] = false;
      }
    }
        
  }
}

void reproducir(AudioPlayer sonido) {
  if (sonido != null && !sonido.isPlaying()) {
    sonido.play(); // Percusión: suena una vez
  }
}

void detener(AudioPlayer sonido) {
  if (sonido != null && sonido.isPlaying()) {
    sonido.pause();
    sonido.rewind();
  }
}
*/
