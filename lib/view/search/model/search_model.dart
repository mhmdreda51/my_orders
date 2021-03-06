///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class SearchModelData {
/*
{
  "id": 1,
  "name": "Pizza Burger",
  "description": "pizza",
  "image": "http://via.placeholder.com/200x200?text=No+Image",
  "rate": "0.00",
  "reviews_number": 0,
  "open_at": "08:00:00",
  "close_at": "20:00:00",
  "delivery_fees": 10
}
*/

  int? id;
  String? name;
  String? description;
  String? image;
  String? rate;
  int? reviewsNumber;
  String? openAt;
  String? closeAt;
  int? deliveryFees;

  SearchModelData({
    this.id,
    this.name,
    this.description,
    this.image,
    this.rate,
    this.reviewsNumber,
    this.openAt,
    this.closeAt,
    this.deliveryFees,
  });
  SearchModelData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    name = json["name"]?.toString();
    description = json["description"]?.toString();
    image = json["image"]?.toString();
    rate = json["rate"]?.toString();
    reviewsNumber = json["reviews_number"]?.toInt();
    openAt = json["open_at"]?.toString();
    closeAt = json["close_at"]?.toString();
    deliveryFees = json["delivery_fees"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["description"] = description;
    data["image"] = image;
    data["rate"] = rate;
    data["reviews_number"] = reviewsNumber;
    data["open_at"] = openAt;
    data["close_at"] = closeAt;
    data["delivery_fees"] = deliveryFees;
    return data;
  }
}

class SearchModel {
/*
{
  "status": 1,
  "message": "success",
  "data": [
    {
      "id": 1,
      "name": "Pizza Burger",
      "description": "pizza",
      "image": "http://via.placeholder.com/200x200?text=No+Image",
      "rate": "0.00",
      "reviews_number": 0,
      "open_at": "08:00:00",
      "close_at": "20:00:00",
      "delivery_fees": 10
    }
  ]
}
*/

  int? status;
  String? message;
  List<SearchModelData?>? data;

  SearchModel({
    this.status,
    this.message,
    this.data,
  });
  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json["status"]?.toInt();
    message = json["message"]?.toString();
    if (json["data"] != null) {
      final v = json["data"];
      final arr0 = <SearchModelData>[];
      v.forEach((v) {
        arr0.add(SearchModelData.fromJson(v));
      });
      data = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["message"] = message;
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data["data"] = arr0;
    }
    return data;
  }
}
