//vector：描いた点の集合
//thick：線の厚さ
//breadth：線の幅

void mold(PVector[] vector, int thick, int bredth) {

  pushMatrix();
  translate(-width/2, -height/2, 0);

  //正面（緑）
  fill(0, 255, 0);

  beginShape(TRIANGLE_STRIP);

  for (int i=0; i<=vector.length; i++) {
    float angle = vector[i % vector.length].z;

    vertex(vector[i % vector.length].x, vector[i % vector.length].y, 0);
    vertex(bredth * cos(angle)+vector[i % vector.length].x, bredth * sin(angle)+vector[i % vector.length].y, 0);
  }

  endShape();


  //後ろの面（青）
  fill(0, 0, 255);
  beginShape(TRIANGLE_STRIP);

  for (int i=0; i<=vector.length; i++) {
    float angle = vector[i % vector.length].z;

    vertex(vector[i % vector.length].x, vector[i % vector.length].y, thick);
    vertex(bredth * cos(angle)+vector[i % vector.length].x, bredth * sin(angle)+vector[i % vector.length].y, thick);
  }
  endShape();


  //上の面（赤）
  fill(255, 0, 0);

  beginShape(TRIANGLE_STRIP);

  for (int i=0; i<=vector.length; i++) {


    vertex(vector[i % vector.length].x, vector[i % vector.length].y, 0);
    vertex(vector[i % vector.length].x, vector[i % vector.length].y, thick);
  }

  endShape();


  //下の面（黄色）
  fill(255, 255, 0);

  beginShape(TRIANGLE_STRIP);

  for (int i=0; i<=vector.length; i++) {

    float angle = vector[i % vector.length].z;

    vertex(bredth * cos(angle)+vector[i % vector.length].x, bredth * sin(angle)+vector[i % vector.length].y, 0);
    vertex(bredth * cos(angle)+vector[i % vector.length].x, bredth * sin(angle)+vector[i % vector.length].y, thick);
  }

  endShape();

  popMatrix();
}