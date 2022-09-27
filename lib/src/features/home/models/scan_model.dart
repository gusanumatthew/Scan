// To parse this JSON data, do
//
//     final scanModel = scanModelFromJson(jsonString);

import 'dart:convert';

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  ScanModel({
    this.language,
    this.id,
    this.firstName,
    this.lastName,
    this.middleName,
    this.emails,
    this.phones,
    this.jobs,
    this.websites,
    this.notes,
    this.addresses,
  });

  String? language;
  String? id;
  String? firstName;
  String? lastName;
  String? middleName;
  List<Email>? emails;
  List<Phone>? phones;
  List<Job>? jobs;
  List<Website>? websites;
  String? notes;
  List<Address>? addresses;

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        language: json["language"] ?? "",
        id: json["id"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        middleName: json["middleName"] ?? "",
        emails: List<Email>.from(json["emails"].map((x) => Email.fromJson(x))),
        phones: List<Phone>.from(json["phones"].map((x) => Phone.fromJson(x))),
        jobs: List<Job>.from(json["jobs"].map((x) => Job.fromJson(x))),
        websites: List<Website>.from(
            json["websites"].map((x) => Website.fromJson(x))),
        notes: json["notes"],
        addresses: List<Address>.from(
            json["addresses"].map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "language": language,
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "middleName": middleName,
        "emails": List<dynamic>.from(emails!.map((x) => x.toJson())),
        "phones": List<dynamic>.from(phones!.map((x) => x.toJson())),
        "jobs": List<dynamic>.from(jobs!.map((x) => x.toJson())),
        "websites": List<dynamic>.from(websites!.map((x) => x.toJson())),
        "notes": notes,
        "addresses": List<dynamic>.from(addresses!.map((x) => x.toJson())),
      };
}

class Address {
  Address({
    this.fullAddress,
    this.parsedAddress,
  });

  String? fullAddress;
  ParsedAddress? parsedAddress;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        fullAddress: json["fullAddress"] ?? "",
        parsedAddress: ParsedAddress.fromJson(json["parsedAddress"]),
      );

  Map<String, dynamic> toJson() => {
        "fullAddress": fullAddress,
        "parsedAddress": parsedAddress!.toJson(),
      };
}

class ParsedAddress {
  ParsedAddress({
    this.street,
    this.postalCode,
    this.city,
    this.state,
    this.country,
    this.latitude,
    this.longitude,
  });

  String? street;
  String? postalCode;
  String? city;
  dynamic state;
  String? country;
  String? latitude;
  String? longitude;

  factory ParsedAddress.fromJson(Map<String, dynamic> json) => ParsedAddress(
        street: json["street"],
        postalCode: json["postalCode"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "postalCode": postalCode,
        "city": city,
        "state": state,
        "country": country,
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Email {
  Email({
    this.address,
  });

  String? address;

  factory Email.fromJson(Map<String, dynamic> json) => Email(
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
      };
}

class Job {
  Job({
    this.company,
    this.title,
  });

  String? company;
  String? title;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        company: json["company"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "company": company,
        "title": title,
      };
}

class Phone {
  Phone({
    this.number,
    this.type,
  });

  String? number;
  String? type;

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
        number: json["number"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "type": type,
      };
}

class Website {
  Website({
    this.url,
  });

  String? url;

  factory Website.fromJson(Map<String, dynamic> json) => Website(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
