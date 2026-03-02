void main(){
  List<Map<String,dynamic>> lst= [
    {'id': 1, 'name' : 'keerthana', 'course' :'flutter'},
    {'id' : 2, 'name' : 'karthika', 'course' : 'python'},
    {'id' : 3 , 'name' : 'karthik', 'course' : 'java'},
  ];
 print(lst);
 print(lst[1]['course']);
 for(var user in lst){
  print(user['name']);
  print(user['course']);

 }

//filter list
 
var result = lst.where((u) => u['id'] == 2).toList();
print(result);
}