import 'dart:convert';



class Getquote {
  final int  result;

  Getquote( {
    required this.result,

  });

  Map<String, dynamic> toMap() {
    return {
      'result':result,

    };
  }

  factory Getquote.fromMap(Map<String, dynamic> map) {
    return Getquote(


        result: map["result"] ?? ''
    );
  }

  String toJson() => json.encode(toMap());

  factory Getquote.fromJson(String source) => Getquote.fromMap(json.decode(source));

  Getquote copyWith({

    int? result,
  }) {
    return Getquote(

        result: result ?? this.result

    );
  }

}