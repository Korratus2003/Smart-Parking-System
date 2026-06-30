# Zintegrowany system smart parkingu z rozpoznawaniem tablic rejestracyjnych

Zintegrowany, kompleksowy system Smart Parking wyposażony w funkcję automatycznego rozpoznawania tablic rejestracyjnych (ALPR) oraz sterowanie oparte na architekturze IoT. Projekt stanowi wydajną i niskobudżetową alternatywę dla zamkniętych systemów parkingowych klasy Enterprise, wykorzystując ogólnodostępne komponenty rynkowe (COTS).

## Kluczowe cechy

* Autonomiczna kontrola dostępu: Automatyczna detekcja pojazdów, weryfikacja uprawnień (biała lista) oraz sterowanie szlabanem.
* Rozpoznawanie tablic (ALPR): Potok wizyjny oparty na głębokich sieciach neuronowych YOLO (detekcja tablicy) oraz LPRNet (rozpoznawanie ciągu znaków w trybie bezsegmentacyjnym).
* Adaptacyjny preprocessing obrazu: Zastosowanie algorytmu CLAHE w celu poprawy lokalnego kontrastu obrazu i eliminacji szumów oświetleniowych, co zapewnia wysoką skuteczność w trudnych warunkach nocnych oraz przy odblaskach reflektorów.
* Warstwa brzegowa IoT: Mikrokontroler ESP32 zarządzający czujnikami odległości (JSN-SR04T) jako wyzwalaczami sprzętowymi, serwomechanizmem szlabanu oraz symulujący działanie terminala płatniczego (czytnik NFC i protokół Pulse dla terminali klasy Nayax).
* Architektura scentralizowana: Serwer lokalny w środowisku Linux (Python) obsługuje wymagające obliczeniowo wnioskowanie sieci neuronowych i komunikuje się z urządzeniami ESP32 za pomocą protokołu MQTT (Eclipse Mosquitto) z mechanizmami QoS oraz Last Will and Testament (LWT).
* Relacyjna baza danych: PostgreSQL do przechowywania danych operatorów, białej listy pojazdów, stawek taryfowych oraz historii sesji parkingowych.

## Użyte technologie

* Wizja komputerowa i głębokie uczenie: Python, OpenCV, PyTorch, YOLO, LPRNet
* Baza danych: PostgreSQL
* Komunikacja i Broker MQTT: Eclipse Mosquitto
* Warstwa sprzętowa: ESP32, C++ (PlatformIO / Arduino IDE)
* Panel Administratora: FastAPI (Python), HTML, CSS, JavaScript

## Struktura katalogów

```text
├── docker/
│   ├── mosquitto/          # Konfiguracja i persystencja danych brokera MQTT
│   └── postgres/           # Skrypty inicjalizacyjne bazy danych
├── SRC/
│   ├── Barriers/           # Kod źródłowy ESP32 dla szlabanu i czujnika
│   ├── Nayax Terminal Simulator/ # Kod źródłowy ESP32 dla symulatora płatności NFC
│   └── Server/             # Serwer główny (Vision Engine, klienci MQTT, Panel Web)
├── docker-compose.yml      # Konfiguracja kontenerów Mosquitto i PostgreSQL
└── thesis.docx             # Dokumentacja projektu (Praca Inżynierska)
```

## Szybki start

### Wymagania wstępne
* Docker oraz Docker Compose
* Python 3.12+ (do uruchomienia serwera)
* PlatformIO (do wdrożenia kodu na ESP32)

### 1. Uruchomienie usług Mosquitto i PostgreSQL
Uruchom kontenery za pomocą Docker Compose z katalogu głównego:
```bash
docker compose up -d
```
Uwaga: Baza PostgreSQL jest wystawiona na porcie 5433, aby uniknąć konfliktów z domyślnie zainstalowanymi lokalnymi instancjami PostgreSQL na porcie 5432.

### 2. Konfiguracja serwera
1. Przejdź do folderu serwera:
   ```bash
   cd SRC/Server
   ```
2. Utwórz i aktywuj środowisko wirtualne:
   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   ```
3. Zainstaluj wymagane pakiety:
   ```bash
   pip install -r requirements.txt
   ```
4. Skopiuj i dostosuj plik zmiennych środowiskowych:
   ```bash
   cp .env.example .env
   ```
5. Uruchom główny skrypt serwera:
   ```bash
   python main.py
   ```
