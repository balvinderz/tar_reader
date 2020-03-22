import 'dart:io';
import 'dart:convert';
import 'dart:math';

final  NUL =utf8.encode("\0");
final BLOCKSIZE =512;
final RECORDSIZE = BLOCKSIZE*20;
final GNU_MAGIC = utf8.encode("ustar  \0");
final POSIX_MAGIC = utf8.encode("ustar\x0000");

void readFileAsync() async {
  String path  ="../test.tar.gz";
  File f = new File(path);
  final contents =await  f.readAsBytes();
  var nullPrefix="";
    for(var j=0;j<155;j++)
    nullPrefix+="\x00";  print(contents.length);
  int i =0;
  while(i<contents.length)
  {
    var name ;
    try{

    
    final subList = contents.sublist(i,i+512);
    name = utf8.decode(subList.sublist(0,100));
    final sizeInOctal = utf8.decode(subList.sublist(124,136));
    final sizeInDecimal = octToDecimal(int.parse(sizeInOctal));
   // print(name);
    final type = int.parse(utf8.decode(subList.sublist(156,157)));
    var  prefix =utf8.decode(subList.sublist(345,345+155)).trim();
    var filename;
    
    if(prefix!=nullPrefix)
    {
      prefix = prefix.replaceAll("\x00", "");
      prefix = prefix.replaceAll("\n", "");
    filename = prefix+"/"+name;

    }
    else 
    filename = name;
    print("filename is $filename");
    if(type==5 )
  {
    await new Directory(filename).createSync();
  }
  else 
  {
    File f = new File(filename);
  await f.writeAsBytes(contents.sublist(i+512,i+512+sizeInDecimal));
   }
    // print("file contents are " + utf8.decode(contents.sublist(i+512,i+512+sizeInDecimal)));
    i+=512+sizeInDecimal;
    if(i%512!=0)
    i=i-i%512+512;
    
   
    }
    catch(e)
    {
     // print(name);
      print(e);
      break;
    }
  }
  
  
}
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