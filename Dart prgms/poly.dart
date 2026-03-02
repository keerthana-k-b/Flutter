class Shape{
  void draw(){                //same method name
    print("Drawing Shape");   
  }
}

class Circle extends Shape{
  @override
  void draw(){                //same method name
    print("Drawing circle");
  }
}

void main(){
  Shape s = Circle();
  s.draw();    //call Circle's draw()
}