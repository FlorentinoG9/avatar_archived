#!/usr/bin/env python2.7

import socket
from naoqi import ALProxy

# NAO robot settings
NAO_IP = "192.168.23.53"
PORT = 9559

# Service settings
SERVICE_HOST = "localhost"
SERVICE_PORT = 5000


def connect_to_nao():
    """Try to connect to the NAO robot"""
    try:
        print("Attempting to connect to NAO at", NAO_IP, ":", PORT)
        # Test if NAO is reachable first (quick timeout)
        test_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        test_socket.settimeout(2.0)
        result = test_socket.connect_ex((NAO_IP, PORT))
        test_socket.close()

        if result != 0:
            print("NAO robot not reachable at", NAO_IP, ":", PORT)
            return False

        # If reachable, try to create proxy to verify connection
        ALProxy("ALBehaviorManager", NAO_IP, PORT)
        print("Successfully connected to NAO!")
        return True
    except Exception as e:
        print("Failed to connect to NAO:", str(e))
        return False


def nao_sit_down():
    # Behavior name
    behavior_name = "sitdown-b3bee7/Sit down"

    # Create proxy to ALBehaviorManager
    try:
        print("Creating proxy to NAO for sit_down command...")
        behavior_mng = ALProxy("ALBehaviorManager", NAO_IP, PORT)
    except Exception as e:
        print("Could not create proxy to ALBehaviorManager")
        print("Error:", e)
        print("NAO robot may not be available at", NAO_IP, ":", PORT)
        return False

    # Check if behavior is installed
    try:
        if behavior_mng.isBehaviorInstalled(behavior_name):
            if behavior_mng.isBehaviorRunning(behavior_name):
                print("Sit down behavior is already running.")
                return True
            else:
                print("Starting sit down behavior:", behavior_name)
                behavior_mng.startBehavior(behavior_name)
                return True
        else:
            print("Sit down behavior not found on robot.")
            return False
    except Exception as e:
        print("Error executing sit down behavior:", e)
        return False


def nao_stand_up():
    # Behavior name
    behavior_name = "standup-80f5e5/Stand up"

    # Create proxy to ALBehaviorManager
    try:
        print("Creating proxy to NAO for stand_up command...")
        behavior_mng = ALProxy("ALBehaviorManager", NAO_IP, PORT)
    except Exception as e:
        print("Could not create proxy to ALBehaviorManager")
        print("Error:", e)
        print("NAO robot may not be available at", NAO_IP, ":", PORT)
        return False

    # Check if behavior is installed
    try:
        if behavior_mng.isBehaviorInstalled(behavior_name):
            if behavior_mng.isBehaviorRunning(behavior_name):
                print("Stand up behavior is already running.")
                return True
            else:
                print("Starting stand up behavior:", behavior_name)
                behavior_mng.startBehavior(behavior_name)
                return True
        else:
            print("Stand up behavior not found on robot.")
            return False
    except Exception as e:
        print("Error executing stand up behavior:", e)
        return False


def handle_command(command):
    """
    Process a single command from the GUI.
    Returns True if successful, False otherwise.
    """
    if command == "connect":
        return connect_to_nao()
    elif command == "sit_down":
        return nao_sit_down()
    elif command == "stand_up":
        return nao_stand_up()
    else:
        print("Unknown command:", command)
        return False


def handle_client_connection(client, address):
    """
    Handle a single client connection and command.
    Returns True to continue running, False to shutdown.
    """
    try:
        print("Received connection from", address)
        data = client.recv(1024)

        # Decode if bytes (Python 3) or keep as string (Python 2.7)
        if isinstance(data, bytes):
            data = data.decode("utf-8")

        command = data.strip().lower()
        print("Received command:", command)

        # Process the command
        success = handle_command(command)

        # Send response back to GUI
        response = "SUCCESS" if success else "FAILED"
        print("Sending response:", response)

        # Ensure response is sent properly
        if isinstance(response, str):
            response = response.encode("utf-8")

        client.sendall(response)
        print("Response sent successfully")
        return True

    except Exception as e:
        print("Error processing command:", str(e))
        return True
    finally:
        try:
            client.close()
        except Exception:
            pass


def run_service():
    """
    Main service loop - continuously listens for and processes commands.
    This loop runs indefinitely until interrupted (Ctrl+C).
    """
    # Create a socket to listen for connection requests
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server.bind((SERVICE_HOST, SERVICE_PORT))
    server.listen(1)

    print("=" * 50)
    print("Service ready on", SERVICE_HOST, ":", SERVICE_PORT)
    print("Waiting for commands from GUI...")
    print("=" * 50)
    print("")

    # Main service loop - keeps running to handle multiple commands
    while True:
        try:
            # Wait for next GUI connection (blocking call)
            client, address = server.accept()

            # Handle the connection and get continue signal
            should_continue = handle_client_connection(client, address)

            if not should_continue:
                break

        except KeyboardInterrupt:
            print("\nShutting down service...")
            break
        except Exception as e:
            print("Unexpected error in service loop:", str(e))

    server.close()
    print("Service stopped.")


def main():
    print("=" * 50)
    print("Starting NAO Connection Service...")
    print("=" * 50)
    print("NAO Robot IP:", NAO_IP)
    print("NAO Robot Port:", PORT)
    print("")

    # Quick check if NAO is reachable
    print("Checking if NAO robot is available...")
    try:
        test_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        test_socket.settimeout(2.0)
        result = test_socket.connect_ex((NAO_IP, PORT))
        test_socket.close()

        if result == 0:
            print("✓ NAO robot is reachable at", NAO_IP, ":", PORT)
        else:
            print("✗ WARNING: NAO robot NOT reachable at", NAO_IP, ":", PORT)
            print(
                "  Service will start anyway. Commands will fail until robot is available."
            )
    except Exception as e:
        print("✗ WARNING: Cannot check NAO availability:", str(e))

    print("")

    # Start the service loop
    run_service()


if __name__ == "__main__":
    main()
