import sys
import os
from pathlib import Path

from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine

# Add parent directory to path for imports
sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from gui.v5.backend import BrainwavesBackend, TabController


def main():
    """Main application entry point"""
    os.environ["QT_QUICK_CONTROLS_STYLE"] = "Fusion"
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Create our controllers
    tab_controller = TabController()
    print("TabController created")

    # Initialize backend before loading QML
    backend = BrainwavesBackend()
    engine.rootContext().setContextProperty("tabController", tab_controller)
    engine.rootContext().setContextProperty("backend", backend)
    engine.rootContext().setContextProperty("imageModel", [])  # Initialize empty model
    engine.rootContext().setContextProperty(
        "fileShufflerGui", backend
    )  # For file shuffler
    engine.rootContext().setContextProperty(
        "cameraController", backend.camera_controller
    )
    print("Controllers exposed to QML")

    # Load QML
    qml_file = Path(__file__).resolve().parent / "v5" / "main.qml"
    engine.load(str(qml_file))

    # Convert PDFs after engine load
    try:
        backend.convert_pdfs_to_images()
    except Exception as e:
        print(f"Error converting PDFs: {str(e)}")

    # Ensure image model updates correctly
    backend.imagesReady.connect(
        lambda images: engine.rootContext().setContextProperty("imageModel", images)
    )

    if not engine.rootObjects():
        print("Error: Failed to load QML file")
        return -1

    return app.exec()


if __name__ == "__main__":
    sys.exit(main())
