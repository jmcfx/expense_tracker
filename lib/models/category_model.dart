import 'dart:ui';

enum Categories {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other
}

//Category Model...
class CategoryModel {

  final String title;
  final Color color;

   const CategoryModel( this.title,  this.color);

}
