unit ArduinoABC;
{$reference ..\ResultDll\ArduinoLibrary.dll}

//Упрощение доступа к классу Arduino
type
  Arduino = ArduinoLibrary.Arduino;

//Упрощение доступа к перечислимому типу PinMode
type
  PinMode = ArduinoLibrary.Arduino.PinMode;

//Константы режимов работы без использования перечислимых типов
const
  ///Аналоговый вход
  AnalogInput = Arduino.PinMode.AnalogInput;
  ///Аналоговый выход
  AnalogOutput = Arduino.PinMode.AnalogOutput;
  ///Дискретный вход
  DigitalInput = Arduino.PinMode.DigitalInput;
  ///Дискретный выход
  DigitalOutput = Arduino.PinMode.DigitalOutput;
end.