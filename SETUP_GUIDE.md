# Avatar Project Setup Guide

**Version: v1.0.0** | [Changelog](CHANGELOG.md)

## Overview
This guide helps you set up and run the Avatar BCI project correctly with all dependencies and proper paths.

## Fixed Issues

### 1. Path Issues Fixed
- **BCI Client Import Path**: Fixed the import path from `'random-forest-prediction'` to `'ml/models/random-forest/tensorflow'`
- **All QML Files**: Migrated to modular structure in `gui/v5/`
- **Python Module Paths**: Verified all Python module imports for file-shuffler, file-unify-labels, and file-remove8channel (now in `ml/preprocessings/`)

### 2. Architecture Migration
- **GUI Entry Point**: Migrated from `GUI5.py` to `gui/main.py` and `app.py`
- **QML Structure**: Transitioned from monolithic root-level QML files to modular `gui/v5/` structure
- **Legacy Files**: Archived old root-level files to `legacy/v5-root-files/`

### 2. Dependencies Installed
- `matplotlib` - Required by the developer analytics module (`gui/v5/modules/developers/`)
- `requests` - Required by the BCI connection module
- `scikit-learn` - Required for machine learning models

## Prerequisites

### Hardware
- [OpenBCI Headset](https://shop.openbci.com/products/ultracortex-mark-iv) with [Cyton 16 Channel board](https://shop.openbci.com/products/cyton-daisy-biosensing-boards-16-channel)
- [DJI Tello Edu Drone](https://www.amazon.com/DJI-CP-TL-00000026-02-Tello-EDU/dp/B07TZG2NNT)
- NAO Robot (optional)

### Software
- Python 3.13 or higher
- macOS (tested), Linux, or Windows

## Installation

### 1. Clone or Fork the Repository
```bash
git clone https://github.com/3C-SCSU/Avatar.git
cd Avatar
```

### 2. Create Virtual Environment
```bash
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

### 3. Install Dependencies
```bash
pip install -r requirements.txt
pip install matplotlib requests scikit-learn
```

## Running the Application

### Option 1: Use the Run Script (Recommended)
```bash
./run_gui.sh
```

### Option 2: Using app.py (Recommended for Development)
```bash
source venv/bin/activate
python3 app.py
```

### Option 3: Manual Activation
```bash
source venv/bin/activate
python3 -m gui.main
```

> **Note**: Legacy entry point `GUI5.py` has been archived to `legacy/v5-root-files/`. Use the new modular entry points above.

## Project Structure

```
Avatar/
├── app.py                          # Main application entry point
├── gui/
│   ├── main.py                     # GUI main entry point
│   └── v5/
│       ├── main.qml                # Main QML UI file
│       ├── backend.py              # Backend controller
│       ├── layouts/                # Reusable layout components
│       │   ├── TwoColumnLayout.qml
│       │   ├── ThreeColumnLayout.qml
│       │   └── ...
│       └── modules/                # Feature modules
│           ├── brainwave/          # Brainwave processing
│           │   ├── view.qml        # Brainwave reading interface
│           │   ├── visualization-view.qml  # Data visualization
│           │   └── components/
│           ├── drone/              # Drone control
│           │   ├── view.qml        # Drone control interface
│           │   └── components/
│           ├── nao/                # NAO robot control
│           │   ├── view.qml        # NAO control interface
│           │   └── components/
│           ├── developers/         # Developer analytics
│           │   ├── view.qml        # Developer statistics
│           │   └── functions/
│           │       └── dev_charts.py
│           ├── file-shuffler/      # File shuffling utility
│           │   ├── view.qml
│           │   └── components/
│           └── transfer-data/      # Data transfer interface
│               ├── view.qml
│               └── components/
├── ml/                             # Machine Learning components
│   ├── models/                     # ML models
│   │   ├── random-forest/          # Random Forest models
│   │   │   ├── JAX/
│   │   │   ├── pytorch/
│   │   │   └── tensorflow/
│   │   │       └── client/
│   │   │           └── brainflow1.py   # BCI connection handler
│   │   └── deep-learning/          # Deep Learning models
│   │       ├── JAX/
│   │       ├── pytorch/
│   │       └── tensorflow/
│   ├── preprocessings/             # Data preprocessing tools
│   │   ├── file-shuffler/          # File shuffling utilities
│   │   │   └── run_file_shuffler.py
│   │   ├── file-unify-labels/      # Label unification
│   │   │   └── unifyTXT.py
│   │   └── file-remove8channel/    # 8-channel data removal
│   │       └── remove8channel.py
│   └── frameworks/                 # Framework-specific utilities
├── hardware/                       # Hardware integration
│   ├── nao/                        # NAO robot integration
│   │   ├── nao_connection.py
│   │   └── nao_service.py
│   ├── drone/                      # Drone integration
│   │   └── camera/
│   │       └── camera_controller.py
│   └── bci/                        # BCI integration
└── legacy/                         # Legacy/archived code
    ├── v5-root-files/              # Archived root-level GUI files
    │   ├── GUI5.py                 # [ARCHIVED] Legacy entry point
    │   ├── main.qml                # [ARCHIVED] Legacy main QML
    │   └── *.qml                   # [ARCHIVED] Legacy QML files
    ├── v5_standalone/              # Standalone v5 implementations
    └── v3/                         # Legacy v3 implementations

```

## Troubleshooting

### Import Errors
If you encounter module import errors:
```bash
source venv/bin/activate
pip install -r requirements.txt
pip install matplotlib requests scikit-learn
```

### QML Loading Errors
The application uses the modular QML structure in `gui/v5/`. Ensure:
- `gui/v5/main.qml` exists
- Module directories in `gui/v5/modules/` are properly structured
- Each module has a `view.qml` and `qmldir` file

If you encounter issues, check that legacy root-level QML files have been properly archived.

### Path Issues
The application expects to be run from the project root directory. Use one of:
- `python3 app.py`
- `python3 -m gui.main`
- `./run_gui.sh`

### BCI Connection Issues
If BCI connection fails, it will fall back to simulation mode. Check:
- OpenBCI headset is connected
- Serial port is correct (default: `/dev/cu.usbserial-D200PMA1`)
- Drivers are installed

### NAO Robot Connection Issues
If NAO connection fails:
- Ensure `nao_service.py` is running on port 5000
- Check NAO IP address in `hardware/nao/nao_connection.py`
- Verify network connectivity to the NAO robot

## Features

### Brainwave Reading
- Real-time brainwave data collection from OpenBCI headset
- Machine learning prediction (Random Forest, Deep Learning)
- PyTorch and TensorFlow framework support
- Synthetic data mode for testing

### Drone Control
- Manual control interface
- BCI-driven autopilot
- Live camera stream
- Flight logging

### NAO Robot Control
- Manual animation control
- Sit/stand commands
- Speech and movement choreography

### Developer Tools
- Git contribution statistics
- Commit tier visualization (Gold/Silver/Bronze)
- Ticket tracking by developer

## Development

### Running in Development Mode
```bash
source venv/bin/activate
python3 app.py
```

### Working with Modules
The modular structure allows independent development of features:

```bash
# Module structure
gui/v5/modules/<module-name>/
├── view.qml              # Main view
├── qmldir                # Module definition
├── components/           # Reusable components
│   ├── Component1.qml
│   └── Component2.qml
├── functions/            # Python backend functions (optional)
└── README.md             # Module documentation
```

### Legacy Code
Legacy GUI files have been archived to `legacy/v5-root-files/` and should not be used for new development. Refer to the modular structure in `gui/v5/` instead.

### Adding Dependencies
```bash
source venv/bin/activate
pip install <package_name>
pip freeze > requirements.txt
```

## Contributing
See [README.md](README.md) for contribution guidelines.

## License
MIT License - See [LICENSE](LICENSE) for details.

## Versioning

### Version Information
- **Current Version**: v1.0.0 (see [VERSION](VERSION) file)
- **Versioning Scheme**: [Semantic Versioning](https://semver.org/) (MAJOR.MINOR.PATCH)
- **Changelog**: See [CHANGELOG.md](CHANGELOG.md) for detailed version history

### Understanding Version Numbers
- **MAJOR**: Incompatible API changes or major feature overhauls
- **MINOR**: New functionality added in a backwards compatible manner
- **PATCH**: Backwards compatible bug fixes and small improvements

### Checking Your Version
```bash
cat VERSION
```

### Version Compatibility
- BCI Hardware: OpenBCI headsets with Cyton boards
- Python: 3.13 or higher required
- Dependencies: See [requirements.txt](requirements.txt) for exact versions

## Support
- Discord: https://discord.gg/mxbQ7HpPjq
- YouTube: https://www.youtube.com/@3CSCSU
- Email: 3c.scsu@gmail.com

