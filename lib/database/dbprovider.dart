import 'dart:io';

import 'package:id_360/models/cardfetchmodel.dart';
import 'package:id_360/models/citymodel.dart';
import 'package:id_360/models/countrymodel.dart';
import 'package:id_360/models/notificationmodel.dart';
import 'package:id_360/models/statemodel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';

class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static Database _database;
  static final String profile_table="profile_table";
  static final String profile_data="profile_data";
  static final String profile_imagepath="profile_imagepath";
  static final String profile_id="profile_id";
  static final String cardinfo_table="cardinfo_table";
  static final String cardinfo_data="cardinfo_data";
  static final String cardinfoLogoPath="cardinfoLogoPath";
  static final String cardinfoUSerImagePath="cardinfoUSerImagePath";
  static final String cardinfoQrcodePath="cardinfoQrcodePath";
  static final String cardinfo_id="card_id";
  //static final String card_detail_table="card_table";
  //static final String card_detail="card_detail_table";
  static final String notification_table="notificationtable";
  static final String notification_id="id";
  static final String notification_userid="user_id";
  static final String notification_statustype="status_type";
  static final String notification_title="title";
  static final String notification_message="message";
  static final String notification_createdat="created_at";
  static final String card_table="card_table";
  static final String card_id="id";
  static final String card_userid="user_id";
  static final String card_path="path";
  static final String card_icardid="icard_id";
  static final String card_officeid="office_id";

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await copyDb();
    return _database;
    //openDatabase(path)
  }

  copyDb() async {
    Database database;
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "csc.db");
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "csc.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
      database = await openDatabase(path, readOnly: false,
      onCreate: (db,version) async {
        //{"id":50,"user_id":504,"status_type":"login_success","title":"request status","message":"Successfully login ","created_at":"2022-03-14 08:57:18"}
        await db.execute(
          "CREATE TABLE ${SQLiteDbProvider.notification_table}(${SQLiteDbProvider.notification_id} INTEGER PRIMARY KEY, ${SQLiteDbProvider.notification_userid} TEXT"
              ", ${SQLiteDbProvider.notification_statustype} TEXT, ${SQLiteDbProvider.notification_title} TEXT, ${SQLiteDbProvider.notification_message} TEXT"
              ", ${SQLiteDbProvider.notification_createdat} TEXT)",
        );

        await db.execute(
          "CREATE TABLE ${SQLiteDbProvider.profile_table}(${SQLiteDbProvider.profile_id} INTEGER PRIMARY KEY, ${SQLiteDbProvider.profile_data} TEXT, ${SQLiteDbProvider.profile_imagepath} TEXT)",
        );

        await db.execute(
          "CREATE TABLE ${SQLiteDbProvider.card_table}(${SQLiteDbProvider.card_id} INTEGER PRIMARY KEY, ${SQLiteDbProvider.card_userid} TEXT, ${SQLiteDbProvider.card_path} TEXT,"
              "${SQLiteDbProvider.card_icardid} TEXT, ${SQLiteDbProvider.card_officeid} TEXT)",
        );


        await db.execute(
          '''CREATE TABLE ${SQLiteDbProvider.cardinfo_table}
          (${SQLiteDbProvider.cardinfo_id} INTEGER PRIMARY KEY,
           ${SQLiteDbProvider.cardinfo_data} TEXT NOT NULL,
           ${SQLiteDbProvider.cardinfoLogoPath} TEXT,
           ${SQLiteDbProvider.cardinfoUSerImagePath} TEXT,
           ${SQLiteDbProvider.cardinfoQrcodePath} TEXT
           )''',
        );
        /*await db.execute(
          "CREATE TABLE ${SQLiteDbProvider.profile_table}(${SQLiteDbProvider.profile_id} INTEGER PRIMARY KEY, ${SQLiteDbProvider.profile_data} TEXT)",
        );
        await db.execute(
          "CREATE TABLE ${SQLiteDbProvider.profile_table}(${SQLiteDbProvider.profile_id} INTEGER PRIMARY KEY, ${SQLiteDbProvider.profile_data} TEXT)",
        );*/

      },version: 2);
    } else {
      //print("Opening existing database");
      database = await openDatabase(path, readOnly: false,
      onCreate: (db,version) async{
        await db.execute(
          "CREATE TABLE ${SQLiteDbProvider.notification_table}(${SQLiteDbProvider.notification_id} INTEGER PRIMARY KEY, ${SQLiteDbProvider.notification_userid} TEXT"
              ", ${SQLiteDbProvider.notification_statustype} TEXT, ${SQLiteDbProvider.notification_title} TEXT, ${SQLiteDbProvider.notification_message} TEXT"
              ", ${SQLiteDbProvider.notification_createdat} TEXT)",
        );

        await db.execute(
            "CREATE TABLE ${SQLiteDbProvider.profile_table}(${SQLiteDbProvider.profile_id} INTEGER PRIMARY KEY, ${SQLiteDbProvider.profile_data} TEXT, ${SQLiteDbProvider.profile_imagepath} TEXT)",
        );

        await db.execute(
          "CREATE TABLE ${SQLiteDbProvider.card_table}(${SQLiteDbProvider.card_id} INTEGER PRIMARY KEY, ${SQLiteDbProvider.card_userid} TEXT, ${SQLiteDbProvider.card_path} TEXT,"
              "${SQLiteDbProvider.card_icardid} TEXT, ${SQLiteDbProvider.card_officeid} TEXT)",
        );


        await db.execute(
          '''CREATE TABLE ${SQLiteDbProvider.cardinfo_table}
          (${SQLiteDbProvider.cardinfo_id} INTEGER PRIMARY KEY,
           ${SQLiteDbProvider.cardinfo_data} TEXT NOT NULL,
           ${SQLiteDbProvider.cardinfoLogoPath} TEXT,
           ${SQLiteDbProvider.cardinfoUSerImagePath} TEXT,
           ${SQLiteDbProvider.cardinfoQrcodePath} TEXT
           )''',
        );
        /*await db.execute(
          "CREATE TABLE ${SQLiteDbProvider.profile_table}(${SQLiteDbProvider.profile_id} INTEGER PRIMARY KEY, ${SQLiteDbProvider.profile_data} TEXT)",
        );
        await db.execute(
          "CREATE TABLE ${SQLiteDbProvider.profile_table}(${SQLiteDbProvider.profile_id} INTEGER PRIMARY KEY, ${SQLiteDbProvider.profile_data} TEXT)",
        );*/

      },version: 2);
    }
    return database;
  }

  getCountry(int id) async {
    final db = await database;
    int i = await db.getVersion();
    var res = await db.query("country", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Country.fromMap(res.first) : Null;
  }

  getCountryList() async {
    final db = await database;
    List<Country> countrylist = [];
    //int i=await db.getVersion();
    var res = await db.rawQuery("SELECT * FROM country");
    if(res!=null && res.length>0)
      {
        res.forEach((element) {
          countrylist.add(Country.fromMap(element));
        });
      }
    return countrylist;
  }

  getCityListInstiSearch(int country_id) async {
    final db = await database;
    var res = await db.query("state", where: "country_id = ?", whereArgs: [country_id]);
    List<City> citylist = [];
    String state_list='';
    if(res!=null && res.length>0)
    {
      res.asMap().forEach((index,element) {
        //('1','2','3','4')
        //countrylist.add(Country.fromMap(element));
        if(index==0)
          state_list="(";

        if(index!=res.length-1)
          {
            state_list+="${State.fromMap(element).id},";
          }
        else{
          state_list+="${State.fromMap(element).id})";
        }
      });
    }
    //int i=await db.getVersion();
    if(state_list.isNotEmpty)
      {
        var cityres = await db.rawQuery("SELECT * FROM city WHERE state_id IN $state_list");
        if(cityres!=null && cityres.length>0)
        {
          cityres.forEach((element) {
            citylist.add(City.fromMap(element));
          });
        }
      }
    return citylist;
  }

  getCityListonState(int state_id) async {
    final db = await database;
    List<City> citylist = [];
    //int i=await db.getVersion();
    if(state_id!=null)
    {
      var cityres = await db.rawQuery("SELECT * FROM city WHERE state_id = '$state_id'");
      if(cityres!=null && cityres.length>0)
      {
        cityres.forEach((element) {
          citylist.add(City.fromMap(element));
        });
      }
    }
    return citylist;
  }

  getStateListonCountry(int country_id) async {
    final db = await database;
    List<State> statelist = [];
    //int i=await db.getVersion();
    if(country_id!=null)
    {
      var stateres = await db.rawQuery("SELECT * FROM state WHERE country_id = '$country_id'");
      if(stateres!=null && stateres.length>0)
      {
        stateres.forEach((element) {
          statelist.add(State.fromMap(element));
        });
      }
    }
    return statelist;
  }

  getStateFromId(int state_id) async {
    final db = await database;
    //List<State> statelist = [];
    //int i=await db.getVersion();
    if(state_id!=null)
    {
      var stateres = await db.rawQuery("SELECT * FROM state WHERE id = '$state_id'");
      if(stateres!=null && stateres.length>0)
      {
        return State.fromMap(stateres.first).name;
      }
    }
    return '-';
  }

  getCountryFromId(int country_id) async {
    final db = await database;
    //List<State> statelist = [];
    //int i=await db.getVersion();
    if(country_id!=null)
    {
      var countryres = await db.rawQuery("SELECT * FROM country WHERE id = '$country_id'");
      if(countryres!=null && countryres.length>0)
      {
        return Country.fromMap(countryres.first).name;
      }
    }
    return '-';
  }

  getCityFromId(int city_id) async {
    final db = await database;
    //List<State> statelist = [];
    //int i=await db.getVersion();
    if(city_id!=null)
    {
      var cityres = await db.rawQuery("SELECT * FROM city WHERE id = '$city_id'");
      if(cityres!=null && cityres.length>0)
      {
        return City.fromMap(cityres.first).name;
      }
    }
    return '-';
  }
  
  storeNotificationData(List<NotificationData> notificationlist) async
  {
    final db = await database;
    if(notificationlist!=null && notificationlist.length>0)
      {
        String query="INSERT OR REPLACE INTO ${SQLiteDbProvider.notification_table}(${SQLiteDbProvider.notification_id},${SQLiteDbProvider.notification_userid}"
            ",${SQLiteDbProvider.notification_statustype},${SQLiteDbProvider.notification_title},${SQLiteDbProvider.notification_message},"
            "${SQLiteDbProvider.notification_createdat}) VALUES";
        for(int i=0;i<notificationlist.length;i++)
        {
          NotificationData notificationData=notificationlist[i];
          if(i==notificationlist.length-1)
          {
            query+='("${notificationData.id}","${notificationData.userId}","${notificationData.statusType}","${notificationData.title}","${notificationData.message}","${notificationData.createdAt}")';
          }
          else
          {
            query+='("${notificationData.id}","${notificationData.userId}","${notificationData.statusType}","${notificationData.title}","${notificationData.message}","${notificationData.createdAt}"),';
          }
        }
        var id=db.rawQuery(query);
      }
    //db.rawInsert()
  }

  storeCardData(Data data,String path) async
  {
    final db = await database;
    if(data!=null)
    {
      String query="INSERT OR REPLACE INTO ${SQLiteDbProvider.card_table}(${SQLiteDbProvider.card_id},${SQLiteDbProvider.card_userid}"
          ",${SQLiteDbProvider.card_path},${SQLiteDbProvider.card_icardid},${SQLiteDbProvider.card_officeid})"
          " VALUES(${data.id},${data.user_id},'${path.replaceAll(r'/', '--')}','${data.icardId}',${data.office_id})";
      var id=await db.rawQuery(query);
      var id1=id;
    }
  }

  storeCardInfoData(String id,String data,String logoUrl, String userUrl,String qrUrl) async
  {
    final db = await database;
    if(data!=null)
    {
      String Data = '''INSERT OR REPLACE INTO ${SQLiteDbProvider.cardinfo_table} (${SQLiteDbProvider.cardinfo_id},${SQLiteDbProvider.cardinfo_data},${SQLiteDbProvider.cardinfoLogoPath},${SQLiteDbProvider.cardinfoUSerImagePath},${SQLiteDbProvider.cardinfoQrcodePath}) VALUES($id,'***$data***','${logoUrl != null?logoUrl.replaceAll(r'/',r'--'): null}','${userUrl !=null? userUrl.replaceAll(r'/',r'--'): null}','${qrUrl != null?qrUrl.replaceAll(r'/',r'--'):null}' )''';
      print(Data);
      var result=db.rawQuery(Data);
      /*if (kDebugMode) {
        print(result);
      }*/
    }
  }

  Future<dynamic> fetchCardInfoData(String id) async
  {
    var string=['','','',''];
    final db=await database;
    List<Map> list=await db.rawQuery("SELECT * FROM ${SQLiteDbProvider.cardinfo_table} WHERE ${SQLiteDbProvider.cardinfo_id} LIKE $id");
    if(list!=null && list.isNotEmpty)
    {
      String data=list[0][SQLiteDbProvider.cardinfo_data];
      string[0]=data;
      string[1]=list[0][SQLiteDbProvider.cardinfoLogoPath];
      string[2]=list[0][SQLiteDbProvider.cardinfoUSerImagePath];
      string[3]=list[0][SQLiteDbProvider.cardinfoQrcodePath];
      return string;
    }
    return string;
  }

  Future<List<Data>> fetchCardData() async
  {
    List<Data> listfetch=[];
    final db=await database;
    List<Map> list=await db.rawQuery("SELECT * FROM ${SQLiteDbProvider.card_table}");
    if(list!=null && list.length>0)
    {
      for(int i=0;i<list.length;i++)
        {
          listfetch.add(Data.fromJson(list[i]));
        }
    }
    return listfetch;
  }

  Future<dynamic> fetchProfileData(int id) async
  {
    var string=['',''];
    final db=await database;
    List<Map> list=await db.rawQuery("SELECT * FROM ${SQLiteDbProvider.profile_table} WHERE ${SQLiteDbProvider.profile_id} LIKE $id");
    if(list!=null && list.length>0)
    {
      String data=list[0]['${SQLiteDbProvider.profile_data}'];
      string[0]=data;
      string[1]=list[0]['${SQLiteDbProvider.profile_imagepath}'];
      return string;
    }
    return [];
  }
  
  storeProfileData(int id,String data,String path) async
  {
    final db = await database;
    var result=await db.rawQuery("INSERT OR REPLACE INTO ${SQLiteDbProvider.profile_table}(${SQLiteDbProvider.profile_id},${SQLiteDbProvider.profile_data},${SQLiteDbProvider.profile_imagepath}) VALUES($id,'***$data***','${path.replaceAll(r'/',r'--')}')");
    var result1=result;
  }

  /*Future<String> storecardInfoData() async
  {
    final db=await database;
    List<Map> list=await db.query("SELECT * FROM ${SQLiteDbProvider.profile_table} WHERE ${SQLiteDbProvider.profile_id} LIKE $id");
    if(list!=null && list.length>0)
      {
        String data=list[0]['${SQLiteDbProvider.profile_data}'];
        return data;
      }
    return "";
  }*/
  
  Future<List<NotificationData>> fetchNotificationData() async
  {
    final db = await database;
    List<NotificationData> list=[];
    List<Map> listmap=await db.query(SQLiteDbProvider.notification_table);
    for(int i=0;i<listmap.length;i++)
      {
        list.add(NotificationData.fromJson(listmap[i]));
      }
    return list;
  }

  Future<void> deleteOfflineData() async
  {
    final db = await database;
    db.delete(SQLiteDbProvider.card_table);
    db.delete(SQLiteDbProvider.cardinfo_table);
  }

  Future<bool> checkCardData() async
  {
    final db = await database;
    var data=await db.query(SQLiteDbProvider.card_table);
    if(data!=null && data.length>0)
      {
        return true;
      }
    else
      {
        return false;
      }
  }

  Future<bool> checkCardInfoData(String id) async
  {
    final db = await database;
    var data=await db.rawQuery("SELECT * FROM "+SQLiteDbProvider.cardinfo_table+" WHERE "+SQLiteDbProvider.cardinfo_id+" LIKE "+"$id");
    if(data!=null && data.length>0)
    {
      return true;
    }
    else
    {
      return false;
    }
  }

  Future<bool> checkProfileData() async
  {
    final db = await database;
    var data=await db.query(SQLiteDbProvider.profile_table);
    if(data!=null && data.length>0)
    {
      return true;
    }
    else
    {
      return false;
    }

  }


  /*Future<List<Product>> getAllProducts() async {
    final db = await database;
    List<Map> results = await db.query(
        "Product", columns: Product.columns, orderBy: "id ASC"
    );
    List<Product> products = new List();
    results.forEach((result) {
      Product product = Product.fromMap(result);
      products.add(product);
    });
    return products;
  }
  Future<Product> getProductById(int id) async {
    final db = await database;
    var result = await db.query("Product", where: "id = ", whereArgs: [id]);
    return result.isNotEmpty ? Product.fromMap(result.first) : Null;
  }
  insert(Product product) async {
    final db = await database;
    var maxIdResult = await db.rawQuery("SELECT MAX(id)+1 as last_inserted_id FROM Product");
    var id = maxIdResult.first["last_inserted_id"];
    var result = await db.rawInsert(
        "INSERT Into Product (id, name, description, price, image)"
            " VALUES (?, ?, ?, ?, ?)",
        [id, product.name, product.description, product.price, product.image]
    );
    return result;
  }
  update(Product product) async {
    final db = await database;
    var result = await db.update(
        "Product", product.toMap(), where: "id = ?", whereArgs: [product.id]
    );
    return result;
  }
  delete(int id) async {
    final db = await database;
    db.delete("Product", where: "id = ?", whereArgs: [id]);
  }*/

  void delete_offline_profile_cards_data()
  {

  }
}
