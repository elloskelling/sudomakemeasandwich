#!/usr/bin/env python3
# importing the module
import cv2
import sys

# function to display the coordinates of
# of the points clicked on the image
def click_event(event, x, y, flags, params):
  global topleft
  global botrite

  # checking for left mouse clicks
  if event == cv2.EVENT_LBUTTONDOWN:
    init()
    topleft = (x,y)

    cv2.circle(img,topleft,4,(50,50,255),2,)
    cv2.rectangle(img,topleft,botrite,(20,20,255),2)
    cv2.imshow('image', img)

  # checking for right mouse clicks 
  if event==cv2.EVENT_RBUTTONDOWN:
    init()
    botrite = (x,y)
    
    if botrite[0] >= topleft[0] and botrite[1] >= topleft[1]:
      cv2.rectangle(img,topleft,botrite,(20,20,255),2)
      cv2.circle(img,botrite,4,(50,50,255),2,)

      cv2.imshow('image', img)


def init():
  # reading the image
  global img
  global topleft
  global botrite
  img = cv2.imread(sys.argv[1], 1)
  # displaying the image
  cv2.namedWindow('image', cv2.WINDOW_GUI_NORMAL)
  cv2.imshow('image', img)


# driver function
if __name__=="__main__":

  init()
  topleft = (0,0)
  botrite = (img.shape[1],img.shape[0])

  # setting mouse handler for the image
  # and calling the click_event() function
  cv2.setMouseCallback('image', click_event)

  # wait for a key to be pressed to exit
  while (True):
    key = cv2.waitKey(0)
    # 27 is the esc key
    # 113 is the letter 'q'
    if key == 27:
      topleft = (0,0)
      botrite = (img.shape[1],img.shape[0])
      init()    
    if key == 13:
      break

  # close the window
  cv2.destroyAllWindows()
  print("x=%d:y=%d:w=%d:h=%d\n" % (topleft[0],topleft[1],botrite[0]-topleft[0]-1,botrite[1]-topleft[1]-1))
