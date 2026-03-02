class Printer{
  void printData(){
  }
}  

class LasePrinter implements Printer{
  @override
  void printData(){
    print("Printing using laser printer");
  }
}

void main(){
  LasePrinter lp = LasePrinter();
  lp.printData();
}