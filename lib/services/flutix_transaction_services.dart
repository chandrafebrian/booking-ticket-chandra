part of 'services.dart';

class bookingtiketTransactionServices {
  static CollectionReference transactionCollection =
      FirebaseFirestore.instance.collection('transactions');

  static Future<void> saveTransaction(
      bookingtiketTransaction bookingtiketTransaction) async {
    await transactionCollection.doc().set({
      'userID': bookingtiketTransaction.userID,
      'title': bookingtiketTransaction.title,
      'subtitle': bookingtiketTransaction.subtitle,
      'time': bookingtiketTransaction.time.millisecondsSinceEpoch,
      'amount': bookingtiketTransaction.amount,
      'picture': bookingtiketTransaction.picture
    });
  }

  static Future<List<bookingtiketTransaction>> getTransaction(
      String userID) async {
    QuerySnapshot snapshot = await transactionCollection.get();

    var documents =
        snapshot.docs.where((document) => document.data()['userID'] == userID);

    return documents
        .map((e) => bookingtiketTransaction(
            userID: e.data()['userID'],
            title: e.data()['title'],
            subtitle: e.data()['subtitle'],
            time: DateTime.fromMillisecondsSinceEpoch(e.data()['time']),
            amount: e.data()['amount'],
            picture: e.data()['picture']))
        .toList();
  }
}
