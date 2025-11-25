import socket

NAO_IP = "192.168.23.53"
PORT = 9559


def send_command(command):
    """
    Sends a command to the Python 2.7 NAO service.
    Supported commands: 'connect', 'sit_down', 'stand_up'
    """
    try:
        print(f"[DEBUG] Sending command: {command}")
        client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        client.settimeout(3.0)  # 3 second timeout - service responds quickly
        client.connect(("localhost", 5000))
        print("[DEBUG] Connected to service")

        client.send(command.encode())
        print("[DEBUG] Command sent, waiting for response...")

        response = client.recv(1024).decode().strip()
        print(f"[DEBUG] Response: {response}")
        client.close()

        # Return the response string
        if response:
            return response
        return "OK"

    except socket.timeout:
        print("[ERROR] Timeout waiting for service response")
        print("[INFO] The service may be stuck trying to connect to the NAO robot")
        return None
    except ConnectionRefusedError:
        print("[ERROR] Service not running on port 5000")
        print("[INFO] Start with: ./hardware/nao/start_nao_service.sh")
        return None
    except Exception as e:
        print(f"[ERROR] Error sending command '{command}': {e}")
        return None
