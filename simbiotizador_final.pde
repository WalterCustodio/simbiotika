import ddf.minim.*;
import processing.serial.*;

Minim minim;
Serial puerto;

AudioPlayer ambiente;

AudioPlayer[] jackSonidos = new AudioPlayer[9];
AudioPlayer[] capacitivos = new AudioPlayer[5];

boolean[] jackActivo = new boolean[9];

int[] tiempoInicioCap = new int[5];
int[] tiempoUltimaRecepcionCap = new int[5];
boolean[] aumentoHechoCap = new boolean[5];
int[] ultimoMensajeCap = new int[5];

final float GANANCIA_BASE = 5;  // Ganancia base para capacitivos

void setup() {
  size(500, 400);  // Puede quedar, aunque ya no la uses
  minim = new Minim(this);

  // Puerto Serial (ajustá el nombre si es necesario)
  puerto = new Serial(this, "COM4", 9600);
  puerto.clear();
  puerto.bufferUntil('\n');

  // AMBIENTE
  ambiente = minim.loadFile("data/ambiente.mp3");
  ambiente.setGain(-20);
  ambiente.loop();

  // JACKS
  for (int i = 0; i < 9; i++) {
    jackSonidos[i] = minim.loadFile("data/jack" + i + ".mp3");
    jackSonidos[i].setGain(-10); // ajustá si querés
  }

  // CAPACITIVOS
  capacitivos[0] = minim.loadFile("data/cap1.mp3");
  capacitivos[1] = minim.loadFile("data/cap2.mp3");
  capacitivos[2] = minim.loadFile("data/cap3.mp3");
  capacitivos[3] = minim.loadFile("data/cap4.mp3");
  capacitivos[4] = minim.loadFile("data/percu5.mp3");

  for (int i = 0; i < 5; i++) {
    capacitivos[i].setGain(GANANCIA_BASE);
    tiempoInicioCap[i] = millis();
    tiempoUltimaRecepcionCap[i] = millis();
    aumentoHechoCap[i] = false;
    ultimoMensajeCap[i] = -1;
  }
}

void draw() {
  while (puerto.available() > 0) {
    String dato = puerto.readStringUntil('\n');
    if (dato != null) {
      dato = trim(dato);
      int mensaje = int(dato);

      println("Dato recibido: " + mensaje);

      // AMBIENTE
      if ((mensaje >= 101 && mensaje <= 109) || (mensaje >= 200 && mensaje <= 204)) {
        ambiente.pause();
        ambiente.rewind();
      } else {
        ambiente.play();
        if (ambiente.position() >= ambiente.length()) {
          ambiente.rewind();
        }
      }

      // JACKS CONECTADOS
      if (mensaje >= 1 && mensaje <= 9) {
        int index = mensaje - 1;
        if (!jackSonidos[index].isPlaying()) {
          jackSonidos[index].loop();
          jackActivo[index] = true;
          println("Loop jack " + index);
        }
      }

      // JACKS DESCONECTADOS
      else if (mensaje >= 101 && mensaje <= 109) {
        int index = mensaje - 101;
        if (jackSonidos[index].isPlaying()) {
          jackSonidos[index].pause();
          jackSonidos[index].rewind();
          jackActivo[index] = false;
          println("Paro jack " + index);
        }
      }

      // HONGOS CAPACITIVOS
      else if (mensaje >= 200 && mensaje <= 204) {
        int index = mensaje - 200;
        if (index >= 0 && index < 5) {

          if (!capacitivos[index].isPlaying()) {
            capacitivos[index].rewind();
            capacitivos[index].play();
            println("Percusión hongo " + index);
          }

          int tiempoAhora = millis();

          // Registrar última vez que se recibió este mensaje
          tiempoUltimaRecepcionCap[index] = tiempoAhora;

          // Aumento de ganancia si se mantiene durante 5s
          if (!aumentoHechoCap[index] && tiempoAhora - tiempoInicioCap[index] > 5000) {
            float currentGain = capacitivos[index].getGain();
            capacitivos[index].setGain(min(currentGain + 3, 6));
            println("↑ Aumento de ganancia hongo " + index + ": " + (currentGain + 3));
            aumentoHechoCap[index] = true;
          }

          // Si el mensaje recién empieza, reiniciar contador
          if (ultimoMensajeCap[index] != mensaje) {
            tiempoInicioCap[index] = tiempoAhora;
            aumentoHechoCap[index] = false;
            ultimoMensajeCap[index] = mensaje;
          }
        }
      }
    }
  }

  // Revisar si hace más de 2 segundos que no se recibe señal, para bajar ganancia
  int ahora = millis();
  for (int i = 0; i < 5; i++) {
    if (ahora - tiempoUltimaRecepcionCap[i] > 2000) {
      if (capacitivos[i].getGain() != GANANCIA_BASE) {
        capacitivos[i].setGain(GANANCIA_BASE);
        println("↓ Ganancia reseteada del hongo " + i);
        aumentoHechoCap[i] = false;
      }
    }
  }
}
