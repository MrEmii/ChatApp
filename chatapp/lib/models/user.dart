import 'dart:convert';

class User {
    User({
        required this.nombre,
        required this.email,
        required this.id,
        required this.online
    });

    String nombre;
    String email;
    String id;
    bool online;

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        nombre: json["nombre"],
        email: json["email"],
        id: json["id"],
        online: json["online"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "email": email,
        "id": id,
        "online": online,
    };
}
