class Student{
  String name;
  int age;

  Student(this.name,this.age); //constructor

  Student.guest(): name = "Guest", age = 0;
}

void main(){
  Student s1 = Student("Keerthana", 23);
  Student s2 = Student.guest();

  print(s1.name);
  print(s2.name);
}