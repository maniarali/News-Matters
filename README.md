# News-Matters
A localized news app showcasing the **most viewed** and **most popular** New York Times news, aptly named **"News Matters"**.  

---

## What's in the README
- [🚀 Quick Summary](#quick-summary)  
- [📥 Clone Project and Requirements](#clone-project-and-requirements)  
- [🛠️ Build Project](#build-project)  
- [✅ Unit Tests](#unit-tests)  
- [📱 App Flow](#app-flow)  
- [🏛️ Architectural Pattern](#architectural-pattern)  
- [🌟 Improvements for the Future](#improvements-for-the-future)  

---

## Quick Summary
**News Matters** is a simple iOS app that fetches data from the NY Times Most Popular Articles API and displays a list of articles. Tap an article to view its details!  
**API Endpoint:**  
`http://api.nytimes.com/svc/mostpopular/v2/mostviewed/{section}/{period}.json?api-key=sample-key`

---

## Clone Project and Requirements
- Clone via HTTPS: `https://github.com/maniarali/News-Matters.git`  
- Download as a ZIP from the repository.  
- Checkout the **main** branch for the default implementation.  
- For Combine framework, checkout the **combine** branch.  
- 📱 **Minimum iOS Version: 16.0**, Supported Xcode: **16.2**

---

## Build Project
1. **Download Project:**  
   a. Download directly: `Code > Download ZIP`  
   b. Clone via HTTPS: `Code > Clone via HTTPS`  
2. Open the project by double-clicking `News-Matters.xcodeproj`.  
   - No external dependencies required!  
3. Click `Run` or press `CMD + R` in Xcode.  
4. Hurray! 🎉 You’re ready to view NY Times popular news!

---

## Unit Tests
1. Run tests by pressing `CMD + U` in Xcode.  
2. View coverage:  
   - Go to the **Report Navigator**.  
   - Open the **Coverage** section.  
   - Click on `News-Matters.app` to see details.

---

## App Flow
1. **Home Screen:** Displays a list of the most popular NY Times articles.  
2. **Detail Screen:** Tap any article to see its full details.

---

## Architectural Pattern
- **Presentation Layer:** MVVM (Model-View-ViewModel)  
- **Data Layer:** Repository Pattern  
- **Navigation:** Coordinator Pattern  

---

## Improvements for the Future
- Add a **Business Logic Layer** with Use Cases.  
- Implement a **Dependency Container** for better dependency inversion.  
- Enable **offline persistence** to show cached data without internet.  
- Add **search functionality**, period/section dropdowns.  
- Upgrade UI to **SwiftUI** and use **Combine** for layer communication.

---

Enjoy exploring **News Matters**! Contributions and feedback are welcome! 🙌