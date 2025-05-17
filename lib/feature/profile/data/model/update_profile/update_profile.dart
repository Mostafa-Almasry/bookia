import 'package:dio/dio.dart';

class UpdateProfile {
  String? name;
  String? email;
  String? phoneNumber;
  String? address;
  // File? image;

  UpdateProfile({this.name, this.phoneNumber, this.address, this.email});

  UpdateProfile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    // image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['address'] = address;

    return data;
  }

  FormData toFormData() {
    return FormData.fromMap(toJson());
  }
}
