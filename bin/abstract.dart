abstract class Vehicle{
  void start();   //abstract method
}

class Bike extends Vehicle{
  @override
  void start(){
    print("Bike starts with key");
  }
}

void main(){
  Bike b = Bike();
  b.start();
}