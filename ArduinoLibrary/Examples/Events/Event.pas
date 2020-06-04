// Тестовая программа, показывающая механизм обработчиков событий
uses ArduinoABC;

//Обработчик события нажатия на кнопку
procedure MyUno_AnalogPinChanged(sender: Arduino; pin: integer; value: integer);
begin
  WritelnFormat('Вход {0} поменял свое значение на {1}', pin, value); 
end;

begin
  //Инициализация экземпляра Arduino прямо в секции объявления переменных
  var myUno := new Arduino('COM4');
  //Установка режима аналогово входа для всех пинов (контактов)
  for var i := 0 to 5 do
    myUno.SetPinMode(i, Arduino.PinMode.AnalogInput);
  
  //Привязка обработчика к событию
  myUno.AnalogPinChanged += MyUno_AnalogPinChanged;
  
  //Бесконечный цикл для корректной работы событий
  while (true) do
end.
