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

    QuerySnapshot querySnapshot =
        await foodCategories.orderBy('createdAt', descending: true).get();
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

    QuerySnapshot querySnapshot = await foodCategories
        .orderBy('createdAt', descending: true) // Sort by createdAt
        .get();

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
    return foodItems;
  }

  Future<void> addCategory(
      {required String title, required Uint8List imageFile}) async {
    DocumentReference categoryRef =
        await FirebaseFirestore.instance.collection("foodCategories").add(
      {
        "category": title,
        "createdAt": DateTime.now(),
        "image": "",
      },
    );
    Uint8List image = imageFile;
    String fileName =
        'images/${categoryRef.id}/image_${DateTime.now().millisecondsSinceEpoch}.jpg';
    UploadTask uploadTask =
        FirebaseStorage.instance.ref().child(fileName).putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    await categoryRef.update({
      "image": downloadURL,
    });
  }

  Future<void> updateCategory(
      {required String categoryId, String? title, Uint8List? imageFile}) async {
    if (title != null) {
      await FirebaseFirestore.instance
          .collection('foodCategories')
          .doc(categoryId)
          .update({'category': title});
    }
    if (imageFile != null) {
      Uint8List image = imageFile;
      String fileName =
          'images/$categoryId/image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      UploadTask uploadTask =
          FirebaseStorage.instance.ref().child(fileName).putData(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('foodCategories')
          .doc(categoryId)
          .update({'image': downloadURL});
    }
  }

  Future<void> deleteCategory({required String categoryId}) async {
    await FirebaseFirestore.instance
        .collection('foodCategories')
        .doc(categoryId)
        .delete();
    ListResult result = await FirebaseStorage.instance
        .ref()
        .child('images/$categoryId')
        .listAll();
    for (Reference imageRef in result.items) {
      await imageRef.delete();
    }
  }

  Future<void> addFoodItem(
      {required String categoryId,
      required String title,
      required String description,
      required String deliveryTime,
      required String price,
      required List<Uint8List> images,
      required List<Ingredient> ingredients}) async {
    DocumentReference foodItemRef = await FirebaseFirestore.instance
        .collection('foodCategories')
        .doc(categoryId)
        .collection("foodItems")
        .add(
      {
        "title": title,
        "description": description,
        "deliveryTime": deliveryTime,
        "price": price,
        "images": [],
        "createdAt": DateTime.now(),
        "ingredients": ingredients
            .map((e) => {
                  "title": e.title,
                  "price": e.price,
                })
            .toList(),
      },
    );
    List<String> imagesUrls = [];
    for (int i = 0; i < images.length; i++) {
      Uint8List image = images[i];
      String fileName =
          'images/$categoryId/foodItemsImages/${foodItemRef.id}/image_$i.jpg';
      UploadTask uploadTask =
          FirebaseStorage.instance.ref().child(fileName).putData(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      imagesUrls.add(downloadURL);
    }

    await foodItemRef.update({
      "images": imagesUrls,
    });
  }

  Future<void> deleteFoodItem(
      {required String categoryId, required String foodId}) async {
    await FirebaseFirestore.instance
        .collection('foodCategories')
        .doc(categoryId)
        .collection("foodItems")
        .doc(foodId)
        .delete();

    ListResult result = await FirebaseStorage.instance
        .ref()
        .child('images/$categoryId/foodItemsImages/$foodId')
        .listAll();

    for (Reference imageRef in result.items) {
      await imageRef.delete();
    }
  }
}
