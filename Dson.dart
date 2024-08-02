import 'dart:io';
import 'dart:async';

class JsonParser {
  static Map<String, dynamic> parse(String json) {
    // Remove any leading or trailing whitespace from the input string.
    json = json.trim();

    // Check if the input string is a valid JSON object.
    if (json.startsWith('{') && json.endsWith('}')) {
      return _parseObject(json.substring(1, json.length - 1));
    } else {
      throw Exception('Invalid JSON: Expected an object');
    }
  }

  static Future<Map<String, dynamic>> parseFile(String filePath) async {
    // Load the JSON file
    String jsonString = await File(filePath).readAsString();

    // Remove comments from the JSON string
    jsonString = _removeComments(jsonString);

    // Parse the JSON string
    return parse(jsonString);
  }

  static String _removeComments(String jsonString) {
    // Simple comment parser to ignore comments in the JSON file
    jsonString = jsonString.replaceAll(RegExp(r'//.*'), '');
    jsonString = jsonString.replaceAll(RegExp(r'/\*.*?\*/'), '');
    return jsonString;
  }

  static Map<String, dynamic> _parseObject(String json) {
    Map<String, dynamic> object = {};

    // Split the input string into key-value pairs.
    List<String> pairs = _splitPairs(json);

    for (String pair in pairs) {
      // Split the pair into a key and a value.
      int colonIndex = pair.indexOf(':');
      if (colonIndex == -1) {
        throw Exception('Invalid JSON: Expected a key-value pair');
      }

      // Extract the key and value.
      String key = _parseString(pair.substring(0, colonIndex).trim());
      dynamic value = _parseValue(pair.substring(colonIndex + 1).trim());

      // Add the key-value pair to the object.
      object[key] = value;
    }

    return object;
  }

  static List<String> _splitPairs(String json) {
    List<String> pairs = [];
    int depth = 0;
    String currentPair = '';

    for (int i = 0; i < json.length; i++) {
      String char = json[i];

      if (char == '{' || char == '[') {
        depth++;
      } else if (char == '}' || char == ']') {
        depth--;
      }

      if (char == ',' && depth == 0) {
        pairs.add(currentPair.trim());
        currentPair = '';
      } else {
        currentPair += char;
      }
    }

    if (currentPair.isNotEmpty) {
      pairs.add(currentPair.trim());
    }

    return pairs;
  }

  static String _parseString(String json) {
    if (json.startsWith('"') && json.endsWith('"')) {
      return json.substring(1, json.length - 1);
    } else {
      throw Exception('Invalid JSON: Expected a string');
    }
  }

  static dynamic _parseValue(String json) {
    if (json.startsWith('"') && json.endsWith('"')) {
      return _parseString(json);
    } else if (json.startsWith('{') && json.endsWith('}')) {
      return _parseObject(json.substring(1, json.length - 1));
    } else if (json.startsWith('[') && json.endsWith(']')) {
      return _parseArray(json.substring(1, json.length - 1));
    } else if (json == 'true') {
      return true;
    } else if (json == 'false') {
      return false;
    } else if (json == 'null') {
      return null;
    } else {
      return double.parse(json);
    }
  }

  static List<dynamic> _parseArray(String json) {
    List<dynamic> array = [];

    // Split the input string into values.
    List<String> values = _splitValues(json);

    for (String value in values) {
      array.add(_parseValue(value.trim()));
    }

    return array;
  }

  static List<String> _splitValues(String json) {
    List<String> values = [];
    int depth = 0;
    String currentValue = '';

    for (int i = 0; i < json.length; i++) {
      String char = json[i];

      if (char == '{' || char == '[') {
        depth++;
      } else if (char == '}' || char == ']') {
        depth--;
      }

      if (char == ',' && depth == 0) {
        values.add(currentValue.trim());
        currentValue = '';
      } else {
        currentValue += char;
      }
    }

    if (currentValue.isNotEmpty) {
      values.add(currentValue.trim());
    }

    return values;
  }
}

