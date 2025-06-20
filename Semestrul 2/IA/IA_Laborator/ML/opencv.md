# OpenCV Cheatsheet

## Installation and Setup

```python
# Install OpenCV
# pip install opencv-python opencv-contrib-python

# Basic imports
import cv2
import numpy as np
import matplotlib.pyplot as plt
```

## Image Loading, Saving, and Display

```python
# Read an image
img = cv2.imread('image.jpg')  # Default: BGR color image
img_grayscale = cv2.imread('image.jpg', cv2.IMREAD_GRAYSCALE)  # Grayscale
img_unchanged = cv2.imread('image.jpg', cv2.IMREAD_UNCHANGED)  # With alpha channel

# Check if image loaded successfully
if img is None:
    print("Error: Could not read image")

# Get image properties
height, width, channels = img.shape  # For color images
height, width = img_grayscale.shape  # For grayscale images

# Save an image
cv2.imwrite('output.jpg', img)
cv2.imwrite('output.png', img, [cv2.IMWRITE_PNG_COMPRESSION, 0])  # No compression

# Display an image (OpenCV window)
cv2.imshow('Image Window', img)
cv2.waitKey(0)  # Wait indefinitely until a key is pressed
cv2.destroyAllWindows()  # Close all windows

# Display with Matplotlib (RGB format)
plt.figure(figsize=(10, 8))
plt.imshow(cv2.cvtColor(img, cv2.COLOR_BGR2RGB))
plt.axis('off')
plt.show()
```

## Color Space Conversions

```python
# Convert BGR to RGB
rgb_img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

# Convert BGR to Grayscale
gray_img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

# Convert BGR to HSV
hsv_img = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)

# Convert BGR to LAB
lab_img = cv2.cvtColor(img, cv2.COLOR_BGR2LAB)

# Split and merge channels
b, g, r = cv2.split(img)  # Split BGR image into separate channels
merged_img = cv2.merge([b, g, r])  # Merge channels back into an image
```

## Basic Image Manipulations

```python
# Resize an image
resized_img = cv2.resize(img, (width, height))  # Specific dimensions
resized_img = cv2.resize(img, None, fx=0.5, fy=0.5)  # Scale by factor

# Rotate an image
rows, cols = img.shape[:2]
rotation_matrix = cv2.getRotationMatrix2D((cols/2, rows/2), 45, 1)  # center, angle, scale
rotated_img = cv2.warpAffine(img, rotation_matrix, (cols, rows))

# Flip an image
flipped_horizontal = cv2.flip(img, 1)  # Horizontal flip (1)
flipped_vertical = cv2.flip(img, 0)    # Vertical flip (0)
flipped_both = cv2.flip(img, -1)       # Both horizontal and vertical (-1)

# Crop an image (using NumPy slicing)
cropped_img = img[y:y+h, x:x+w]

# Image padding/borders
padded_img = cv2.copyMakeBorder(
    img, top, bottom, left, right, 
    cv2.BORDER_CONSTANT, value=color)  # Constant colored border
padded_img = cv2.copyMakeBorder(
    img, top, bottom, left, right, 
    cv2.BORDER_REFLECT)  # Reflected border

# Image blending
blended_img = cv2.addWeighted(img1, 0.7, img2, 0.3, 0)  # img1*0.7 + img2*0.3
```

## Drawing on Images

```python
# Create a blank image
blank_img = np.zeros((height, width, 3), np.uint8)

# Draw a line
line_img = img.copy()
cv2.line(line_img, (0, 0), (width, height), (255, 0, 0), thickness=5)

# Draw a rectangle
rect_img = img.copy()
cv2.rectangle(rect_img, (x, y), (x+w, y+h), (0, 255, 0), thickness=2)
cv2.rectangle(rect_img, (x, y), (x+w, y+h), (0, 255, 0), thickness=-1)  # Filled rectangle

# Draw a circle
circle_img = img.copy()
cv2.circle(circle_img, (center_x, center_y), radius, (0, 0, 255), thickness=3)
cv2.circle(circle_img, (center_x, center_y), radius, (0, 0, 255), thickness=-1)  # Filled circle

# Draw an ellipse
ellipse_img = img.copy()
cv2.ellipse(ellipse_img, (center_x, center_y), (axis_x, axis_y), angle, 
            start_angle, end_angle, (255, 0, 255), thickness=2)

# Draw a polygon
polygon_img = img.copy()
pts = np.array([[x1, y1], [x2, y2], [x3, y3], ...], np.int32)
pts = pts.reshape((-1, 1, 2))
cv2.polylines(polygon_img, [pts], isClosed=True, color=(0, 255, 255), thickness=2)

# Add text to an image
text_img = img.copy()
cv2.putText(text_img, 'Hello OpenCV', (x, y), cv2.FONT_HERSHEY_SIMPLEX,
            fontScale=1, color=(255, 255, 0), thickness=2, lineType=cv2.LINE_AA)
```

