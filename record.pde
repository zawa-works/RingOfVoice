boolean record_range(int x, int y) {
  return button_x - r/2 < x && button_x + r/2 > x 
    && button_y - r/2 < y && button_y + r/2 > y;
}

void record_buttuon(int x, int y) {
  pushStyle();
  pushMatrix();

  translate(x, y);


  if (recordable) {
    rectMode(CENTER);
    stroke(0);
    fill(-1);
    rect(0, 0, 50, 50);
  } else {
    noStroke();
    fill(255, 0, 0);
    ellipse(0, 0, 50, 50);
  }

  popMatrix();
  popStyle();
}