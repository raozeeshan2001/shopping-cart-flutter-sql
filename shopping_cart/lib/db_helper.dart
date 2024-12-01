import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:shopping_cart/cart_model.dart';

class DbHelper {
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initdatabase();
  }

  initdatabase() async {
    io.Directory documentDirectory =
        await getApplicationDocumentsDirectory(); //get folder where app stores data
    String path = join(documentDirectory.path,
        'cart.db'); //creates valid file path for database
    var db = await openDatabase(path,
        version: 1, onCreate: _onCreate); //opens database at given path
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE cart (id INTEGER PRIMARY KEY , productId VARCHAR UNIQUE,productName TEXT,initialPrice INTEGER, productPrice INTEGER , quantity INTEGER, unitTag TEXT , image TEXT )');
  }

  Future<CartModel> insert(CartModel cartmodel) async {
    var dbClient = await db;
    await dbClient!.insert('cart', cartmodel.toMap());
    return cartmodel;
  }
}