## Image Filtering and Transformations

```python
# Blur / Smoothing
blur_img = cv2.blur(img, (5, 5))  # Average blur
gaussian_blur_img = cv2.GaussianBlur(img, (5, 5), 0)  # Gaussian blur
median_blur_img = cv2.medianBlur(img, 5)  # Median blur (good for salt-and-pepper noise)
bilateral_filter_img = cv2.bilateralFilter(img, 9, 75, 75)  # Edge-preserving blur

# Morphological operations (on binary or grayscale images)
kernel = np.ones((5, 5), np.uint8)
erosion = cv2.erode(img, kernel, iterations=1)
dilation = cv2.dilate(img, kernel, iterations=1)
opening = cv2.morphologyEx(img, cv2.MORPH_OPEN, kernel)  # Erosion followed by dilation
closing = cv2.morphologyEx(img, cv2.MORPH_CLOSE, kernel)  # Dilation followed by erosion

# Image gradients / Edge detection
laplacian = cv2.Laplacian(gray_img, cv2.CV_64F)
sobelx = cv2.Sobel(gray_img, cv2.CV_64F, 1, 0, ksize=5)
sobely = cv2.Sobel(gray_img, cv2.CV_64F, 0, 1, ksize=5)
canny_edges = cv2.Canny(gray_img, 100, 200)  # Canny edge detector

# Thresholding
_, binary_thresh = cv2.threshold(gray_img, 127, 255, cv2.THRESH_BINARY)
_, binary_inv_thresh = cv2.threshold(gray_img, 127, 255, cv2.THRESH_BINARY_INV)
_, trunc_thresh = cv2.threshold(gray_img, 127, 255, cv2.THRESH_TRUNC)
_, tozero_thresh = cv2.threshold(gray_img, 127, 255, cv2.THRESH_TOZERO)
adaptive_thresh = cv2.adaptiveThreshold(
    gray_img, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY, 11, 2)

# Perspective transformation
src_pts = np.float32([[src_x1, src_y1], [src_x2, src_y2], [src_x3, src_y3], [src_x4, src_y4]])
dst_pts = np.float32([[dst_x1, dst_y1], [dst_x2, dst_y2], [dst_x3, dst_y3], [dst_x4, dst_y4]])
perspective_matrix = cv2.getPerspectiveTransform(src_pts, dst_pts)
warped_img = cv2.warpPerspective(img, perspective_matrix, (width, height))
```

## Feature Detection and Description

```python
# Harris Corner Detection
gray_img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
gray_float = np.float32(gray_img)
harris_corners = cv2.cornerHarris(gray_float, blockSize=2, ksize=3, k=0.04)
harris_corners = cv2.dilate(harris_corners, None)  # Dilate to mark the corners

# Shi-Tomasi Corner Detection
corners = cv2.goodFeaturesToTrack(gray_img, maxCorners=25, qualityLevel=0.01, minDistance=10)
corners = np.int0(corners)

# SIFT (Scale-Invariant Feature Transform)
sift = cv2.SIFT_create()
keypoints, descriptors = sift.detectAndCompute(gray_img, None)
sift_img = cv2.drawKeypoints(img, keypoints, None, flags=cv2.DRAW_MATCHES_FLAGS_DRAW_RICH_KEYPOINTS)

# ORB (Oriented FAST and Rotated BRIEF)
orb = cv2.ORB_create()
keypoints, descriptors = orb.detectAndCompute(gray_img, None)
orb_img = cv2.drawKeypoints(img, keypoints, None, flags=cv2.DRAW_MATCHES_FLAGS_DRAW_RICH_KEYPOINTS)

# Feature matching
bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True)
matches = bf.match(descriptors1, descriptors2)
matches = sorted(matches, key=lambda x: x.distance)
match_img = cv2.drawMatches(img1, keypoints1, img2, keypoints2, matches[:10], None, flags=2)
```

