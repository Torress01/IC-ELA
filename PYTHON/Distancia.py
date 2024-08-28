import cv2
import math

# Define the calculate_distance function
def calculate_distance(face_width, focal_length, actual_width):
    return (actual_width * focal_length) / face_width

# Load the Haar Cascade classifier for face detection
face_cascade = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')

# Open the webcam
cap = cv2.VideoCapture(0)

# Set the actual width of the face (in centimeters)
actual_width = 15.0  # You can adjust this value based on your specific setup and measurements

# Set the focal length (in pixels) of the camera
# To find the focal length, you can refer to camera calibration techniques
# or use a rough estimation based on the camera specifications
focal_length = 1000.0  # You need to adjust this value based on your camera's specifications

while True:
    # Read the frame from the webcam
    ret, frame = cap.read()
    frame = cv2.flip(frame, 1)
    # Convert the frame to grayscale
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # Detect faces in the grayscale frame
    faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30))

    # Process each detected face
    for (x, y, w, h) in faces:
        # Calculate the distance from the camera to the detected face
        distance = calculate_distance(w, focal_length, actual_width)

        # Display the distance on the frame
        cv2.putText(frame, f"Distancia: {distance:.2f} cm", (x, y - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 1)
        if distance <60 :
            print("Distance ok para realizar o eye tracking");
    # Display the result
    cv2.imshow('Medidor de distância', frame)

    # Exit the loop if the 'q' key is pressed
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release the webcam and close all windows
cap.release()
cv2.destroyAllWindows()