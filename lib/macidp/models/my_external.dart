class MyExternal {
  List<LicenseOrders> licenseOrders = [];

  MyExternal();

  MyExternal.fromJson(Map<String, dynamic> json) {
    if (json['licenseOrders'] != null) {
      licenseOrders = <LicenseOrders>[];
      json['licenseOrders'].forEach((v) {
        licenseOrders!.add(new LicenseOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.licenseOrders != null) {
      data['licenseOrders'] =
          this.licenseOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LicenseOrders {
  String? externalUserId;
  int? id;
  String? status;
  int? accountId;
  String? fullName;
  String? birthDate;
  int? bloodType;
  String? nationalityCountry;
  String? sourceOfLocalLicenseCountry;
  int? gander;
  String? passportTextId;
  List<int>? licenseType;
  int? licenseDuration;
  String? personalPhotoUrl;
  String? localDrivingLicense;
  String? passportImage;

  LicenseOrders(
      {this.externalUserId,
      this.id,
      this.accountId,
      this.fullName,
      this.birthDate,
      this.bloodType,
      this.nationalityCountry,
      this.sourceOfLocalLicenseCountry,
      this.gander,
      this.passportTextId,
      this.licenseType,
      this.status,
      this.licenseDuration,
      this.personalPhotoUrl,
      this.localDrivingLicense,
      this.passportImage});

  LicenseOrders.fromJson(Map<String, dynamic> json) {
    externalUserId = json['externalUserId'];
    id = json['id'];
    status = json['status'];
    accountId = json['accountId'];
    fullName = json['fullName'];
    birthDate = json['birthDate'];
    bloodType = json['bloodType'];
    nationalityCountry = json['nationalityCountry'];
    sourceOfLocalLicenseCountry = json['sourceOfLocalLicenseCountry'];
    gander = json['gander'];
    passportTextId = json['passportTextId'];
    licenseType = json['licenseType'].cast<int>();
    licenseDuration = json['licenseDuration'];
    personalPhotoUrl = json['personalPhotoUrl'];
    localDrivingLicense = json['localDrivingLicense'];
    passportImage = json['passportImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['externalUserId'] = this.externalUserId;
    data['id'] = this.id;
    data['status'] = this.status;
    data['accountId'] = this.accountId;
    data['fullName'] = this.fullName;
    data['birthDate'] = this.birthDate;
    data['bloodType'] = this.bloodType;
    data['nationalityCountry'] = this.nationalityCountry;
    data['sourceOfLocalLicenseCountry'] = this.sourceOfLocalLicenseCountry;
    data['gander'] = this.gander;
    data['passportTextId'] = this.passportTextId;
    data['licenseType'] = this.licenseType;
    data['licenseDuration'] = this.licenseDuration;
    data['personalPhotoUrl'] = this.personalPhotoUrl;
    data['localDrivingLicense'] = this.localDrivingLicense;
    data['passportImage'] = this.passportImage;
    return data;
  }
}
