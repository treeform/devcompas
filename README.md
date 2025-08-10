# Dev Compass

A programming philosophy quiz that maps your coding preferences on a political compass-style chart with two key dimensions: **Abstract Style ↔ Concrete Style** and **Easy for Humans ↕ Easy for Computers**.

## 🧭 What is Dev Compass?

Dev Compass helps developers understand their programming philosophy by answering 20 carefully crafted questions about coding preferences, design choices, and development approaches. Your answers are plotted on a compass that reveals which quadrant best describes your programming style.

## 📊 The Two Axes

### Horizontal Axis: Abstract ↔ Concrete Style
- **Abstract Style**: Prefers high-level abstractions, functional programming, elegant mathematical formulations, and code that hides implementation details
- **Concrete Style**: Values explicit, step-by-step solutions, direct control, clear variable names, and code that shows exactly what's happening

### Vertical Axis: Easy for Humans ↕ Easy for Computers  
- **Human-Friendly**: Prioritizes readability, maintainability, intuitive APIs, comprehensive documentation, and code that any developer can understand
- **Computer-Friendly**: Focuses on performance, efficiency, optimal algorithms, minimal dependencies, and code that machines can execute optimally

## 🎯 Four Programming Philosophies

Based on your answers, you'll fall into one of four quadrants:

1. **Abstract & Human-Friendly**: Elegant, high-level solutions that are intuitive and accessible. Likely favors functional programming and code that reads like prose.

2. **Abstract & Computer-Friendly**: Mathematical elegance and optimal solutions. Enjoys powerful type systems, formal methods, and compiler optimizations.

3. **Concrete & Human-Friendly**: Values clarity and directness. Prefers explicit solutions that are easy to understand and debug, even if verbose.

4. **Concrete & Computer-Friendly**: Focuses on efficiency and performance. Likes working close to the metal with direct control over system resources.

## 🚀 Features

- **20 Thoughtful Questions** covering topics like:
  - Code abstractions and variable naming
  - API design and error handling  
  - Testing strategies and debugging approaches
  - Performance optimization and architecture
  - Configuration management and dependencies

- **Compass** that visualizes your position with:
  - Clean axis labels showing the spectrum
  - Your exact position plotted as a dot
  - Responsive design that works on all devices

- **Personalized Results** including:
  - Detailed description of your programming philosophy
  - Numerical scores for both dimensions
  - Option to retake the quiz and compare results

- **Tufte-Inspired Design** with:
  - Clean, minimal typography
  - Readable serif fonts
  - Subtle colors and elegant spacing
  - Print-friendly styling

## 🛠 Technical Implementation

- **Frontend**: Written in [Nim](https://nim-lang.org/) and compiled to JavaScript
- **No Backend**: Fully client-side single-page application
- **No Dependencies**: Self-contained with embedded question data
- **GitHub Pages Ready**: Automated deployment workflow included

## 📁 Project Structure

```
devcompas/
├── index.html          # Main HTML structure
├── style.css           # Tufte-inspired styling
├── main.nim           # Nim source code (compiles to main.js)
├── main.js            # Compiled JavaScript (auto-generated)
├── questions.json     # 20 quiz questions with scoring
└── .github/workflows/
    └── deploy.yml     # GitHub Pages deployment
```

## 🔧 Development

### Prerequisites
- [Nim](https://nim-lang.org/) compiler (version 2.2.4+)

### Building
```bash
# Compile Nim to JavaScript
nim js -d:release main.nim
```

### Local Development
Simply open `index.html` in your browser - no server required!

### Deployment
Push to GitHub and the included workflow will automatically build and deploy to GitHub Pages.

## 🎨 Design Philosophy

The design follows Edward Tufte's principles of information design:
- **Clarity**: Clean typography and minimal visual clutter
- **Precision**: Accurate data visualization with the SVG compass  
- **Efficiency**: Fast loading with no external dependencies
- **Beauty**: Elegant proportions and subtle styling

## 🤝 Contributing

This project is inspired by the political compass concept but adapted for programming philosophies. Feel free to:
- Suggest new questions that better capture programming preferences
- Improve the scoring algorithm for more accurate positioning
- Enhance the visual design while maintaining the minimal aesthetic
- Add new features like result sharing or historical tracking

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

*Discover your programming philosophy and see where you fall on the developer spectrum!*

