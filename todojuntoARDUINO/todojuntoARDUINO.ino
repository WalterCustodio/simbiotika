#include <CapacitiveSensor.h>

// Pines de jacks (del 2 al 10)
const int jackPins[9] = {2, 3, 4, 5, 6, 7, 8, 9, 10};
bool estadosAnteriores[9];

// Sensores capacitivos
CapacitiveSensor cap0 = CapacitiveSensor(13, A0);
CapacitiveSensor cap1 = CapacitiveSensor(13, A1);
CapacitiveSensor cap2 = CapacitiveSensor(13, A2);
CapacitiveSensor cap3 = CapacitiveSensor(11, A3);
CapacitiveSensor cap4 = CapacitiveSensor(11, A4);

// Umbral de activación táctil
const long umbralCapacitivo = 5000;

void setup() {
  Serial.begin(9600);

  // Inicialización de jacks
  for (int i = 0; i < 9; i++) {
    pinMode(jackPins[i], INPUT_PULLUP);
    estadosAnteriores[i] = digitalRead(jackPins[i]);
  }

  // Opcional: calibrar los sensores capacitivos
  cap0.set_CS_AutocaL_Millis(0xFFFFFFFF);
  cap1.set_CS_AutocaL_Millis(0xFFFFFFFF);
  cap2.set_CS_AutocaL_Millis(0xFFFFFFFF);
  cap3.set_CS_AutocaL_Millis(0xFFFFFFFF);
  cap4.set_CS_AutocaL_Millis(0xFFFFFFFF);
}

void loop() {
  // Lectura de jacks
  for (int i = 0; i < 9; i++) {
    bool estadoActual = digitalRead(jackPins[i]);

    if (estadoActual != estadosAnteriores[i]) {
      int mensaje = estadoActual == HIGH ? (i + 1) : (100 + i + 1);
      Serial.println(mensaje);
      estadosAnteriores[i] = estadoActual;
    }
  }

  // Lectura de capacitivos
  if (cap0.capacitiveSensor(30) > umbralCapacitivo) {
    Serial.println(200);
  }
  if (cap1.capacitiveSensor(30) > umbralCapacitivo  ) {
    Serial.println(201);
  }
  if (cap2.capacitiveSensor(30) > umbralCapacitivo - 4750) {
    Serial.println(202);
  }
  if (cap3.capacitiveSensor(30) > umbralCapacitivo - 4750 ) {
    Serial.println(203);
  }
  if (cap4.capacitiveSensor(30) > umbralCapacitivo ) {
    Serial.println(204);
  }

    // Suaviza la lectura
}