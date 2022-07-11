import cv2
import mediapipe as mp
import imutils

mp_face_detection = mp.solutions.face_detection
mp_drawing = mp.solutions.drawing_utils
cap = cv2.VideoCapture(0, cv2.CAP_DSHOW)
#cap = cv2.VideoCapture("video.mp4")
with mp_face_detection.FaceDetection(
    min_detection_confidence=0.5) as face_detection:
    while True:
        ret, frame = cap.read()
        if ret == False:
            break
        frame = imutils.resize(frame, width=720)
        frame = cv2.flip(frame, 1)
        frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)        
        results = face_detection.process(frame_rgb)
        if results.detections is not None:
            for detection in results.detections:
                mp_drawing.draw_detection(frame, detection,
                    mp_drawing.DrawingSpec(color=(0, 255, 255), circle_radius=2),
                    mp_drawing.DrawingSpec(color=(255, 0, 255)))
        cv2.imshow("Frame", frame)
        k = cv2.waitKey(1) & 0xFF
        if k == 27:
            break
cap.release()
cv2.destroyAllWindows()