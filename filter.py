import cv2
import numpy as np

img = cv2.imread('img.jpg')
m, n, k = img.shape
mask = np.array([[0, -1, 0], [-1, 4, -1], [0, -1, 0]], dtype=int)
img_new = np.zeros([m, n, k])
for k in range(3):
    for i in range(1, m - 1):
        for j in range(1, n - 1):
            temp = img[i - 1, j - 1, k] * mask[0, 0] + img[i - 1, j, k] * mask[0, 1] + img[i - 1, j + 1, k] * mask[
                0, 2] + img[i, j - 1, k] * mask[1, 0] + img[i, j, k] * mask[1, 1] + img[i, j + 1, k] * mask[1, 2] + img[
                       i + 1, j - 1, k] * mask[2, 0] + img[i + 1, j, k] * mask[2, 1] + img[i + 1, j + 1, k] * mask[2, 2]
            if temp < 0:
                temp = 0
            img_new[i, j, k] = temp
cv2.imwrite('blurred.jpg', img_new)

# import cv2
# import numpy as np
# from matplotlib import pyplot as plt
# img = cv2.imread('img.jpg')
# dst = cv2.filter2D(img,-1,mask)
# cv2.imwrite('blurred2.jpg', dst) 
# print(dst[2],img_new[2])
