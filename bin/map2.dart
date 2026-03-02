void main(){
  Map<String,dynamic> stud ={
    'name' : 'keerthana',
    'age'  : 23,
    'course' : 'Flutter',
  };
  stud.forEach((key, value) {
    print('$key : $value');
  });
}