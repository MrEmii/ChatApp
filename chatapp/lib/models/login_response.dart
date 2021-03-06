import 'package:chatapp/models/user.dart';
import 'dart:convert';

class LoginResponse {
    LoginResponse({
        required this.ok,
        required this.msg,
        required this.user,
        required this.token,
    });

    bool ok;
    String msg;
    User user;
    String token;

    factory LoginResponse.fromRawJson(String str) => LoginResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        msg: json["msg"],
        user: User.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "user": user.toJson(),
        "token": token,
    };
}
