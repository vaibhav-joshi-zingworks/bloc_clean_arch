# 🌊 Bloc Clean Architecture (BCA) - Deep Documentation

> **A high-performance, modular Flutter boilerplate built for production-grade applications.**
> This architecture focuses on **Scalability**, **Testability**, and **Developer Productivity**.

Full project documentation: [docs/PROJECT_DOCUMENTATION.md](docs/PROJECT_DOCUMENTATION.md). Slide deck: [docs/Bloc_Clean_Architecture_Overview.pptx](docs/Bloc_Clean_Architecture_Overview.pptx) (regenerate with `python3 scripts/generate_project_ppt.py`).

---

## 🚀 Quick Start (Get Running in 2 Mins)

If you are new to the project, run these commands in order:

```bash
# 1. Install dependencies
make setup

# 2. Generate all boilerplate code (DI, JSON, Freezed)
make build

# 3. Start the app
flutter run
```

---

## 🏗 Architecture Philosophy (The "Big Picture")

Think of our architecture like building a **Skyline City**. For a city to stand strong for 100 years, you need a solid foundation, specialized workers, and beautiful facades. We use **Clean Architecture** to ensure that if we decide to change the "plumbing" (the database), the "paint on the walls" (the UI) doesn't need to be scrapped.

### 🧩 1. The Domain Layer (The "Brain" / The Blueprint)
*This is the heart of the application. It contains the rules of the business that never change, even if you switch from Flutter to a Web app.*
- **What it is:** Pure Dart code. It has **zero** dependencies. It doesn't know what an "API" is or what a "Button" looks like.
- **Why it matters:** It makes the app extremely easy to test. You can test your logic (e.g., "If user is under 18, block access") without even starting a phone emulator.
- **Components:**
    - **Entities:** The pure data shapes. Example: A `User` entity has a name and email. It's the "Source of Truth."
    - **Use Cases:** The specific "Jobs" the app can do. Example: `LoginUserUseCase`, `CalculateInterestUseCase`. Each class does **exactly one thing**.
    - **Repository Interfaces:** A "Wishlist" created by the Brain. It says: "I need a way to save a user, but I don't care if you save it to a Cloud or a File."

### 📦 2. The Data Layer (The "Workforce" / The Infrastructure)
*This is where the heavy lifting happens. It implements the "Wishlist" (Interfaces) from the Domain layer.*
- **What it is:** The part that knows how to talk to the outside world (REST APIs, Databases, Firebase).
- **Why it matters:** If the Backend API changes from Version 1 to Version 2, you **only** change code in this layer. The rest of the app stays exactly the same.
- **Components:**
    - **Data Sources:** The specific tools. `RemoteDataSource` talks to the internet via HTTP. `LocalDataSource` talks to the phone's storage.
    - **Models (DTOs):** Data Transfer Objects. These are the messy JSON shapes we get from the internet. We use `freezed` to make them safe.
    - **Mappers:** The "Translators." They take a messy `UserDTO` from the internet and turn it into a clean `UserEntity` for the Brain.
    - **Repository Implementation:** The "Smart Switch." It decides: "I'll try to get data from the Internet first; if that fails, I'll fetch it from the Local Cache."

### 📱 3. The Presentation Layer (The "Face" / The Experience)
*This is the only part the user ever interacts with.*
- **What it is:** Flutter Widgets and BLoC (Business Logic Components).
- **Why it matters:** It keeps the UI "dumb" and "reactive." The UI just waits for instructions from the BLoC.
- **Components:**
    - **BLoC:** The "Controller." It takes a User Event (like "Button Clicked"), asks the Domain (UseCase) for data, and then shouts a "State" (like "Loading" or "Success") back to the screen.
    - **Screens & Widgets:** The visual elements. They listen to the BLoC and update the screen instantly.

---

# 🗺 The 5-Step Journey (Feature Development Guide)

**Freshers start here!** To build any new feature (e.g., a "Profile" page), follow this exact path. Don't skip steps!

### 1️⃣ Step 1: 🧩 Domain (The Plan)
*First, decide what the feature does before you think about how it looks.*
- **Create the Entity:** What does the data look like? (e.g., `ProfileEntity` with name, bio, photo).
- **Create the Repository Interface:** What commands do we need? (e.g., `getProfile()`, `updateProfile()`).
- **Create the Use Case:** Write the logic for the action.