## Contour Detection and Analysis

```python
# Find contours
gray_img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
_, thresh = cv2.threshold(gray_img, 127, 255, cv2.THRESH_BINARY)
contours, hierarchy = cv2.findContours(thresh, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

# Draw contours
contour_img = img.copy()
cv2.drawContours(contour_img, contours, -1, (0, 255, 0), 3)  # -1 means all contours

# Contour properties
for cnt in contours:
    # Area
    area = cv2.contourArea(cnt)
    
    # Perimeter
    perimeter = cv2.arcLength(cnt, True)
    
    # Bounding rectangle
    x, y, w, h = cv2.boundingRect(cnt)
    cv2.rectangle(img, (x, y), (x+w, y+h), (0, 255, 0), 2)
    
    # Minimum enclosing circle
    (x, y), radius = cv2.minEnclosingCircle(cnt)
    center = (int(x), int(y))
    radius = int(radius)
    cv2.circle(img, center, radius, (0, 255, 0), 2)
    
    # Fit ellipse
    if len(cnt) >= 5:  # Need at least 5 points
        ellipse = cv2.fitEllipse(cnt)
        cv2.ellipse(img, ellipse, (0, 255, 0), 2)
    
    # Convex hull
    hull = cv2.convexHull(cnt)
    cv2.drawContours(img, [hull], 0, (0, 0, 255), 2)
```

## Video Capture and Processing

```python
# Capture from camera
cap = cv2.VideoCapture(0)  # 0 for default camera, 1 for second camera, etc.

# Capture from video file
cap = cv2.VideoCapture('video.mp4')

# Check if camera/video opened successfully
if not cap.isOpened():
    print("Error: Could not open camera/video")
    exit()

# Get video properties
frame_width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
frame_height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
fps = cap.get(cv2.CAP_PROP_FPS)
frame_count = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))  # For video files

# Create VideoWriter object for saving video
fourcc = cv2.VideoWriter_fourcc(*'XVID')  # XVID, MJPG, MP4V, etc.
out = cv2.VideoWriter('output.avi', fourcc, fps, (frame_width, frame_height))

# Read and process video frames
while True:
    ret, frame = cap.read()  # Read a frame
    
    if not ret:
        print("End of video or error reading frame")
        break
    
    # Process frame here
    processed_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)  # Example processing
    
    # Write processed frame to output video
    out.write(processed_frame)
    
    # Display frame
    cv2.imshow('Frame', processed_frame)
    
    # Break loop on 'q' key press
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release resources
cap.release()
out.release()
cv2.destroyAllWindows()
```

## Background Subtraction

```python
# Create background subtractor objects
mog2 = cv2.createBackgroundSubtractorMOG2()
knn = cv2.createBackgroundSubtractorKNN()

# Apply background subtraction
while True:
    ret, frame = cap.read()
    if not ret:
        break
    
    # Apply background subtraction
    fg_mask_mog2 = mog2.apply(frame)
    fg_mask_knn = knn.apply(frame)
    
    # Display results
    cv2.imshow('Original', frame)
    cv2.imshow('MOG2', fg_mask_mog2)
    cv2.imshow('KNN', fg_mask_knn)
    
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break
```

## Object Detection

```python
# Face detection using Haar Cascades
face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')
eye_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_eye.xml')

gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
faces = face_cascade.detectMultiScale(gray, 1.3, 5)

for (x, y, w, h) in faces:
    cv2.rectangle(img, (x, y), (x+w, y+h), (255, 0, 0), 2)
    roi_gray = gray[y:y+h, x:x+w]
    roi_color = img[y:y+h, x:x+w]
    
    eyes = eye_cascade.detectMultiScale(roi_gray)
    for (ex, ey, ew, eh) in eyes:
        cv2.rectangle(roi_color, (ex, ey), (ex+ew, ey+eh), (0, 255, 0), 2)
```

## Optical Flow

