//DESCOMENTAR EL CODIGO QUE QUERRAMOS USAR. estuvimmos probando con varios

const int jackPin = 22;

void setup() {
  Serial.begin(9600);
  pinMode(jackPin, INPUT_PULLUP);
}

void loop() {
  Serial.println(digitalRead(jackPin));
  delay(500);
}

/*
#include <CapacitiveSensor.h>

// ====== Sensores capacitivos (emisor, receptor) ======
CapacitiveSensor notaDO(A0, A5);
CapacitiveSensor notaRE(A0, A4);
CapacitiveSensor notaMI(A0, A3);
CapacitiveSensor notaFA(13, 5);
CapacitiveSensor notaSOL(12, 6);

// ====== Umbral ======
const long UMBRAL = 50;  // Aumenta si hay muchas falsas detecciones

// ====== Pines para jacks ======
const int jackPins[9] = {22, 23, 24, 25, 26, 27, 28, 29, 30};
bool jackAnterior[9] = {false, false, false, false, false, false, false, false, false};

void setup() {
  Serial.begin(9600);

  // Desactiva autocalibración para que los sensores mantengan valores estables
  notaDO.set_CS_AutocaL_Millis(0xFFFFFFFF);
  notaRE.set_CS_AutocaL_Millis(0xFFFFFFFF);
  notaMI.set_CS_AutocaL_Millis(0xFFFFFFFF);
  notaFA.set_CS_AutocaL_Millis(0xFFFFFFFF);
  notaSOL.set_CS_AutocaL_Millis(0xFFFFFFFF);

  // Configura los jacks como entrada con pull-up interno
  for (int i = 0; i < 9; i++) {
    pinMode(jackPins[i], INPUT_PULLUP);  // HIGH por defecto, LOW cuando se conecta a GND
  }
}

void loop() {
  // ====== Lectura de sensores capacitivos con prioridad ======
  long valores[5];
  valores[0] = notaDO.capacitiveSensor(30);
  valores[1] = notaRE.capacitiveSensor(30);
  valores[2] = notaMI.capacitiveSensor(30);
  valores[3] = notaFA.capacitiveSensor(30);
  valores[4] = notaSOL.capacitiveSensor(30);

  // Buscar el sensor con mayor valor
  int indiceMayor = -1;
  long maxValor = UMBRAL;
  for (int i = 0; i < 5; i++) {
    if (valores[i] > maxValor) {
      maxValor = valores[i];
      indiceMayor = i;
    }
  }

  // Enviar solo una letra (nota) a la vez
  if (indiceMayor != -1) {
    Serial.write('A' + indiceMayor);  // 'A' + 0 = 'A', 'A' + 1 = 'B', etc.
  }

  // ====== Lectura de jacks ======
  for (int i = 0; i < 9; i++) {
    bool conectado = (digitalRead(jackPins[i]) == LOW); // LOW = conectado con INPUT_PULLUP

    if (conectado != jackAnterior[i]) {
      if (conectado) {
        Serial.write(i + 1);       // Jack conectado: 1–9
      } else {
        Serial.write(i + 101);     // Jack desconectado: 101–109
      }
      jackAnterior[i] = conectado;
    }
  }

  delay(10); // Pequeño retardo para evitar ruido y sobrelectura
}
*/


