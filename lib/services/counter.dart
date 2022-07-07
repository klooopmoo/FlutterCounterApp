import 'dart:convert';

import 'package:http/http.dart' as http;

class Counter{
  int count;//counters to keep track of state
  final String baseUrl = "localhost:8081";
  Counter({this.count});
  Future<int> getCount()async {
    var url = Uri.parse("$baseUrl/state");
    http.Response response = await http.get(url);
    Map data = jsonDecode(response.body);
    count = data['counter'];
    return count;

  }

  Future <void> putCount(int c) async{
    print("Putting count $c");
    count = c;
    Map c1 = {"counter": count};
    String jsonCount = jsonEncode(c1);
    var url = Uri.parse("$baseUrl/state");
    http.Response response = await http.put(url, body: jsonCount, headers: { "Content-Type" : "application/json"});
    print("put count returned ${response.statusCode} with ${response.body}");
  }
}