
import 'dart:convert';

Logindata logindataFromJson(String str) => Logindata.fromJson(json.decode(str));

String logindataToJson(Logindata data) => json.encode(data.toJson());

class Logindata {
    Logindata({
        required this.message,
        required this.token,
        required this.user,
    });

    String message;
    String token;
    User user;

    factory Logindata.fromJson(Map<String, dynamic> json) => Logindata(
        message: json["message"] == null ? null : json["message"],
        token: json["token"] == null ? null : json["token"],
        user: json["user"] == null ? null : (json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "token": token == null ? null : token,
        "user": user == null ? null : user.toJson(),
    };
}

class User {
    User({
        required this.userId,
        required this.roleId,
        required this.password,
        this.token,
        required this.firstName,
        required this.lastName,
        this.gender,
        this.dateOfBirth,
        this.mobileNumber,
        this.email,
        this.lineId,
        required this.createDtm,
        this.updateDtm,
        required this.nameEng,
    });

    String userId;
    String roleId;
    String password;
    dynamic token;
    String firstName;
    String lastName;
    dynamic gender;
    dynamic dateOfBirth;
    dynamic mobileNumber;
    dynamic email;
    dynamic lineId;
    DateTime createDtm;
    dynamic updateDtm;
    String nameEng;

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userID"] == null ? null : json["userID"],
        roleId: json["roleID"] == null ? null : json["roleID"],
        password: json["password"] == null ? null : json["password"],
        token: json["token"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        gender: json["gender"],
        dateOfBirth: json["dateOfBirth"],
        mobileNumber: json["mobileNumber"],
        email: json["email"],
        lineId: json["lineID"],
        createDtm: json["createDtm"] == null ? null : (json["createDtm"]),
        updateDtm: json["updateDtm"],
        nameEng: json["nameEng"] == null ? null : json["nameEng"],
    );

    Map<String, dynamic> toJson() => {
        "userID": userId == null ? null : userId,
        "roleID": roleId == null ? null : roleId,
        "password": password == null ? null : password,
        "token": token,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "gender": gender,
        "dateOfBirth": dateOfBirth,
        "mobileNumber": mobileNumber,
        "email": email,
        "lineID": lineId,
        "createDtm": createDtm == null ? null : createDtm.toIso8601String(),
        "updateDtm": updateDtm,
        "nameEng": nameEng == null ? null : nameEng,
    };
}
