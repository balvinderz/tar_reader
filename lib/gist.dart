
import 'dart:io';
import 'dart:convert';
import 'dart:math';
int octToDecimal(int number)
  {
    int decimal =0;
      
      int power = 0;
      while(number!=0)
      {
        int lastDigit = number%10;
        number=number~/10;
        //print(t);
        decimal += lastDigit*pow(8, power);
        power++; 
      }
      return decimal;
  }


void sample() async {
  String path  ="../test.tar.gz"; // replcace with path of your tar.gz file 
  File f = new File(path);
  final contents =await  f.readAsBytes();
  // Name of file is at offset 0 and it takes 100 bytes
  
  int offsetOfFileName = 0;
  int sizeOfFileName =   100;
  // Size of file is at offset 124 and it takes 12 bytes 
  int offsetOfFileSize = 124;
  int sizeOfFileSize =  12;
  String fileName= utf8.decode(contents.sublist(offsetOfFileName,offsetOfFileName+sizeOfFileName));
  print("Name is $fileName");
  final sizeInOctal = int.parse(utf8.decode(contents.sublist(offsetOfFileSize,offsetOfFileSize+sizeOfFileSize)));  // in octals
  final sizeInDecimals = octToDecimal(sizeInOctal);
  print("Size in bytes is $sizeInDecimals");
}

  void main(){
    sample();
  }
