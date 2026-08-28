# Lifeline Ethiopia

A bilingual blood-donation matching app designed for Ethiopian cities. It makes the social-impact story direct: hospitals can post urgent blood needs, and eligible donors nearby receive an alert and can immediately offer to help.

## Included experience

- A clean Amharic/English donor experience (language toggle on Home/Profile)
- Urgent hospital request board with blood-group filters
- Donor matching by blood type and city/distance-ready fields
- Donor impact profile and eligibility status
- Request creation and offer-to-help interactions
- Firebase repository for Auth, Firestore, FCM token registration, and compatible blood-group matching
- Cloud Function that sends urgent FCM alerts only to matching, available donors in the same city
- Firestore rules that protect donor profiles and request ownership

## Run the prototype

```bash
flutter pub get
flutter run
```

The polished UI uses local demonstration records until Firebase is configured, so it is safe to run immediately.

## Connect Firebase

1. Create a Firebase project, enable **Anonymous** (or Phone) Authentication, Cloud Firestore, and Cloud Messaging.
2. Install FlutterFire CLI and run `flutterfire configure` from this project. This generates `lib/firebase_options.dart` and platform configuration files.
3. In `main.dart`, initialize Firebase before `runApp`:

```dart
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
runApp(const LifelineApp());
```

4. Replace demo request data in the screens with `FirebaseMatchService.urgentRequests(...)`; call `saveDonorProfile`, `saveMessagingToken`, and `createRequest` at the corresponding user actions.
5. Deploy security rules and notifications:

```bash
firebase deploy --only firestore:rules
cd functions && npm install && cd ..
firebase deploy --only functions
```

For production, validate donation eligibility with a qualified medical workflow, verify hospital accounts server-side, add rate limits, and store exact location only with explicit consent.

## Interview story

Lifeline Ethiopia shortens the time between an urgent blood need and a willing donor. It combines compatibility-first matching, city-level routing, multilingual access, and responsible notification design—practical choices for high-need, high-friction urban donation coordination.
