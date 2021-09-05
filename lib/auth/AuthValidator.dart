abstract class AuthValidator {
  bool validate(String value);
}

class SimpleAuthValidator extends AuthValidator {
  @override
  bool validate(String value) => value.isNotEmpty;
}
