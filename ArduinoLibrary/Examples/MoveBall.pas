uses WPFObjects, ArduinoABC;

const
  scale = 0.5;
  xPin = 0;
  yPin = 1;
  buttonPin = 7;

//Инициализация экземпляра Arduino
var
  myUno := new Arduino('COM4');

//  Парсинг строки вида "511;400;1;" - координаты джойстика и статус кнопки
function GetJoyStickState() : (real, real, boolean);
begin
  
  Result := (real(myUno.AnalogRead(xPin)), real(myUno.AnalogRead(yPin)), myUno.DigitalRead(buttonPin));
end;

begin

  myUno.setpinmode(xPin, AnalogInput);
  myUno.setpinmode(yPin, AnalogInput);
  myUno.setpinmode(buttonPin, DigitalInput);
  
  var Ball := CircleWPF.Create(100, 100, 25, Colors.Red);
  
  var (zeroX, zeroY, btnState) := GetJoyStickState();
  //  Первую порцию данных используем для инициализации нулевого положения
  zeroX := scale * zeroX - Window.Center.X;
  zeroY := scale * zeroY - Window.Center.Y;
  //  В цикле принимаем данные, и двигаем объект.
  while true do
  begin
    var x, y: real;
      //  Принимаем текущее положение джойстика
    (x, y, btnState) := GetJoyStickState();
      //  Двигаем объект
    Ball.MoveTo( scale * (1024 - x) - zeroX, scale * y - zeroY);
    if btnState then Ball.Color := RandomColor;
  end;
end.