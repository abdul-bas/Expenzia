# Expenzia

A Flutter application built with **Clean Architecture**, **BLoC**, and **SQLite**, with a focus on maintainable code and efficient local data management.

## 🛠 Tech Stack

| Category | Technology |
| --- | --- |
| Framework | Flutter |
| Language | Dart |
| Architecture | Clean Architecture |
| State Management | BLoC |
| Local Database | SQLite |
| AI-Assisted Development | Antigravity |

## 🏗 Architecture

Expenzia follows Clean Architecture principles to enforce a clear separation of concerns, making the codebase easier to maintain and extend. It is organized into three primary layers:

| Layer | Responsibility |
| --- | --- |
| **Presentation** | UI components and BLoC state management |
| **Domain** | Business logic, entities, and use cases |
| **Data** | Repository implementations, data sources, and SQLite operations |

### Project Structure

The codebase is organized by feature, with each feature in its own directory under `features/`:

```text
lib/
├── core/
├── features/
│   ├── credit/
│   ├── expense/
│   ├── home/
│   ├── onboarding/
│   ├── profile/
│   ├── splash/
│   └── transaction/
└── main.dart
```

## 💾 Data Storage

The application uses SQLite to store and manage structured data locally on the device.

## 🤖 AI-Assisted Development

Antigravity's AI capabilities were used during development to evaluate implementation approaches, improve the workflow, and build features more efficiently.

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (includes Dart)
- Git
- A supported emulator, simulator, or physical device

### Installation

1. Clone the repository:

   ```bash
   git clone <your-repository-url> expenzia
   ```

2. Navigate to the project directory:

   ```bash
   cd expenzia
   ```

3. Install the dependencies:

   ```bash
   flutter pub get
   ```

4. Run the application:

   ```bash
   flutter run
   ```

## 📚 Key Learnings

This project provided practical experience in:

- Implementing Clean Architecture in Flutter
- Managing application state with BLoC
- Integrating SQLite for local database operations
- Applying AI-assisted development with Antigravity

---

**Built with Flutter and Dart.**
