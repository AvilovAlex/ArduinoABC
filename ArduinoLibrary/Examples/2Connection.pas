// Тестовая прогрмма, показывающая одновременную работу двух плат Arduino
// С нефиксирующей кнопкой благодаря флагу получается эффект фиксирующейся кнопки
uses ArduinoABC;

const
  buttonPin = 4;
  ledPin = 11;

var
  //Инициализация экземпляров Arduino прямо в секции объявления переменных
  myUno := new Arduino('COM4');
  myUno2 := new Arduino('COM5');
  //Флаг, показывающий, включен ли светодиод
  enable := false;

//Обработчик события нажатия на кнопку
procedure MyUno_DigitalPinChanged(sender: Arduino; pin: integer; value: boolean);
begin
  if ((pin = buttonPin) and (value)) then
  begin
    myUno2.DigitalWrite(ledPin, enable);
    enable := not enable;
  end;
end;

begin
  //Установка режимов входов/выходов
  myUno.SetPinMode(buttonPin, Arduino.PinMode.DigitalInput);
  myUno2.SetPinMode(ledPin, Arduino.PinMode.DigitalOutput);
  
  //Привязка обработчика к событию
  myUno.DigitalPinChanged += MyUno_DigitalPinChanged;
  
  //Бесконечный цикл для корректной работы событий
  while (true) do
end.