### 2️⃣ Step 2: 📦 Data (The Execution)
*Now, write the code to get the actual data from the API.*
- **Create the Model/DTO:** Match the exact JSON keys from your backend documentation.
- **Create the Data Source:** Write the `Dio` call to fetch the JSON.
- **Create the Mapper:** Write a function to convert your JSON Model into your clean Entity.
- **Create the Repository Implementation:** Link the Data Source and the Mapper together.

### 3️⃣ Step 3: 🧠 Presentation (The Look)
*Now, build the UI and the logic that connects it to the Brain.*
- **Create the BLoC:** Define your Events (User clicks) and States (UI changes).
- **Create the Screen:** Build the main scaffold for the page.
- **Create Widgets:** Split the page into small, reusable pieces (e.g., `ProfileHeader`, `LogoutButton`).

### 4️⃣ Step 4: 💉 Wiring (The Connection)
*Tell the app how to put these pieces together automatically.*
- **Annotations:** Add `@injectable` to your Repository, DataSource, and BLoC. This tells the app: "Hey, I need these classes ready to use!"
- **Build:** Run `make build`. This triggers our **Auto-Assembly Line** (Build Runner) which generates all the boring "glue" code for you.

### 5️⃣ Step 5: 🚦 Routing (The Map)
*Tell the app how to navigate to your new page.*
- **Register Route:** Go to `lib/app/router/app_router.dart` and add your new screen to the map.
- **Navigate:** Use `context.goNamed('profile')` to move to your new page.

---

## ⚙️ Core Infrastructure (The "Engine Room")

This is the hidden machinery that makes the app powerful, secure, and professional.

### 🔌 Dependency Injection (DI) - *The Auto-Assembler*
Instead of you manually writing `val repo = MyRepository(MyDataSource(MyHttpClient()))` every time (which is a nightmare), we use **Injectable**.
- **How it works:** It's like a library. You ask for a "Service," and the library automatically finds it and hands it to you. This makes the code decoupled and easy to swap out during testing.

### 🌐 Networking - *The Secure Mailman*
We use `Dio` with advanced **Interceptors**.
- **The Interceptor Pattern:** Think of it as a security checkpoint at a border. Every API request passes through:
    - **Logger:** Prints the request in the console (Dev mode).
    - **Header Interceptor:** Automatically adds your `Auth Token` (JWT) to every call so you don't have to do it manually.
    - **Error Interceptor:** If the server returns a `401 Unauthorized`, it automatically kicks the user back to the Login screen.

### 💾 Strategy-Based Storage - *The Smart Filing Cabinet*
We don't just "save data." We use a **Strategy Pattern** to decide *where* data goes based on its importance.
- **Shared Preferences Strategy:** For simple things like "Dark Mode" or "Language."
- **Secure Storage Strategy:** For sensitive things like "Access Tokens" or "User IDs."
- **The Facade:** You just call `storage.save(key, value)`, and the app automatically picks the right strategy based on the key.

### 🔒 Enterprise Security - *The Bank Vault*
- **SSL Pinning:** We hardcode the server's certificate thumbprint. If a hacker tries to sit in the middle and read your data, the app will instantly disconnect.
- **Jailbreak/Root Detection:** The app checks if the phone has been hacked. If it has, the app can refuse to open to protect sensitive bank/user data.
- **Privacy Mode:** When the user switches apps, we blur the screen so people can't see sensitive info in the "recent apps" list.

---

## ⚠️ The Golden Rules
> [!IMPORTANT]
> 1. **Unidirectional Flow**: Data flows in one direction. UI ➡️ BLoC ➡️ UseCase ➡️ Repository. **Never** let a Screen talk to a Data Source directly.
> 2. **No Models in UI**: The Screen should only know about **Entities**. If your UI code has `fromJson` or `toJson` in it, you've broken the rule!
> 3. **The Result Pattern**: We use `Either<Failure, Success>`. This forces you to handle errors. You can never "forget" to handle a failed API call.

---

## 🤝 Commit Message Conventions
`type(scope): description`

| Type | When to use it | Example |
|------|----------------|---------|
| `feat` | New feature | `feat(auth): add login` |
| `fix` | Bug fix | `fix(ui): fix button color` |
| `docs` | Documentation | `docs: update readme` |
| `refactor`| Clean up code | `refactor: simplify storage` |

---

## 🔐 Reference Feature: Auth (`lib/features/auth/`)
*If you are ever confused, look at the Auth folder. It is the perfect example of how to build everything from Domain to Presentation.*
