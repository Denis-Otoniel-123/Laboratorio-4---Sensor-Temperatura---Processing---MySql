import de.bezier.data.sql.*;
import processing.serial.*;

Serial puertoSerie;
MySQL msql;

float Humedad = 0, Temperatura = 0;

void setup() {
  size(300, 300);
  frameRate(200);
  puertoSerie = new Serial(this, "COM3", 9600);
  puertoSerie.bufferUntil('\n');
  String user     = "root";
  String pass     = "";
  String dbHost   = "localhost";
  String database = "arduino";
  msql = new MySQL( this, dbHost, database, user, pass );
  if (msql.connect()) {
    println( "Conectado" );
  } else {
    println( "FAIL" );
  }
}

void draw() {
  background(300);
  String Valor = puertoSerie.readStringUntil('\n');

  if (Valor != null) {
    float[] Values = float(split(Valor, ","));

    textSize(30);
    text("Temperatura: " + Values[0] + "°C", 20, 120);
    Temperatura = Values[0];

    textSize(30);
    text("Humedad: " + Values[1] + "%", 20, 200);
    Humedad = Values[1];

    msql.execute("Insert into Arduino.Registro (Temperatura, Humedad, Hora) Values ("+Temperatura+", "+Humedad+", NOW());");
     delay(5000);
  }
}
