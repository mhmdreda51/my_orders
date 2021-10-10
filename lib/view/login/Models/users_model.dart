class Users {
  Users({
    required this.accessToken,
    required this.tokenType,
    required this.data,
  });

  late final String accessToken;
  late final String tokenType;
  late final Data data;

  Users.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['access_token'] = accessToken;
    _data['token_type'] = tokenType;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.image,
    required this.area,
  });

  late final int id;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String phone;
  late final String image;
  late final Area area;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    area = Area.fromJson(json['area']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['image'] = image;
    _data['area'] = area.toJson();
    return _data;
  }
}

class Area {
  Area({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.city,
  });

  late final int id;
  late final String nameAr;
  late final String nameEn;
  late final City city;

  Area.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    city = City.fromJson(json['city']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name_ar'] = nameAr;
    _data['name_en'] = nameEn;
    _data['city'] = city.toJson();
    return _data;
  }
}

class City {
  City({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  late final int id;
  late final String nameAr;
  late final String nameEn;

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name_ar'] = nameAr;
    _data['name_en'] = nameEn;
    return _data;
  }
}
