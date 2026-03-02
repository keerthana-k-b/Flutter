
class Person{
  String name;

  Person(this.name);  //constructor

  void show(){
    print("Name: $name");
  }
}

void main(){
  Person p = Person("Keerthana");
  p.show();
}