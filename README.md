# <p align="center">Ummah - Modern Islamic Lifestyle App</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" />
  <img src="https://img.shields.io/badge/Clean_Architecture-Pattern-green?style=for-the-badge" />
</p>

---

## 🌟 Introduction
**Ummah** is a premium Islamic companion application designed to empower Muslims in their daily spiritual journey. Built with a focus on **Visual Excellence** and **User Experience**, the app combines essential Islamic tools with a modern, minimalist aesthetic.

Whether you're reading the Holy Quran, tracking your daily Azkar, or keeping up with prayer times, Ummah provides a seamless and distraction-free environment.

---

## ✨ Key Features

| Feature | Description |
| :--- | :--- |
| **📖 Holy Quran** | Read the Quran with clear typography, including Tafsir and bookmarking capabilities. |
| **🕌 Prayer Times** | Accurate, location-based prayer timings with automated reminders and notifications. |
| **📿 Digital Tasbih** | An elegant electronic counter for Dhikr with haptic feedback and beautiful animations. |
| **🤲 Azkar & Dua** | A categorized library of authentic morning, evening, and situational supplications. |
| **📅 Hijri Calendar** | Unified Hijri and Gregorian calendar to stay on top of Islamic dates and events. |
| **🌐 Multi-language** | Native support for **Arabic** and **English**, localized for global accessibility. |
| **🌓 Adaptive Theme** | Beautifully crafted **Light** and **Dark** modes to suit your preference and environment. |

---

## 🛠 Tech Stack & Architecture

### **Core Frameworks**
- **Flutter & Dart**: For high-performance cross-platform development.
- **BLoC/Cubit**: Advanced state management for predictable and scalable data flow.
- **Clean Architecture**: Strict adherence to Domain, Data, and Presentation layers.

### **Integrations**
- **Firebase**: Leveraging FCM for real-time notifications and Firebase Core for cloud infrastructure.
- **Hive**: Ultra-fast local NoSQL database for caching and offline support.
- **Retrofit & Dio**: Type-safe REST API client for reliable networking.
- **GetIt & Injectable**: Professional Dependency Injection for modular development.

### **UI & Experience**
- **ScreenUtil**: Responsive UI that scales perfectly across all screen sizes.
- **Flutter Animate**: Fluid micro-animations for a premium feel.
- **Skeletonizer**: Smooth loading states that improve perceived performance.
- **Easy Localization**: Dynamic runtime language switching.

---

## 📂 Project Structure

```bash
lib/
├── core/                # Core configurations (Theme, Constants, Errors)
│   ├── services/        # App-wide services (Notifications, DI, Hive)
│   └── config/          # Navigation and routing logic
├── features/            # Feature-driven modular development
│   ├── azkar/           # Morning/Evening Remembrances
│   ├── calendar/        # Hijri & Gregorian logic
│   ├── quran/           # Quran Reader & Index
│   ├── home/            # Dashboard & UI skeleton
│   ├── tasbih/          # Digital Counter
│   └── settings/        # User Preferences & Theme
├── main.dart            # Application Entry Point
└── my_app.dart          # Main App Widget & Initialization
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (`^3.11.0`)
- Android Studio / VS Code
- Firebase Project (for notifications)

### Installation
1. **Clone the repository:**
   ```bash
   git clone https://github.com/YoussefCodez/Ummah-App.git
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Run Build Runner (for DI and JSON):**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
4. **Run the App:**
   ```bash
   flutter run
   ```

---

## 📸 Screen Shots

<p align="center">
  <img src="https://github.com/user-attachments/assets/9a1310a9-2d4c-4198-8fe5-a615b3638115" width="24%" />
  <img src="https://github.com/user-attachments/assets/8ed86820-dcbf-4833-a263-2512ba642809" width="24%" />
  <img src="https://github.com/user-attachments/assets/aceb033d-a39c-4591-8bc5-a23116b809c6" width="24%" />
  <img src="https://github.com/user-attachments/assets/26734bdf-761c-48c3-a582-26b6a9328b42" width="24%" />
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/bc19b442-2c7b-46e7-9618-cce97b27a82d" width="24%" />
  <img src="https://github.com/user-attachments/assets/49741bc9-cd69-47a9-9c74-531871105030" width="24%" />
  <img src="https://github.com/user-attachments/assets/3a5b4d67-c21a-4e9e-80a5-bb2f54218be9" width="24%" />
  <img src="https://github.com/user-attachments/assets/8d9c1274-8d7e-48e4-b62a-c3260a220c50" width="24%" />
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/a834230c-74e3-4f00-a714-4d86fefd2b69" width="24%" />
  <img src="https://github.com/user-attachments/assets/3008a10d-905c-4a70-8c29-20c1f2eec636" width="24%" />
  <img src="https://github.com/user-attachments/assets/32bcd1c2-7362-4024-8a32-ba33c7e75872" width="24%" />
  <img src="https://github.com/user-attachments/assets/7a5686e6-3236-450a-99f2-20958725d04d" width="24%" />
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/3e80bb24-145e-4df7-b9f2-f77fbc2488f2" width="24%" />
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/3f6df69e-393e-49da-8297-8f2513178eaf" width="24%" />
  <img src="https://github.com/user-attachments/assets/4781f49e-3d51-4fd8-81cf-129658b0ef7d" width="24%" />
  <img src="https://github.com/user-attachments/assets/656bf323-7e1a-4828-b5fc-26270dd00543" width="24%" />
  <img src="https://github.com/user-attachments/assets/23852fa7-5790-4bd7-a28e-75611a38d006" width="24%" />
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/34a672a6-dc4b-4324-a648-673467e34192" width="24%" />
  <img src="https://github.com/user-attachments/assets/130b790f-de21-4882-a69b-37c1f1e8a0b1" width="24%" />
  <img src="https://github.com/user-attachments/assets/b7e97312-b0ec-4380-87c3-b8607fd7eb94" width="24%" />
  <img src="https://github.com/user-attachments/assets/150c4081-6558-44aa-bf8c-732071dab3b6" width="24%" />
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/cdd7c089-c675-4314-bd3c-12505b554020" width="24%" />
  <img src="https://github.com/user-attachments/assets/d36a9d40-22b9-4101-b783-1a3845e163ef" width="24%" />
  <img src="https://github.com/user-attachments/assets/c00ce8d4-111a-4617-a792-951768011055" width="24%" />
  <img src="https://github.com/user-attachments/assets/55d6b45d-e96e-421d-805c-d8397ef91f19" width="24%" />
</p>


<!-- Add your generated banner here if you want to include it locally -->
<!-- ![Banner](assets/images/ummah_banner.png) -->

---

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contact
Developed with ❤️ by **Youssef**
- GitHub: [@YoussefCodez](https://github.com/YoussefCodez)
- Portfolio: [@JoeCodez](https://joeportfolio-alpha.vercel.app/)

---
<p align="center">"Bringing the Ummah together, one step at a time."</p>
