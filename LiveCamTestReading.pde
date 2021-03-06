import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import processing.serial.*;

Capture video;
OpenCV opencv;
Serial myPort; // create Object from serial class

void setup() {
  size(640, 480);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_EYE);  
  String portName = Serial.list()[0]; // change the 0 to a 1 or a 2 etc. to match your port 
  myPort = new Serial(this, portName, 9600);

  video.start();
}

void draw() {
  scale(2);
  opencv.loadImage(video);

  image(video, 0, 0 );

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  println(faces.length);

  for (int i = 0; i < faces.length; i++) {
    println(faces[i].x + "," + faces[i].y);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    myPort.write(faces[i].x + faces[i].y);
  }
}

void captureEvent(Capture c) {
  c.read();
}
