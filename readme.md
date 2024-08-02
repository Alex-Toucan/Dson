# DSON
DSON (also known as PynxSON) is my extension of the JSON library for Dart.
Did you ever want a better version of JSON? This library is for you then!

# How To Install?
1. Download the file (Dson.dart) from this repo.
2. Place the file into your directory.
3. Import the file: `import 'Dson.dart';`
4. Call the functions: __examples below__

# What Are The Features?
1. Comments (Ever needed to describe your objects? Well now you can!)
2. Better read
3. Better Speed and compatibility

# Examples
**More coming soon**
```
import 'Dson.dart';

void main() async {
  String filePath = 'file.json';
  Map<String, dynamic> json = await JsonParser.parseFile(filePath);
  print(json);
}

```

## Functions
'parsefile(FILENAME);` - Parses a File\

## Comments
`// This is a comment`

# Latest patch
Check out `patchnotes.txt` from now on !
