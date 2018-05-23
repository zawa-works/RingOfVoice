import ddf.minim.*;  //minimライブラリのインポート

Minim minim;  //Minim型変数であるminimの宣言
AudioInput in;  //マイク入力用の変数
int waveH = 100;  //波形の高さ

FloatList amplitudes = new FloatList();

boolean recordable = false;

void setup()
{
  size(1000, 200);

  minim = new Minim(this);  //初期化

  //バッファ（メモリ上のスペース。この場合は512要素のfloat型の配列）を確保し、マイク入力用の変数inを設定する。
  in = minim.getLineIn(Minim.STEREO, 512);
}

void draw()
{
  background(0);
  stroke(255);
  //波形を描く
  //left.get()とright.get()が返す値は-1から+1なので、見やすくするために、
  //waveH（初期値は100）を掛けている。

  translate(0, height/2);
  for (int i=0; i < amplitudes.size()-1; i++) {
    float x1 = map(i, 0, amplitudes.size(), 0, width);
    float x2 = map(i+1, 0, amplitudes.size(), 0, width);
    line(x1, 100 * amplitudes.get(i), x2, 100 * amplitudes.get(i+1));
  }

  if (!recordable) return;

  for (int i = 0; i < in.bufferSize()-1; i++) {
    float y = in.left.get(i) + in.right.get(i);
    amplitudes.append(y);
  }
}

void mousePressed() {
  if (!recordable) {
    recordable = true;
    return;
  }

  if (recordable) stop();
}



void stop()
{
  in.close();
  minim.stop();

  super.stop();
}