/*
#include <CapacitiveSensor.h>

// ===== CONFIGURACIÓN =====

// Umbral de activación del sensor capacitivo (ajusta según pruebas)
const long UMBRAL_CAPACITIVO = 50;

// Pines de sensores capacitivos: (emisor, receptor)
CapacitiveSensor notaDO(A0, A5);
CapacitiveSensor notaRE(A0, A4);
CapacitiveSensor notaMI(A0, A3);
CapacitiveSensor notaFA(13, 5);
CapacitiveSensor notaSOL(12, 6);

// Pines digitales para los jacks (puedes cambiar los pines si usas otro modelo)
const int jackPins[9] = {22, 23, 24, 25, 26, 27, 28, 29, 30};
bool jackAnterior[9] = {false, false, false, false, false, false, false, false, false};

// Usa INPUT_PULLUP si no tienes resistencias pull-down externas
const bool USAR_PULLUP = true;

// ===== SETUP =====
void setup() {
  Serial.begin(9600);

  // Desactivar autocalibración de sensores capacitivos
  notaDO.set_CS_AutocaL_Millis(0xFFFFFFFF);
  notaRE.set_CS_AutocaL_Millis(0xFFFFFFFF);
  notaMI.set_CS_AutocaL_Millis(0xFFFFFFFF);
  notaFA.set_CS_AutocaL_Millis(0xFFFFFFFF);
  notaSOL.set_CS_AutocaL_Millis(0xFFFFFFFF);

  // Inicializar pines de jack
  for (int i = 0; i < 9; i++) {
    if (USAR_PULLUP) {
      pinMode(jackPins[i], INPUT_PULLUP);  // Requiere invertir lógica de lectura
    } else {
      pinMode(jackPins[i], INPUT);         // Necesita resistencias pull-down externas
    }
  }
}

// ===== LOOP =====
void loop() {
  // --- Lectura de sensores capacitivos ---
  if (notaDO.capacitiveSensor(30) > UMBRAL_CAPACITIVO)  Serial.write('A');
  if (notaRE.capacitiveSensor(30) > UMBRAL_CAPACITIVO)  Serial.write('B');
  if (notaMI.capacitiveSensor(30) > UMBRAL_CAPACITIVO)  Serial.write('C');
  if (notaFA.capacitiveSensor(30) > UMBRAL_CAPACITIVO)  Serial.write('D');
  if (notaSOL.capacitiveSensor(30) > UMBRAL_CAPACITIVO) Serial.write('E');

  // --- Lectura de jacks digitales ---
  for (int i = 0; i < 9; i++) {
    bool conectado;
    if (USAR_PULLUP) {
      conectado = (digitalRead(jackPins[i]) == LOW);  // Conectado cuando está en LOW
    } else {
      conectado = (digitalRead(jackPins[i]) == HIGH); // Conectado cuando está en HIGH
    }

    if (conectado != jackAnterior[i]) {
      if (conectado) {
        Serial.write(i + 1);     // Jack conectado → 1–9
      } else {
        Serial.write(i + 101);   // Jack desconectado → 101–109
      }
      jackAnterior[i] = conectado;
    }
  }

  delay(10); // Pequeño retardo para estabilidad
}*/

/*

#include <CapacitiveSensor.h>

// Sensores capacitivos (sender, receiver)
CapacitiveSensor notaDO(A0, A5);
CapacitiveSensor notaRE(A0, A4);
CapacitiveSensor notaMI(A0, A3);
CapacitiveSensor notaFA(13, 5);
CapacitiveSensor notaSOL(12, 6);

const long umbral = 30;  // Umbral de activación

// Pines de jacks (deben ir conectados a GND con pull-down si es necesario)
const int jackPins[9] = {22, 23, 24, 25, 26, 27, 28, 29, 30};
bool jackAnterior[9] = {false, false, false, false, false, false, false, false, false};

void setup() {
  Serial.begin(9600);

  // Opcional: Desactivar autocalibración
  notaDO.set_CS_AutocaL_Millis(0xFFFFFFFF);
  notaRE.set_CS_AutocaL_Millis(0xFFFFFFFF);
  notaMI.set_CS_AutocaL_Millis(0xFFFFFFFF);
  notaFA.set_CS_AutocaL_Millis(0xFFFFFFFF);
  notaSOL.set_CS_AutocaL_Millis(0xFFFFFFFF);

  // Inicializar pines de jack como entrada
  for (int i = 0; i < 9; i++) {
    pinMode(jackPins[i], INPUT);
  }
}

void loop() {
  // Sensores capacitivos
  if (notaDO.capacitiveSensor(30) > umbral)  Serial.write('A');
  if (notaRE.capacitiveSensor(30) > umbral)  Serial.write('B');
  if (notaMI.capacitiveSensor(30) > umbral)  Serial.write('C');
  if (notaFA.capacitiveSensor(30) > umbral)  Serial.write('D');
  if (notaSOL.capacitiveSensor(30) > umbral) Serial.write('E');

  // Jacks
  for (int i = 0; i < 9; i++) {
    bool conectado = digitalRead(jackPins[i]) == HIGH;

    if (conectado != jackAnterior[i]) {
      if (conectado) {
        Serial.write(i + 1);       // Jack conectado → 1–9
      } else {
        Serial.write(i + 101);     // Jack desconectado → 101–109
      }
      jackAnterior[i] = conectado;
    }
  }

  delay(10); // Evitar sobrecarga
}*/
