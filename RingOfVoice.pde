//参考サイト
//http://r-dimension.xsrv.jp/classes_j/minim/
//https://n-e-r-v-o-u-s.com/tools/obj/

import nervoussystem.obj.*;
import ddf.minim.*; 

Minim minim;
AudioInput in;

int r = 200;
PVector [] point;
boolean recordable, save;

int button_x, button_y;
int button_size = 50;


void setup() {
  size(800, 800, P3D);
  minim = new Minim(this); 
  in = minim.getLineIn(Minim.STEREO, 512);

  button_x = width -100 ;
  button_y = height - 100;

  point = new PVector[360];
  for (int i = 0; i < point.length; i++)
    point[i] = new PVector(r*cos(radians(i)), r*sin(radians(i)), radians(i));



  frameRate(30);
  smooth();
}

void draw() {
  background(-1);

  //音を取得
  if (recordable) {
    point = new PVector[in.bufferSize()];

    for (int i = 0; i < in.bufferSize(); i++) {
      float wave_height, length, angle;

      wave_height = in.left.get(i) + in.right.get(i);
      length = wave_height*r / 4 + r;
      angle = map(i, 0, in.bufferSize(), 0, TWO_PI);

      point[i] = new PVector(length*cos(angle), length*sin(angle), angle);
    }
  }

  //記録はじめ
  if (!recordable && save)  beginRecord("nervoussystem.obj.OBJExport", "obj/filename.obj");


  pushMatrix();
  translate(width, height);
  noStroke();
  mold(point, 50, 50);//3Dオブジェクトを描画
  popMatrix();

  //記録終わり
  if (!recordable && save) {
    endRecord();
    save = false;
    println("save it!");
  }

  record_buttuon(button_x, button_y);
}

void mousePressed() {
  if (record_range(mouseX, mouseY)) {
    recordable = !recordable;
    return;
  }
}


void keyPressed() {
  if (key == 's')save = true;
}