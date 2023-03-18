#include <DHT.h>
#define DHTTYPE DHT11
const float DHTPIN = 4;

DHT dht(DHTPIN, DHTTYPE);
float Humedad;
float Temperatura;

void setup() {
  Serial.begin(9600);
  dht.begin();
}

void loop() {
  Humedad = dht.readHumidity();
  Temperatura = dht.readTemperature();
  if(isnan(Temperatura) || isnan(Temperatura)){
    Serial.println("ERROR EN EL SENSOR");
    return;
  }
  Serial.print(Temperatura);
  Serial.print(",");
  Serial.print(Humedad);
  Serial.print(",");
  
  Serial.println();
  delay(5000); 
}
