import mediapipe as mp
import cv2
import pyautogui
import time

pyautogui.FAILSAFE = False  # desativa a função de desligar o uso do olhar
sensibilidade_do_modelo = 20

# lendo a camera e incializando a solução
cam = cv2.VideoCapture(0)
face_mesh = mp.solutions.face_mesh.FaceMesh(refine_landmarks=True)

# coletar o tamanho da tela
tela_w, tela_h = pyautogui.size()

# coletar especificações da camera
_, frame = cam.read()
frame_h, frame_w, _ = frame.shape


def calculate_distance(face_width, focal_length, actual_width):
    return (actual_width * focal_length) / face_width


# Load the Haar Cascade classifier for face detection
face_cascade = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')

actual_width = 15.0  # You can adjust this value based on your specific setup and measurements

focal_length = 1000.0  # You need to adjust this value based on your camera's specifications

pyautogui.moveTo(960, 540)
# loop principal
while True:
    _, img = cam.read()
    img = cv2.flip(img, 1)
    rgb_img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    # Detect faces in the grayscale frame
    faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30))

    # Process each detected face
    for (x, y, w, h) in faces:
        # Calculate the distance from the camera to the detected face
        distance = calculate_distance(w, focal_length, actual_width)

        # Display the distance on the frame
        cv2.putText(img, f"Distancia: {distance:.2f} cm", (x, y - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 1)
        if distance < 50:
            print("DISTANCIA IDEAL : 40 CM")
            print("Distancia boa para realizar o eye tracking!!!")
            print(f"Distancia {distance: .2f} cm ")
        else:
            print("!!!A distancia atual pode deixar o eye tracking menos preciso!!!")
            print("DISTANCIA IDEAL : 40 CM")
    # Display the result
    cv2.imshow('Medidor de distância', img)

    results = face_mesh.process(rgb_img)
    landmark_points = results.multi_face_landmarks

    if landmark_points:
        landmarks = landmark_points[0].landmark

        iris_and_mouth = [landmarks[374], landmarks[386], landmarks[13], landmarks[14], landmarks[468]]

        distancia_da_boca = iris_and_mouth[-2].y - iris_and_mouth[-3].y

        if distancia_da_boca > 0.076:
            pass
        else:
            # codigo do mouse
            # adaptar x,y para pixels
            x = (iris_and_mouth[4].x - 0.32)
            y = (iris_and_mouth[4].y - 0.40)
            x = int(x * frame_w) * sensibilidade_do_modelo
            y = int(y * frame_h) * sensibilidade_do_modelo
            # todo: colocar offset, olhar para um ponto e pegar a diferença
            pyautogui.moveTo(x, y)

            distancia_da_iris = iris_and_mouth[0].y - iris_and_mouth[1].y

            if distancia_da_iris < 0.01:
                pyautogui.click()
                pyautogui.sleep(1)
            else:
                pass

        for lm in iris_and_mouth:
            x = int(lm.x * frame_w)
            y = int(lm.y * frame_h)
            cv2.circle(img, (x, y), 4, (255, 255, 0))

    # Esperando a letra q
    if ord('q') == cv2.waitKey(20) & 0xFF:
        break

cam.release()
cv2.destroyAllWindows()

# Testei DragTo (Estava clicando sozinho)
# Testei colocar duração no movimento (Ficou menos preciso)
# Testei a sensibilidade 20 (OK)
# Testei a função pyautogui.move (nao deu certo)
#
