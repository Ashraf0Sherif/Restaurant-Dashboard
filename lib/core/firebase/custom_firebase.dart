import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:restaurant_admin_panel/core/firebase/firebase_constants.dart';

import '../../features/banner/data/models/banner_model.dart';
import '../../features/food_menu/data/models/category/category_model.dart';
import '../../features/food_menu/data/models/food_item/food_item.dart';
import '../../features/food_menu/data/models/ingredient/ingredient.dart';
import '../../firebase_options.dart';

class CustomFirebase {
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<List<CategoryModel>> getCategories() async {
    CollectionReference foodCategories = FirebaseFirestore.instance
        .collection(FirebaseConstants.foodCategoriesCollection);

    QuerySnapshot querySnapshot = await foodCategories
        .orderBy(FirebaseConstants.createdAt, descending: true)
        .get();
    List<CategoryModel> categories = await Future.wait(
      querySnapshot.docs.map(
        (doc) async {
          String id = doc.id;
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          List<FoodItem> foodItems = await getFoodItems(categoryId: id);
          return CategoryModel(
            id: id,
            title: data[FirebaseConstants.category],
            imageUrl: data[FirebaseConstants.image],
            foodItems: foodItems,
          );
        },
      ).toList(),
    );
    return categories;
  }

  Future<List<FoodItem>> getFoodItems({required String categoryId}) async {
    CollectionReference foodCategories = FirebaseFirestore.instance
        .collection(FirebaseConstants.foodCategoriesCollection)
        .doc(categoryId)
        .collection(FirebaseConstants.foodItemsCollection);

    QuerySnapshot querySnapshot = await foodCategories
        .orderBy(FirebaseConstants.createdAt, descending: true)
        .get();

    List<FoodItem> foodItems = await Future.wait(
      querySnapshot.docs.map(
        (doc) async {
          String id = doc.id;
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          List<Ingredient> ingredients = [];
          for (var ingredient in doc[FirebaseConstants.ingredients]) {
            ingredients.add(Ingredient(
                price: ingredient[FirebaseConstants.price],
                title: ingredient[FirebaseConstants.title]));
          }
          List<String> images = [];
          for (var image in doc[FirebaseConstants.images]) {
            images.add(image);
          }
          return FoodItem(
            price: data[FirebaseConstants.price],
            deliverTime: data[FirebaseConstants.deliveryTime],
            images: images,
            ingredients: ingredients,
            title: data[FirebaseConstants.title],
            description: data[FirebaseConstants.description],
            id: id,
          );
        },
      ).toList(),
    );
    return foodItems;
  }

  Future<List<BannerModel>> getBanners() async {
    CollectionReference bannersRef = FirebaseFirestore.instance
        .collection(FirebaseConstants.bannersCollection);
    QuerySnapshot querySnapshot = await bannersRef
        .orderBy(FirebaseConstants.createdAt, descending: true)
        .get();
    List<BannerModel> banners = await Future.wait(
      querySnapshot.docs.map(
        (doc) async {
          String id = doc.id;
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return BannerModel(
            title: data[FirebaseConstants.title],
            description: data[FirebaseConstants.description],
            startDate: data[FirebaseConstants.startDate],
            endDate: data[FirebaseConstants.endDate],
            image: data[FirebaseConstants.image],
            bannerId: id,
          );
        },
      ).toList(),
    );
    return banners;
  }

  Future<CategoryModel> addCategory(
      {required String title, required Uint8List imageFile}) async {
    DocumentReference categoryRef = await FirebaseFirestore.instance
        .collection(FirebaseConstants.foodCategoriesCollection)
        .add(
      {
        FirebaseConstants.category: title,
        FirebaseConstants.createdAt: DateTime.now(),
        FirebaseConstants.image: "",
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
      FirebaseConstants.image: downloadURL,
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
          .collection(FirebaseConstants.foodCategoriesCollection)
          .doc(category.id)
          .update({FirebaseConstants.image: downloadURL});
      category.imageUrl = downloadURL;
    }
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.foodCategoriesCollection)
        .doc(category.id)
        .update({FirebaseConstants.category: category.title});
    return category;
  }

