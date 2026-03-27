# Inventory App
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## What is this?
- A school project developed over 6 weeks  
- A cross-platform app built with Flutter for managing inventory of spare parts across multiple storage locations  
- Aimed at small businesses or teams with a dynamic inventory  
- A work in progress!

---

## Goals
- **Showcase my Flutter skills**  

- **Speed**  
  Users should be able to quickly find the right item and immediately see where it is available.  
  Consuming or restocking an item should take just a few taps.  

- **Simplicity**  
  A clean UI where everything has a purpose.  
  Less frequently used features are moved away from the main view to make space for what matters most.  

- **Versatility**  
  The app should be flexible enough to be useful across different types of businesses.  

---

##  Features
- Team-based login with credentials  
- Create and manage shared storage locations  
- Add inventory items and manage stock across storages  
- Tag items (e.g., brand, category) for filtering and sorting  
- Upload images from gallery or camera  
- Available in English and Swedish  
- Light and dark theme support  

---

##  The technical stuff
- Built with **Flutter** using a feature-based UI structure
- Set up with **Very Good CLI**
- Uses **Bloc** for state management  
- Stream-driven architecture with an abstract remote layer (currently Firebase)  
- Abstract authentication layer (currently Firebase Auth)  
- Monorepo managed with **Melos**  
- Models implemented with **Freezed** (immutability, equality, `copyWith`)  
- Centralized error handling with app-specific exceptions  
- Currently ~50% test coverage  
- Custom Melos scripts (e.g., combined coverage reports)  

---

## Project Structure

### `/packages`
- Remote contracts and implementations  
- Repositories  
- Authentication services  
- Shared `app_ui` package (themes, widgets, typography)  
- `core_remote` for centralized error handling  
- Each package is self-contained with its own dependencies  

### `/lib`
- Feature-based UI (organized by screens)  
- UI data model that combines multiple inventory streams into a single stream for the UI  

---

## Future Improvements (if I find the time)
- Improve overall design (especially Storages and Sign-in screens)  
- Add general tags for more advanced filtering  
- Complete the Statistics section (data already tracked but not implemented in the UI)  
- Increase test coverage to at least 80%  
- Add map support for storage locations  
- Enable sharing part details via email/SMS  
- Barcode scanning would be cool!
- Support moving items between storages  

---

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
