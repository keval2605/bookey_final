import 'package:cloud_firestore/cloud_firestore.dart';
import '../database/auth.dart';

class FavouriteDB {
  final AuthService _auth = AuthService();
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> add(item) {
    item['user_id'] = _auth.getUid();
    return db.collection("favourites").doc(item['id'].replaceAll('/', '-')).set(item);
  }

  Future<void> delete(uid) {
    return db.collection('favourites').doc(uid.replaceAll('/', '-')).delete();
  }

  Future<List> listAll() async {
    QuerySnapshot querySnapshot = await db.collection('favourites').where('user_id', isEqualTo: _auth.getUid()).get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData;
  }

  Future check(id) async {
    var post = await db.collection('favourites').doc(id.replaceAll('/', '-')).get();
    return post.exists ? true : false;
  }
}
