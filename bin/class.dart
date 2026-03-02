class Student{
  String name = "Keerthana";
  int age = 23;

  void display(){            //function
    print("Name : $name \nAge : $age");
  }
}

void main(){
  Student s = Student(); //object
  s.display();
}