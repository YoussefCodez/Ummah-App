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

Whether you're reading the Holy Quran, tracking your daily Azkar, or keeping up with prayer times, Ummah provides a seamless and distraction-free environment with full offline capabilities.

---

## ✨ Key Features

| Feature | Description |
| :--- | :--- |
| **📖 Holy Quran** | Dual-mode reading experience (**Mushaf** for traditional pages and **Ayah** for text-based). Includes **Full-Text Search**, Tafsir, and bookmarking. |
| **🎧 Audio Streaming** | High-quality recitations for every Ayah with **Smart Caching** for offline playback using `DefaultCacheManager`. |
| **🕌 Prayer Times** | Location-based monthly prayer timings with **Offline Caching**. Accurate calculation methods for global support. |
| **📿 Digital Tasbih** | An elegant electronic counter for Dhikr with haptic feedback, beautiful animations, and progress tracking. |
| **🤲 Azkar & Dua** | A categorized library of authentic morning, evening, and situational supplications with completion tracking. |
| **📅 Hijri Calendar** | Unified Hijri and Gregorian calendar to stay on top of Islamic dates and religious events. |
| **🌓 Adaptive Theme** | Sleek **Dark Mode** and **Light Mode** support, meticulously crafted for eye comfort during night readings. |
| **🌐 Localization** | Fully localized in **Arabic** and **English** with RTL support. |

---

## 🛠 Tech Stack & Architecture

### **Core Frameworks**
- **Flutter & Dart**: Cross-platform engine.
- **BLoC/Cubit**: Clean state management for predictable UI updates.
- **Clean Architecture**: Organized into `Domain`, `Data`, and `Presentation` layers for maximum maintainability.

### **Integrations & Performance**
- **Hive CE**: Ultra-fast local NoSQL database for lightning-fast data persistence.
- **AudioPlayers**: Robust audio engine with background playback support.
- **Flutter Cache Manager**: Intelligent caching for recitations and network assets.
- **GetIt & Injectable**: Enterprise-grade Dependency Injection.
- **Retrofit & Dio**: Type-safe networking with interceptors for reliable API calls.

### **UI & Experience**
- **ScreenUtil**: Pixel-perfect responsive design across all mobile devices.
- **Persistent Bottom Nav Bar**: Seamless navigation experience that preserves tab states.
- **Skeletonizer**: Premium loading placeholders for a smoother perceived performance.
- **Flutter Animate**: subtle micro-animations that enhance the premium feel.

---

## 📂 Project Structure

```bash
lib/
├── core/                # Global configurations, themes, and shared logic
│   ├── services/        # Singleton services (DI, Hive, Cache)
│   ├── config/          # App-wide routing and navigation
│   └── theme/           # AppColors and ThemeData definitions
├── features/            # Modular feature-driven development
│   ├── home/            # Dashboard with dynamic prayer updates
│   ├── quran/           # Quran index, search, and reading modes
│   ├── surah_details/   # Detailed Mushaf and Ayah views
│   ├── prayers/         # Prayer timing logic and scheduling
│   ├── azkar/           # Daily remembrances and tracking
│   ├── tasbih/          # Interactive counter
│   └── settings/        # Preferences (Reciters, Mushaf Mode, Theme)
├── main.dart            # Initialization & Firebase setup
└── my_app.dart          # Localized material app wrapper
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (`^3.19.0`)
- Android Studio / VS Code
- Firebase Project setup for Push Notifications

### Installation
1. **Clone the repository:**
   ```bash
   git clone https://github.com/YoussefCodez/Ummah-App.git
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Generate boilerplate code (DI/JSON):**
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

---

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contact
Developed with ❤️ by **Youssef**
- GitHub: [@YoussefCodez](https://github.com/YoussefCodez)
- Portfolio: [JoeCodez](https://joeportfolio-alpha.vercel.app/)

---
<p align="center">"Bringing the Ummah together, one step at a time."</p>
