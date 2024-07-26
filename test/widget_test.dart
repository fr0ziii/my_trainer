import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:my_trainer/models/user_model.dart';
import 'package:my_trainer/services/stripe_service.dart';
import 'package:my_trainer/services/user_service.dart';
import 'package:my_trainer/view_models/auth_view_model.dart';
import 'package:my_trainer/views/home_screen.dart';
import 'package:my_trainer/views/login_screen.dart';
import 'package:my_trainer/views/users_screen.dart';
import 'package:provider/provider.dart';

import 'stripe_test.dart';

class MockUserService extends Mock implements UserService {}
class MockAuthViewModel extends Mock implements AuthViewModel {}

void main() {
  late MockUserService mockUserService;
  late MockAuthViewModel mockAuthViewModel;

  setUp(() {
    mockUserService = MockUserService();
    mockAuthViewModel = MockAuthViewModel();
  });

  Widget createWidgetUnderTest() {
    return MultiProvider(
      providers: [
        Provider<UserService>(create: (_) => mockUserService),
        ChangeNotifierProvider<AuthViewModel>(create: (_) => mockAuthViewModel),
      ],
      child: MaterialApp(
        home: UsersScreen(),
      ),
    );
  }

  testWidgets('UsersScreen renders correctly', (WidgetTester tester) async {
    // Arrange
    when(mockAuthViewModel.getCurrentUser())
        .thenAnswer((_) async => UserModel(trainerId: 'trainer1', uid: '', email: '', stripeCustomerId: '', displayName: '', role: ''));
    when(mockUserService.getUsersByTrainer('trainer1'))
        .thenAnswer((_) => Stream.value([
      UserModel(displayName: 'User1', email: 'user1@example.com', uid: '', stripeCustomerId: '', role: '', trainerId: ''),
      UserModel(displayName: 'User2', email: 'user2@example.com', uid: '', stripeCustomerId: '', role: '', trainerId: ''),
    ]));

    // Act
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Clientes'), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(2));
    expect(find.text('User1'), findsOneWidget);
    expect(find.text('user1@example.com'), findsOneWidget);
    expect(find.text('User2'), findsOneWidget);
    expect(find.text('user2@example.com'), findsOneWidget);
  });

  testWidgets('Shows AddUserDialog when FAB is tapped', (WidgetTester tester) async {
    // Arrange
    when(mockAuthViewModel.getCurrentUser())
        .thenAnswer((_) async => UserModel(trainerId: 'trainer1', uid: '', email: '', stripeCustomerId: '', displayName: '', role: ''));
    when(mockUserService.getUsersByTrainer('trainer1'))
        .thenAnswer((_) => Stream.value([]));

    // Act
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Assert
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Añadir cliente'), findsOneWidget);
  });
}

void loginScreenTests() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserService mockUserService;
  late MockStripeService mockStripeService;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserService = MockUserService();
    mockStripeService = MockStripeService();
  });

  Widget createWidgetUnderTest() {
    return MultiProvider(
      providers: [
        Provider<UserService>(create: (_) => mockUserService),
        Provider<StripeService>(create: (_) => mockStripeService),
      ],
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }

  testWidgets('Shows SignInScreen when user is not logged in', (WidgetTester tester) async {
    // Arrange
    when(mockFirebaseAuth.idTokenChanges())
        .thenAnswer((_) => Stream.value(null));

    // Act
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Assert
    expect(find.byType(SignInScreen), findsOneWidget);
  });

  testWidgets('Navigates to HomeScreen when user is logged in', (WidgetTester tester) async {
    // Arrange
    final mockUser = MockUser(
      uid: '12345',
      email: 'test@example.com',
      displayName: 'Test User',
      photoURL: 'http://example.com/photo.jpg',
    );
    when(mockFirebaseAuth.idTokenChanges())
        .thenAnswer((_) => Stream.value(mockUser));
    when(mockUserService.checkIfUserExists('12345'))
        .thenAnswer((_) async => true);

    // Act
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Assert
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('Creates new user and navigates to HomeScreen', (WidgetTester tester) async {
    // Arrange
    final mockUser = MockUser(
      uid: '12345',
      email: 'test@example.com',
      displayName: 'Test User',
      photoURL: 'http://example.com/photo.jpg',
    );
    when(mockFirebaseAuth.idTokenChanges())
        .thenAnswer((_) => Stream.value(mockUser));
    when(mockUserService.checkIfUserExists('12345'))
        .thenAnswer((_) async => false);
    when(mockStripeService.createCustomer('12345'))
        .thenAnswer((_) async => {'id': 'stripe123'});
    when(mockUserService.addUser('12345', {'id': 'stripe123'}))
        .thenAnswer((_) async => true);

    // Act
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Assert
    verify(mockStripeService.createCustomer(mockUser.email!)).called(1);
    verify(mockUserService.addUser(mockUser.uid, {'id': 'stripe123'})).called(1);
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}