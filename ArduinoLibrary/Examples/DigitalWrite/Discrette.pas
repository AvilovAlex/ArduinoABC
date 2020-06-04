// Классическая тестовая прогрмма, мигающая светодиодом подключенному к 13 выходу
// 'Hello World!' в мире Arduino

uses ArduinoABC;

const
  ///Номер пина, к которому подключен светодиод
  ledPin = 13;
  ///Задежрка между включением и выключением в мс.
  delay = 500;

begin
  //Инициализация экземпляра Arduino
  var myUno := new Arduino('COM4');
  
  //Установка режимов входов/выходов
  myUno.SetPinMode(ledPin, DigitalOutput);
  
  while (true) do
  begin
    myUno.DigitalWrite(ledPin, true);
    Sleep(delay);
    myUno.DigitalWrite(ledPin, false);
    Sleep(delay);
  end;
end.