# FitNest

## Overview
FitNest will be a web-based application designed to create personalized workout plans for users based on their fitness levels, available equipment, and specific fitness goals. Users will input their preferences, and the tool will generate a weekly workout schedule with exercises, sets, and repetitions, along with images for proper execution.

## Installation
Clone the repository
```
https://github.com/dutyMax/FitNest.git
```

## Folder Structure 
1. FitNest2/:
  - Contains all the contents for the iOS app.
  - Built using Xcode.
2. src/:
- Contains the files for the backend API and BM25 algorithm.
- Built using Python with Flask.
3. data/:
- Contains the data files

## Running the Frontend (iOS App)
### Prerequisites
- Install Xcode on your macOS machine.
- Ensure you have the iOS simulator or a connected iOS device for testing.
### Steps to Run the App
1. Navigate to the FitNest2 folder:
```
cd FitNest2
```
2. Open the project in Xcode:
```
open FitNest2.xcodeproj
```
3. Select a simulator or connected device in Xcode.
4. Build and run the app by clicking the Run button (Cmd + R).

## Running the Backend API
### Prerequisites
- Install Python 3.8+.
- Install the required Python libraries:
  - Flask
  - Pandas
  - Numpy
### Install Dependencies
1. Navigate to the src folder:
```
cd src
```
2. Install dependencies:
```
pip install -r requirements.txt
```
### Steps to Run the API
1. Ensure you're inside the src directory:
```
cd src
```
2. Start the Flask API server:
```
python app.py
```
3. The server will run on http://localhost:5001.

## Using the Backend API
### Endpoint
- POST /recommendations
- Accepts a JSON payload with a query field to fetch workout recommendations.
### Example Request
Using curl:
```
curl -X POST http://localhost:5001/recommendations \
-H "Content-Type: application/json" \
-d '{"query": "abdominals bands"}'
```
