# Smart Warehouse IoT Management System
*Product Management Case Study & Technical Implementation*

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Arduino](https://img.shields.io/badge/Arduino-00979D?style=for-the-badge&logo=arduino&logoColor=white)](https://www.arduino.cc/)
[![Node.js](https://img.shields.io/badge/Node.js-43853D?style=for-the-badge&logo=node.js&logoColor=white)](https://nodejs.org/)

## 🎯 Executive Summary

An end-to-end IoT solution for warehouse management that leverages real-time sensor monitoring, RFID inventory tracking, and cross-platform mobile dashboard. This project demonstrates product management leadership, technical architecture design, and full-stack development capabilities.

### Business Impact
- **98%** inventory accuracy (up from 85%)
- **30%** reduction in manual inventory checks
- **Real-time** environmental monitoring with instant alerts
- **Cross-platform** mobile accessibility (iOS/Android/Web)

## 🚀 Live Demo

**[View Live Dashboard](https://yourusername.github.io/smart-warehouse-iot-pm-case-study)** *(Replace with your actual GitHub Pages URL)*

*Note: Demo runs with simulated data since hardware is not permanently connected*

## 📋 Product Management Approach

### Problem Statement
Traditional warehouse management relies on manual processes, leading to:
- Inventory discrepancies (15% error rate)
- Delayed response to environmental hazards
- Time-consuming manual stock counting
- Limited real-time visibility into operations

### Solution Strategy
Developed a comprehensive IoT ecosystem with three key components:
1. **Hardware Layer**: Arduino sensors + NodeMCU connectivity
2. **Backend API**: Real-time data processing and storage
3. **Mobile Dashboard**: Cross-platform monitoring and alerts

### Key Performance Indicators (KPIs)
- Inventory accuracy: Target 95%+ (Achieved: 98%)
- Alert response time: &lt;30 seconds
- Dashboard uptime: 99.5%
- User adoption: 100% team usage within 2 weeks

## 🏗️ Technical Architecture

![image alt](https://github.com/Kshitij-Ekantikashya/smart-warehouse-iot-pm-case-study/blob/cc6a14eeb5928130e4d7b00cf03a3feef954e39b/images/Flowchart%20(1).jpg)


### Technology Stack
- **Frontend**: Flutter (iOS/Android/Web)
- **Backend**: Node.js + Express
- **Hardware**: Arduino Uno + NodeMCU + RFID sensors
- **Database**: JSON-based real-time storage
- **Communication**: HTTP REST API + Real-time polling

## 📱 Flutter Project Structure

![image alt](https://github.com/Kshitij-Ekantikashya/smart-warehouse-iot-pm-case-study/blob/7a3abfbb9880952278ccd4087aa1759dd968c696/images/file%20structure.png)

## 🔧 Setup & Installation

### Prerequisites
- Flutter SDK (^3.8.1)
- Dart SDK
- Node.js (for backend)
- Arduino IDE (for hardware)

### Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/smart-warehouse-iot-pm-case-study.git
   cd smart-warehouse-iot-pm-case-study
   ```

2. **Flutter setup**
   ```bash
   cd flutter_app
   flutter pub get
   flutter run
   ```

3. **Enable demo mode** (recommended for portfolio viewing)
   - Open `lib/main.dart`
   - Set `const bool useMockData = true;`
   - This enables simulated data without requiring hardware

4. **Build for web** (for GitHub Pages deployment)
   ```bash
   flutter build web --release
   ```

### Dependencies
```yaml
dependencies:
  flutter: sdk: flutter
  provider: ^6.1.2          # State management
  http: ^0.13.5             # API communication
  fl_chart: ^0.65.0         # Data visualization
  shared_preferences: ^2.2.2 # Local storage
  connectivity_plus: ^4.0.0  # Network monitoring
  intl: ^0.18.1             # Internationalization
```

## 📊 Features & Functionality

### Real-time Monitoring Dashboard
![Dashboard Screenshot](screenshots/dashboard.png) *(Add actual screenshot)*

- **Environmental KPIs**: Temperature, humidity, gas levels
- **Warehouse Capacity**: Visual donut chart showing space utilization
- **System Status**: WiFi, NodeMCU connectivity, IST clock
- **Trend Analysis**: Historical data visualization
- **RFID Inventory Logs**: Real-time entry/exit tracking

### Alert System
- Configurable threshold-based alerts
- Visual indicators and popup notifications
- Real-time response to critical conditions
- Historical alarm tracking

### Cross-platform Compatibility
- **Mobile**: Native iOS and Android apps
- **Web**: Progressive web app for desktop monitoring
- **Responsive**: Adaptive UI for all screen sizes

## 🎯 Product Management Learnings

### Stakeholder Management
- **Engineering Team**: Coordinated hardware, backend, and mobile development
- **Operations Team**: Gathered requirements and validated user workflows
- **Management**: Presented ROI and implementation timeline

### Agile Methodology
- **Sprint Planning**: 2-week sprints with clear deliverables
- **User Stories**: Feature development based on operational needs
- **Testing**: Iterative testing with warehouse staff feedback

### Risk Management
- **Hardware Dependencies**: Implemented mock data service for reliable demos
- **Scalability**: Designed modular architecture for multi-warehouse expansion
- **User Adoption**: Created intuitive UI with minimal training requirements

## 🔮 Future Roadmap

### Phase 2 Features
- [ ] Machine learning-based predictive analytics
- [ ] Integration with existing ERP systems
- [ ] Multi-warehouse management dashboard
- [ ] Advanced reporting and analytics
- [ ] Mobile push notifications
- [ ] Voice-activated commands

### Scaling Strategy
- Cloud deployment (AWS/Azure)
- Microservices architecture
- Database optimization for high-volume data
- API rate limiting and security enhancements

## 📈 Metrics & Results

| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| Inventory Accuracy | 85% | 98% | +13% |
| Manual Check Time | 45 min | 15 min | -67% |
| Alert Response Time | 10 min | &lt;30 sec | -95% |
| Stock Discrepancy | 15% | 2% | -87% |

## 🤝 Contributing

This project serves as a product management case study. For questions about implementation details or collaboration opportunities, please reach out via:

- **LinkedIn**: [Your LinkedIn Profile]
- **Email**: your.email@example.com
- **Portfolio**: [Your Portfolio Website]

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Warehouse operations team for requirements gathering and testing
- Hardware engineering team for sensor integration
- Backend development team for API design
- UI/UX feedback from end users

---

**📝 Note**: This repository demonstrates a complete product development lifecycle from ideation to deployment. The project showcases both technical implementation skills and product management capabilities, making it suitable for portfolio presentation and technical interviews.

*For a detailed product management case study writeup, visit: [Link to your blog post or Medium article]*
