import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:marvel/persons.dart';

Future<Persons> findPerson(String name,
    {required String publicKey, required String privateKey}) async {
  String ts = DateTime.now().toString();
  String hash = md5.convert(utf8.encode("$ts$privateKey$publicKey")).toString();
  String nameStartsWith = name.isNotEmpty ? "&nameStartsWith=$name" : "";
  final response = await http.get(
    Uri.parse(
        'https://gateway.marvel.com/v1/public/characters?limit=100$nameStartsWith&ts=$ts&apikey=$publicKey&hash=$hash'),
  );

  return Persons.fromJson(jsonDecode(response.body));
}
