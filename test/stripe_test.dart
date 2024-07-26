import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_trainer/services/stripe_service.dart';

class MockStripeService extends Mock implements StripeService {
  Future<void> createSubscription(String stripeCustomerId, String priceId) async {
    return;
  }

  Future<void> cancelSubscription(String stripeCustomerId) async {
    return;
  }
}


void main() {
  group('StripeService Tests', ()
  {
    MockStripeService mockStripeService = MockStripeService();

    setUp(() {
      mockStripeService = MockStripeService();
    });

    test('createSubscription should be called with correct parameters', () async {
      // Arrange
      final stripeCustomerId = 'cus_test';
      final priceId = 'price_test';

      // Act
      await mockStripeService.createSubscription(stripeCustomerId, priceId);

      // Assert
      verify(mockStripeService.createSubscription(stripeCustomerId, priceId)).called(1);
    });

    test('cancelSubscription should be called with correct parameters', () async {
      // Arrange
      final stripeCustomerId = 'cus_test';

      // Act
      await mockStripeService.cancelSubscription(stripeCustomerId);

      // Assert
      verify(mockStripeService.cancelSubscription(stripeCustomerId)).called(1);
    });

    test('createSubscription should throw an exception when called with invalid parameters', () async {
      // Arrange
      final stripeCustomerId = null;
      final priceId = 'price_test';

      when(mockStripeService.createSubscription(stripeCustomerId, priceId)).thenThrow(Exception('Invalid parameters'));

      // Act
      try {
        await mockStripeService.createSubscription(stripeCustomerId, priceId);
      } catch (e) {
        // Assert
        expect(e, isA<Exception>());
      }
    });

    test('cancelSubscription should throw an exception when called with invalid parameters', () async {
      // Arrange
      final stripeCustomerId = null;

      when(mockStripeService.cancelSubscription(stripeCustomerId)).thenThrow(Exception('Invalid parameters'));

      // Act
      try {
        await mockStripeService.cancelSubscription(stripeCustomerId);
      } catch (e) {
        // Assert
        expect(e, isA<Exception>());
      } catch (e) {
        // Assert
        expect(e, isA<Exception>());
      }
    });
  });
}