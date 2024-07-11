import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../features/food_menu/data/models/category/category_model.dart';
import '../../features/food_menu/data/models/food_item/food_item.dart';
import '../../features/food_menu/data/models/ingredient/ingredient.dart';

class CustomFirebase {
  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  Future<List<CategoryModel>> getCategories() async {
    CollectionReference foodCategories =
        FirebaseFirestore.instance.collection("foodCategories");

    QuerySnapshot querySnapshot = await foodCategories.get();
    List<CategoryModel> categories = await Future.wait(
      querySnapshot.docs.map(
        (doc) async {
          String id = doc.id;
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          List<FoodItem> foodItems = await getFoodItems(categoryId: id);
          return CategoryModel(
            id: id,
            title: data['category'],
            imageUrl: data['image'],
            foodItems: foodItems,
          );
        },
      ).toList(),
    );
    return categories;
  }

  Future<List<FoodItem>> getFoodItems({required String categoryId}) async {
    CollectionReference foodCategories = FirebaseFirestore.instance
        .collection("foodCategories")
        .doc(categoryId)
        .collection("foodItems");

    QuerySnapshot querySnapshot = await foodCategories.get();
    List<FoodItem> foodItems = await Future.wait(
      querySnapshot.docs.map(
        (doc) async {
          String id = doc.id;
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          List<Ingredient> ingredients = [];
          for (var ingredient in doc['ingredients']) {
            ingredients.add(Ingredient(
                price: ingredient['price'], title: ingredient['title']));
          }
          List<String> images = [];
          for (var image in doc['images']) {
            images.add(image);
          }
          return FoodItem(
            price: data['price'],
            deliverTime: data['deliveryTime'],
            images: images,
            ingredients: ingredients,
            title: data['title'],
            description: data['description'],
            id: id,
          );
        },
      ).toList(),
    );
    //print(foodItems);
    return foodItems;
  }

  Future<void> addCategory(
      {required String title, required Uint8List imageFile}) async {
    Uint8List image = imageFile;
    String fileName =
        'images/${DateTime.now().millisecondsSinceEpoch}.jpg';
    UploadTask uploadTask =
        FirebaseStorage.instance.ref().child(fileName).putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    await FirebaseFirestore.instance.collection("foodCategories").add(
      {
        "category": title,
        "image": downloadURL,
      },
    );
  }

  Future<void> addFoodItem(
      {required String categoryId,
      required String title,
      required String description,
      required String deliveryTime,
      required String price,
      required List<Uint8List> images,
      required List<Ingredient> ingredients}) async {
    List<String> imagesUrls = [];
    for (int i = 0; i < images.length; i++) {
      Uint8List image = images[i];
      String fileName =
          'images/$categoryId/${DateTime.now().millisecondsSinceEpoch}_$i.jpg';
      UploadTask uploadTask =
          FirebaseStorage.instance.ref().child(fileName).putData(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      imagesUrls.add(downloadURL);
    }
    await FirebaseFirestore.instance
        .collection('foodCategories')
        .doc(categoryId)
        .collection("foodItems")
        .add(
      {
        "title": title,
        "description": description,
        "deliveryTime": deliveryTime,
        "price": price,
        "images": imagesUrls,
        "ingredients": ingredients
            .map((e) => {
                  "title": e.title,
                  "price": e.price,
                })
            .toList(),
      },
    );
  }

  Future<void> deleteFoodItem(
      {required String categoryId, required String foodId}) async {
    await FirebaseFirestore.instance
        .collection('foodCategories')
        .doc(categoryId)
        .collection("foodItems")
        .doc(foodId)
        .delete();
  }
}
