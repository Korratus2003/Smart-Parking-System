import os
import sys
from dotenv import load_dotenv

load_dotenv()

def main():
    print("Smart Parking System - Core Server starting...")
    db_host = os.getenv("DB_HOST", "localhost")
    mqtt_broker = os.getenv("MQTT_BROKER", "localhost")
    print(f"Database Host: {db_host}")
    print(f"MQTT Broker: {mqtt_broker}")

if __name__ == "__main__":
    main()
