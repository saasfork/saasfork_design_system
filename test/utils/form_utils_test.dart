import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:saasfork_design_system/utils/form_utils.dart';

void main() {
  group('FormUtils.isFormValid', () {
    test('should return true when form is valid', () {
      // Arrange
      final form = FormGroup({
        'name': FormControl<String>(
          value: 'John Doe',
          validators: [Validators.required],
        ),
        'email': FormControl<String>(
          value: 'john@example.com',
          validators: [Validators.required, Validators.email],
        ),
      });

      // Act
      final result = FormUtils.isFormValid(form);

      // Assert
      expect(result, true);
    });

    test('should return false when required field is empty', () {
      // Arrange
      final form = FormGroup({
        'name': FormControl<String>(
          value: '',
          validators: [Validators.required],
        ),
        'email': FormControl<String>(
          value: 'john@example.com',
          validators: [Validators.required, Validators.email],
        ),
      });

      // Act
      final result = FormUtils.isFormValid(form);

      // Assert
      expect(result, false);
    });

    test('should return false when email is invalid', () {
      // Arrange
      final form = FormGroup({
        'name': FormControl<String>(
          value: 'John Doe',
          validators: [Validators.required],
        ),
        'email': FormControl<String>(
          value: 'invalid-email',
          validators: [Validators.required, Validators.email],
        ),
      });

      // Act
      final result = FormUtils.isFormValid(form);

      // Assert
      expect(result, false);
    });

    test('should mark all fields as touched', () {
      // Arrange
      final nameControl = FormControl<String>(
        value: '',
        validators: [Validators.required],
      );
      final emailControl = FormControl<String>(
        value: '',
        validators: [Validators.required, Validators.email],
      );

      final form = FormGroup({'name': nameControl, 'email': emailControl});

      // Verify fields are not touched initially
      expect(nameControl.touched, false);
      expect(emailControl.touched, false);

      // Act
      FormUtils.isFormValid(form);

      // Assert
      expect(nameControl.touched, true);
      expect(emailControl.touched, true);
    });

    test('should call setState callback if provided', () {
      // Arrange
      final form = FormGroup({
        'name': FormControl<String>(
          value: 'John Doe',
          validators: [Validators.required],
        ),
      });

      bool callbackCalled = false;
      void setStateCallback() {
        callbackCalled = true;
      }

      // Act
      FormUtils.isFormValid(form, setState: setStateCallback);

      // Assert
      expect(callbackCalled, true);
    });

    test('should handle nested form groups', () {
      // Arrange
      final nestedForm = FormGroup({
        'street': FormControl<String>(
          value: '',
          validators: [Validators.required],
        ),
        'city': FormControl<String>(
          value: 'Paris',
          validators: [Validators.required],
        ),
      });

      final form = FormGroup({
        'name': FormControl<String>(
          value: 'John Doe',
          validators: [Validators.required],
        ),
        'address': nestedForm,
      });

      // Act
      final result = FormUtils.isFormValid(form);

      // Assert
      expect(result, false); // Le champ street est vide
    });

    test('should handle null values', () {
      // Arrange
      final form = FormGroup({
        'name': FormControl<String>(
          value: null,
          validators: [Validators.required],
        ),
        'description': FormControl<String>(
          value: null,
        ), // Sans validateur required
      });

      // Act
      final result = FormUtils.isFormValid(form);

      // Assert
      expect(result, false); // name est required mais null
    });
  });
}
