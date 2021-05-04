import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String title;
  String shortInfo;
  Timestamp publishedDate;
  String thumbnailUrl;
  String longDescription;
  String status;
  var price;
  String uploadBy;
  int UploaderPhoneNumber;
  String location;

  ItemModel(
      {this.title,
        this.shortInfo,
        this.publishedDate,
        this.thumbnailUrl,
        this.longDescription,
        this.status,
        this.price,
        this.uploadBy,
        this.UploaderPhoneNumber,
        this.location,
        });

  ItemModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    shortInfo = json['shortInfo'];
    publishedDate = json['publishedDate'];
    thumbnailUrl = json['thumbnailUrl'];
    longDescription = json['longDescription'];
    status = json['status'];
    price = json['price'];
    uploadBy = json['uploadBy'];
    UploaderPhoneNumber = json['UploaderPhoneNumber'];
    location = json['location'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['shortInfo'] = this.shortInfo;
    data['price'] = this.price;
    if (this.publishedDate != null) {
      data['publishedDate'] = this.publishedDate;
    }
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['longDescription'] = this.longDescription;
    data['status'] = this.status;
    data['uploadBy'] = this.uploadBy;
    data['UploaderPhoneNumber'] = this.UploaderPhoneNumber;
    data['location'] = this.location;
    return data;
  }
}

class PublishedDate {
  String date;

  PublishedDate({this.date});

  PublishedDate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }
}
