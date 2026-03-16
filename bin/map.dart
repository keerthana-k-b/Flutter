void main(){
  Map<String,dynamic> student = {
    'name' : 'Keerthana',
    'age' : 25,
  };
  student['course'] ='Flutter';
  student['age'] = 19;
  print(student);
  print(student['name']);
  //student.remove('course');
  //print(student);
  print(student.containsKey('name'));
  print(student.containsValue('Flutter'));

  student.forEach((key, value){
    print('$key : $value');
  });

  print(student.keys.toList());
  print(student.values.toList());
}