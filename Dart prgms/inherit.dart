class Animal{
  void sound(){
    print("Animal makes a sound");
  }
}

class Dog extends Animal{
  void bark(){
    print("Dog Barks");
  }
}

void main(){
  Dog d = Dog();
  d.sound();
  d.bark();
}