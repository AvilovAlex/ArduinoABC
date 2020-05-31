// Тестовая прогрмма, показывающая как плавно включается и выключается светодиод, подключенный к 11 выходу

uses ArduinoABC;

const
  ///Номер пина, к которому подключен светодиод
  ledPin = 11;
  ///Задежрка между изменением яркости в мс.
  delay = 2;

begin
  //Инициализация экземпляра Arduino
  var myUno := new Arduino('COM4', 10, true);
  
  //Установка режимов входов/выходов
  myUno.SetPinMode(ledPin, AnalogOutput);
  
  while (true) do
  begin
    //Плавное увеличение яркости
    for var i := 0 to 255 do
    begin
      myUno.AnalogWrite(ledPin, i);
      Sleep(delay);
    end;
    //Плавное уменьшение яркости
    for var i := 255 downto 0 do
    begin
      myUno.AnalogWrite(ledPin, i);
      Sleep(delay);
    end;
  end;
end.