```python
# Lucas-Kanade Optical Flow
prev_gray = cv2.cvtColor(prev_frame, cv2.COLOR_BGR2GRAY)
current_gray = cv2.cvtColor(current_frame, cv2.COLOR_BGR2GRAY)

# Parameters for ShiTomasi corner detection
feature_params = dict(maxCorners=100, qualityLevel=0.3, minDistance=7, blockSize=7)
prev_points = cv2.goodFeaturesToTrack(prev_gray, **feature_params)

# Parameters for Lucas-Kanade optical flow
lk_params = dict(winSize=(15, 15), maxLevel=2, 
                 criteria=(cv2.TERM_CRITERIA_EPS | cv2.TERM_CRITERIA_COUNT, 10, 0.03))

# Calculate optical flow
next_points, status, error = cv2.calcOpticalFlowPyrLK(prev_gray, current_gray, 
                                                    prev_points, None, **lk_params)

# Select good points
good_prev = prev_points[status == 1]
good_next = next_points[status == 1]

# Draw the tracks
for i, (prev, next) in enumerate(zip(good_prev, good_next)):
    a, b = prev.ravel()
    c, d = next.ravel()
    flow_img = cv2.line(current_frame.copy(), (int(a), int(b)), (int(c), int(d)), (0, 255, 0), 2)
    flow_img = cv2.circle(flow_img, (int(c), int(d)), 5, (0, 255, 0), -1)
```

## Histogram Analysis

```python
# Calculate histogram for grayscale image
hist = cv2.calcHist([gray_img], [0], None, [256], [0, 256])

# Calculate histogram for color image
color = ('b', 'g', 'r')
for i, col in enumerate(color):
    hist = cv2.calcHist([img], [i], None, [256], [0, 256])
    plt.plot(hist, color=col)
    plt.xlim([0, 256])

# Histogram equalization (improves contrast)
eq_img = cv2.equalizeHist(gray_img)

# CLAHE (Contrast Limited Adaptive Histogram Equalization)
clahe = cv2.createCLAHE(clipLimit=2.0, tileGridSize=(8, 8))
clahe_img = clahe.apply(gray_img)
```

## Miscellaneous Utilities

```python
# Show all available OpenCV build information
print(cv2.getBuildInformation())

# Show OpenCV version
print(cv2.__version__)

# Wait for a specific key press
key = cv2.waitKey(0)  # 0 means wait indefinitely
if key == 27:  # ESC key
    cv2.destroyAllWindows()
elif key == ord('s'):  # 's' key
    cv2.imwrite('saved.jpg', img)

# Track elapsed time
e1 = cv2.getTickCount()
# your code here
e2 = cv2.getTickCount()
time_seconds = (e2 - e1) / cv2.getTickFrequency()
print(f"Time taken: {time_seconds} seconds")

# Create a trackbar
def nothing(x):
    pass

cv2.namedWindow('Trackbar Window')
cv2.createTrackbar('Threshold', 'Trackbar Window', 0, 255, nothing)

while True:
    threshold_value = cv2.getTrackbarPos('Threshold', 'Trackbar Window')
    _, thresh_img = cv2.threshold(gray_img, threshold_value, 255, cv2.THRESH_BINARY)
    cv2.imshow('Thresholded Image', thresh_img)
    
    if cv2.waitKey(1) & 0xFF == 27:  # ESC key
        break
```

## Tips & Best Practices

1. **Memory Management**: Always release resources (images, video captures) when done
   ```python
   cap.release()
   cv2.destroyAllWindows()
   ```

2. **Error Handling**: Check if images/videos loaded successfully
   ```python
   if img is None:
       print("Error: Could not read image")
   
   if not cap.isOpened():
       print("Error: Could not open video/camera")
   ```

3. **Performance Tips**:
   - Use NumPy operations when possible (faster than loops)
   - Consider downscaling large images before processing
   - Use cv2.UMat for GPU acceleration where available

4. **Color Handling**:
   - Remember OpenCV uses BGR order, not RGB
   - Convert to appropriate color space for specific tasks:
     - Grayscale for edge detection, thresholding
     - HSV for color-based segmentation
     - LAB for lighting invariance

5. **Debugging**:
   - Use cv2.imshow() at intermediate steps to visualize results
   - Save intermediate results with cv2.imwrite() for documentation
   - Print shape and data type of images to verify they are as expected

6. **File Paths**:
   - Use absolute paths if having issues with relative paths
   - Handle file paths properly for cross-platform compatibility:
     ```python
     import os
     image_path = os.path.join('folder', 'image.jpg')
     ```