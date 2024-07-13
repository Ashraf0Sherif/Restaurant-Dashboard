import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../features/banner/data/models/banner_model.dart';
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

    QuerySnapshot querySnapshot =
        await foodCategories.orderBy('createdAt', descending: true).get();

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

  Future<List<BannerModel>> getBanners() async {
    CollectionReference bannersRef =
        FirebaseFirestore.instance.collection("banners");
    QuerySnapshot querySnapshot = await bannersRef
        .orderBy('createdAt', descending: true) // Sort by createdAt
        .get();
    List<BannerModel> banners = await Future.wait(
      querySnapshot.docs.map(
        (doc) async {
          String id = doc.id;
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return BannerModel(
            title: data['title'],
            description: data['description'],
            startDate: data['startDate'],
            endDate: data['endDate'],
            image: data['image'],
            bannerId: id,
          );
        },
      ).toList(),
    );
    return banners;
  }

  Future<CategoryModel> addCategory(
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
    return CategoryModel(
        id: categoryRef.id, title: title, imageUrl: downloadURL, foodItems: []);
  }

  Future<CategoryModel> updateCategory(
      {required CategoryModel category, Uint8List? imageFile}) async {
    if (imageFile != null) {
      Uint8List image = imageFile;
      String fileName =
          'images/${category.id}/image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      UploadTask uploadTask =
          FirebaseStorage.instance.ref().child(fileName).putData(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('foodCategories')
          .doc(category.id)
          .update({'image': downloadURL});
      category.imageUrl = downloadURL;
    }
    await FirebaseFirestore.instance
        .collection('foodCategories')
        .doc(category.id)
        .update({"category": category.title});
    return category;
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

  Future<FoodItem> addFoodItem(
      {required String categoryId,
      required FoodItem foodItem,
      required List<Uint8List> images}) async {
    DocumentReference foodItemRef = await FirebaseFirestore.instance
        .collection('foodCategories')
        .doc(categoryId)
        .collection("foodItems")
        .add(
      {
        "title": foodItem.title,
        "description": foodItem.description,
        "deliveryTime": foodItem.deliverTime,
        "price": foodItem.price,
        "images": [],
        "createdAt": DateTime.now(),
        "ingredients": foodItem.ingredients
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
    foodItem.id = foodItemRef.id;
    foodItem.images = imagesUrls;
    return foodItem;
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

  Future<FoodItem> updateFoodItem(
      {required String categoryId,
      required FoodItem foodItem,
      required List<Uint8List> images}) async {
    DocumentReference foodItemRef = FirebaseFirestore.instance
        .collection('foodCategories')
        .doc(categoryId)
        .collection('foodItems')
        .doc(foodItem.id);
    List<String> imagesUrls = [];
    for (int i = 0; i < images.length; i++) {
      String fileName =
          'images/$categoryId/foodItemsImages/${foodItem.id}/image_$i.jpg';
      Uint8List image = images[i];
      UploadTask uploadTask =
          FirebaseStorage.instance.ref().child(fileName).putData(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      imagesUrls.add(downloadURL);
    }
    await foodItemRef.update({
      "title": foodItem.title,
      "description": foodItem.description,
      "deliveryTime": foodItem.deliverTime,
      "price": foodItem.price,
      "images": imagesUrls,
      "ingredients": foodItem.ingredients
          .map(
            (e) => {
              "title": e.title,
              "price": e.price,
            },
          )
          .toList(),
    });
    foodItem.images = imagesUrls;
    return foodItem;
  }

  Future<BannerModel> addBanner(
      {required BannerModel banner, required Uint8List imageFile}) async {
    DocumentReference bannerRef =
        await FirebaseFirestore.instance.collection('banners').add({
      "title": banner.title,
      "description": banner.description,
      "createdAt": DateTime.now(),
      "startDate": banner.startDate,
      "endDate": banner.endDate,
      "image": ""
    });
    Uint8List image = imageFile;
    String fileName =
        'banners/${bannerRef.id}/image_${DateTime.now().millisecondsSinceEpoch}.jpg';
    UploadTask uploadTask =
        FirebaseStorage.instance.ref().child(fileName).putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    await bannerRef.update({
      "image": downloadURL,
    });
    banner.bannerId = bannerRef.id;
    return banner;
  }

  Future<void> deleteBanner({required String bannerId}) async {
    await FirebaseFirestore.instance
        .collection('banners')
        .doc(bannerId)
        .delete();
    ListResult result = await FirebaseStorage.instance
        .ref()
        .child('banners/$bannerId')
        .listAll();
    for (Reference imageRef in result.items) {
      await imageRef.delete();
    }
  }

  Future<BannerModel> updateBanner(
      {required BannerModel banner, required Uint8List imageFile}) async {
    await FirebaseFirestore.instance
        .collection('banners')
        .doc(banner.bannerId)
        .update({
      "title": banner.title,
      "description": banner.description,
      "startDate": banner.startDate,
      "endDate": banner.endDate
    });
    Uint8List image = imageFile;
    String fileName =
        'banners/${banner.bannerId}/image_${DateTime.now().millisecondsSinceEpoch}.jpg';
    UploadTask uploadTask =
        FirebaseStorage.instance.ref().child(fileName).putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('banners')
        .doc(banner.bannerId)
        .update(
      {
        "image": downloadURL,
      },
    );
    banner.image = downloadURL;
    return banner;
  }
}
