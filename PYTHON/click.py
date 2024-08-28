import mediapipe as mp
import cv2
import pyautogui
import time

# lendo a camera e incializando a solução
cam = cv2.VideoCapture(0)
face_mesh = mp.solutions.face_mesh.FaceMesh(refine_landmarks=True)

# coletar o tamanho da tela
tela_w, tela_h = pyautogui.size()

# coletar especificações da camera
_, frame = cam.read()
frame_h, frame_w, _ = frame.shape

pyautogui.moveTo(0, 0)
# loop principal
while True:
    _, img = cam.read()
    img = cv2.flip(img, 1)
    rgb_img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

    results = face_mesh.process(rgb_img)
    landmark_points = results.multi_face_landmarks

    landmark_points
    landmarks = landmark_points[0].landmark

    iris_and_mouth = [landmarks[145], landmarks[159], landmarks[13], landmarks[14], landmarks[468]]

    distancia_da_boca = iris_and_mouth[-2].y - iris_and_mouth[-3].y

    distancia_da_iris = iris_and_mouth[0].y - iris_and_mouth[1].y
    print(distancia_da_iris)

    if distancia_da_iris < 0.008:
                pyautogui.click()
                pyautogui.sleep(1)
    else:
        pass

    # Esperando a letra q
    if cv2.waitKey(20) & 0xFF == ord('q'):
        break