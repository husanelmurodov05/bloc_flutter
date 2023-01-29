import "package:flutter/material.dart";
import 'package:equatable/equatable.dart';

class Pizza extends Equatable {
  final String id;
  final String name;
  final Image image;
  const Pizza({required this.id, required this.name, required this.image});
  @override
  List<Object?> get props => [id, name, image];
  static List<Pizza> pizzas = [
    Pizza(
      id: "0",
       name: "Pizza",

     image: Image.asset("assets/images/pizza.png",
     width: 500,
      height: 500,
      fit: BoxFit.cover,
     )),
     Pizza(
      id:'1',
       name: 'Pizza Pepperoni', 
image: Image.asset(
  "assets/images/pizza1.png",
  width: 500,
  height: 500,
   fit: BoxFit.cover,
),

)
  ];
}