  Future<void> deleteCategory({required String categoryId}) async {
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.foodCategoriesCollection)
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
        .collection(FirebaseConstants.foodCategoriesCollection)
        .doc(categoryId)
        .collection(FirebaseConstants.foodItemsCollection)
        .add(
      {
        FirebaseConstants.title: foodItem.title,
        FirebaseConstants.description: foodItem.description,
        FirebaseConstants.deliveryTime: foodItem.deliverTime,
        FirebaseConstants.price: foodItem.price,
        FirebaseConstants.images: [],
        FirebaseConstants.createdAt: DateTime.now(),
        FirebaseConstants.ingredients: foodItem.ingredients
            .map((e) => {
                  FirebaseConstants.title: e.title,
                  FirebaseConstants.price: e.price,
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
      FirebaseConstants.images: imagesUrls,
    });
    foodItem.id = foodItemRef.id;
    foodItem.images = imagesUrls;
    return foodItem;
  }

  Future<void> deleteFoodItem(
      {required String categoryId, required String foodId}) async {
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.foodCategoriesCollection)
        .doc(categoryId)
        .collection(FirebaseConstants.foodItemsCollection)
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
        .collection(FirebaseConstants.foodCategoriesCollection)
        .doc(categoryId)
        .collection(FirebaseConstants.foodItemsCollection)
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
      FirebaseConstants.title: foodItem.title,
      FirebaseConstants.description: foodItem.description,
      FirebaseConstants.deliveryTime: foodItem.deliverTime,
      FirebaseConstants.price: foodItem.price,
      FirebaseConstants.images: imagesUrls,
      FirebaseConstants.ingredients: foodItem.ingredients
          .map(
            (e) => {
              FirebaseConstants.title: e.title,
              FirebaseConstants.price: e.price,
            },
          )
          .toList(),
    });
    foodItem.images = imagesUrls;
    return foodItem;
  }

  Future<BannerModel> addBanner(
      {required BannerModel banner, required Uint8List imageFile}) async {
    DocumentReference bannerRef = await FirebaseFirestore.instance
        .collection(FirebaseConstants.bannersCollection)
        .add({
      FirebaseConstants.title: banner.title,
      FirebaseConstants.description: banner.description,
      FirebaseConstants.createdAt: DateTime.now(),
      FirebaseConstants.startDate: banner.startDate,
      FirebaseConstants.endDate: banner.endDate,
      FirebaseConstants.image: ""
    });
    Uint8List image = imageFile;
    String fileName =
        'banners/${bannerRef.id}/image_${DateTime.now().millisecondsSinceEpoch}.jpg';
    UploadTask uploadTask =
        FirebaseStorage.instance.ref().child(fileName).putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    await bannerRef.update({
      FirebaseConstants.image: downloadURL,
    });
    banner.bannerId = bannerRef.id;
    return banner;
  }

  Future<void> deleteBanner({required String bannerId}) async {
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.bannersCollection)
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
        .collection(FirebaseConstants.bannersCollection)
        .doc(banner.bannerId)
        .update({
      FirebaseConstants.title: banner.title,
      FirebaseConstants.description: banner.description,
      FirebaseConstants.startDate: banner.startDate,
      FirebaseConstants.endDate: banner.endDate
    });
    Uint8List image = imageFile;
    String fileName =
        'banners/${banner.bannerId}/image_${DateTime.now().millisecondsSinceEpoch}.jpg';
    UploadTask uploadTask =
        FirebaseStorage.instance.ref().child(fileName).putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.bannersCollection)
        .doc(banner.bannerId)
        .update(
      {
        FirebaseConstants.image: downloadURL,
      },
    );
    banner.image = downloadURL;
    return banner;
  }
}
