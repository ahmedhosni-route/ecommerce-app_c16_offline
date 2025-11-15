import 'package:flutter/material.dart';

class ProductEntity {
  ProductEntity({
    required this.sold,
    required this.images,
    required this.ratingsQuantity,
    required this.title,
    required this.slug,
    required this.description,
    required this.quantity,
    required this.price,
    required this.imageCover,
    required this.ratingsAverage,
    required this.id,
  }){
    qut = ValueNotifier(1);
  }

  num sold;
  List<String> images;
  num ratingsQuantity;
  String id;
  String title;
  String slug;
  String description;
  num quantity;
  num price;
  String imageCover;
  num ratingsAverage;
  late ValueNotifier<num> qut;
}
