# Modular Yoga Sessions

A guided yoga workout app built with Flutter that uses a JSON file to control session flow, audio playback, and image swapping.
> 🚧 **Note:** This project is still in development. Features and UI may change as the app evolves.
## Features
- 🧘 **JSON-Driven Sessions** – Easily define yoga poses, sequence order, and durations in a single JSON file.  
- 🎥 **Live Video & Audio Player** – Plays synchronized guidance videos and audio cues for each pose.  
- 🖼 **Dynamic Image Swapping** – Pose images change automatically according to the JSON instructions.  
- 🔄 **Looping Poses** – Repeat specific poses or flows as defined in the JSON structure.  
- 🎨 **Smooth UI** – Clean design for a calm, distraction-free workout experience.

## How it Works
1. The app loads a JSON file describing your yoga session.  
2. Each segment includes:
   - Pose name & duration
   - Associated audio or video file
   - Image to display during the pose  
3. The app follows the sequence, swapping media and looping poses as needed.  

## Tech Stack
- **Flutter**
- **JSON Parsing**
- **Video & Audio Player**
- **State Management**
