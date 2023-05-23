import 'model.dart';

// We're defining the responses classes to model api to dart object, which is of nullable type
// Then we're again using similar models, which are non-nullable...
// * It is done to pass non-nullable objects to view, and the conversion from nullable
// * to non-nullable is done during the mapping...
class Authentication {
  Customer customer;
  Contact contact;

  Authentication({
    required this.customer,
    required this.contact,
  });
}
