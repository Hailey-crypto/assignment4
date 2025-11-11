import 'package:assignment4/model/to_do_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoRepository {
  // Firestore 객체 생성
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // R (전체 문서 읽기)
  Future<List<ToDoModel>> getToDos() async {
    final snapshot = await firestore.collection('todos').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return ToDoModel.fromJson({
        ...data,
        'id': doc.id, // Firestore 의 문서 ID를 모델 id로 사용
      });
    }).toList();
  }

  // C
  Future<void> addToDo(ToDoModel todo) async {
    final docRef = todo.id.isNotEmpty
        ? firestore.collection('todos').doc(todo.id)
        : firestore.collection('todos').doc(); // id가 없으면 Firestore가 자동으로 생성
    await docRef.set(todo.copyWith(id: docRef.id).toJson());
  }

  // U
  Future<void> updateToDo(ToDoModel todo) async {
    await firestore.collection('todos').doc(todo.id).update(todo.toJson());
  }

  // D
  Future<void> deleteToDo(ToDoModel todo) async {
    await firestore.collection('todos').doc(todo.id).delete();
  }
}
