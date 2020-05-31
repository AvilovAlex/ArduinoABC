// Тестовая прогрмма, показывающая вращение 3D модели от движения джойстика Arduino
uses Graph3D, ArduinoABC;

const
  ///Номер пина, к которому подключен выход движения джойстика HW-504 по оси X
  xPin = 0;
  ///Номер пина, к которому подключен выход движения джойстика HW-504 по оси Y
  yPin = 1;
  ///
  delta = 10;

var
  ggg: Group3D;

//Обработчик события нажатия на кнопку
procedure MakeRotate(pin: integer; value: integer);
begin
  
  var delta := value - 512;
  var fx := 0;
  var fy := 0;
  case pin of
    //Инверсия необходима из-за того, что джойстик HW-504 инвертирован по оси Y
    yPin: fy := delta;
    xPin: fx := delta;
  end;
  
  ggg.AnimRotate(OrtZ, fx / 10, 0.5).Begin;
end;

function MultipleClones(c: Object3D; N: integer): Group3D;
begin
  var g := Group(c);
  loop N - 1 do
  begin
    c := c.Clone;
    c.MoveOnX(-1.5);
    if c is ObjectWithMaterial3D then 
      (c as ObjectWithMaterial3D).Color := RandomColor;
    g.AddChild(c);
  end;
  Result := g;
end;

begin
  
  //Инициализация экземпляра Arduino
  var myUno := new Arduino('COM4');
  
  var b := Box(0, 0, 2, 14.5, 1, 4, Colors.Orange);
  var c := Cube(6.75, 0, 4.5, 1, RandomColor);
  var c1 := Cone(6.75, 0, 5, 1.5, 0.4, RandomColor);
  var g := MultipleClones(c, 10);
  var gp := MultipleClones(c1, 10);
  var gg := Group(g, b, gp);
  var g1 := gg.Clone.MoveOnY(6);
  var g2 := gg.Clone.MoveOnY(-6);
  gg.Rotate(OrtZ, 90);
  var g3 := gg.Clone.MoveOnX(-6);
  gg.MoveOnX(6);
  ggg := Group(gg, g1, g2, g3);
  ggg.Save('Замок.xaml');
  
  var predFx := 0;
  var predFy := 0;
  
  while (true) do
  begin
    var fx := myUno.AnalogRead(xPin);
    if (Abs(fx - predFx) > delta) then
    MakeRotate(xPin, fx);
    var fy := myUno.AnalogRead(yPin);
    if (Abs(fy - predFy) > delta) then
    MakeRotate(yPin, fy);
    sleep(10);
  end;
end.