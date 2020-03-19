import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

final  NUL =utf8.encode("\0");
final BLOCKSIZE =512;
final RECORDSIZE = BLOCKSIZE*20;
final GNU_MAGIC = utf8.encode("ustar  \0");
final POSIX_MAGIC = utf8.encode("ustar\x0000");

void readFileAsync() async {
  String path  ="../test.tar.gz";
  File f = new File(path);
  final contents =await  f.readAsBytes();
  print(contents.length);
  List<int>  header  =[];
  int start=0;
  int offset =100;
  int end =start+offset;
  for(var i =start;i<end;i++)
      header.add(contents[i]);

  
  print(utf8.decode(header));
}