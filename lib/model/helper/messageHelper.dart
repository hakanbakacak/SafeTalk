import 'package:encrypt/encrypt.dart';

class MessageHelper{

static String encryptMessage(String plainText, String rawKey){

  final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
  final key = Key.fromUtf8(rawKey);
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));

  final encrypted = encrypter.encrypt(plainText, iv: iv);

  
  print(encrypted.base64); // R4PxiU3h8YoIRqVowBXm36ZcCeNeZ4s1OvVBTfFlZRdmohQqOpPQqD1YecJeZMAop/hZ4OxqgC1WtwvX/hP9mw==
  return encrypted.base64;

}

static String decryptMessage(String cipherText, String rawKey){

  final key = Key.fromUtf8(rawKey);
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));
  var encrypted = new Encrypted.fromBase16(cipherText);
  //var encrypted = new Encrypted.fromUtf8(cipherText);

  final decrypted = encrypter.decrypt(encrypted, iv: iv);
  print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
  /*
  final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
  final key = Key.fromUtf8('my 32 length key................');
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  final encrypted = encrypter.encrypt(plainText, iv: iv);
  final decrypted = encrypter.decrypt(encrypted, iv: iv);

  */

  return decrypted;
}

}

