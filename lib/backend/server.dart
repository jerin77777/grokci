import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

late Databases db;
late Account account;
// all database details used from here
class DbConfig {
  static String endpoint = "https://cloud.appwrite.io/v1";
  static String project = "grokci";
  static String databaseId = "6504263e007ff813b432";
  static String ordersId = "65c9e1dda6e0b52f3463";
  static String productsId = "650426742ba0530f4ed7";
}

getOrders() async {
  // account.create(userId: ID.unique(), email:  "jerinjacob0007@gmail.com", password: "0007!asd");
  // account.createEmailSession(email: email, password: password)
  await account.createEmailSession(email: "jerinjacob0007@gmail.com", password: "0007!asd");
  DocumentList temp = await db.listDocuments(databaseId: DbConfig.databaseId, collectionId: DbConfig.ordersId);
  print(temp.documents.first.data);

  // db.getDocument(databaseId: "databaseId", collectionId: "collectionId", documentId: "documentId");
}
