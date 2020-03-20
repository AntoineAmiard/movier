import 'package:flutter/widgets.dart';

class CompanyOverview {
  final int id;
  final String logoPath;
  final String name;

  CompanyOverview({
    @required this.id,
    @required this.logoPath,
    @required this.name,
  });

  factory CompanyOverview.fromJson(dynamic json) {
    return CompanyOverview(
      id: json['id'],
      logoPath: json['logo_path'],
      name: json['name'],
    );
  }
}
