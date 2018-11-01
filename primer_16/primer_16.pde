import java.util.Random;

// パラメータ
float EDGE_RATE = 0.2; // ニューロンの結合割合
boolean BIPOLAR = true; // ニューロンが双方向かどうか

int neuronN = 20; // 脳神経の数
int sensorN = 20; // センサーの数

int cellN = sensorN + neuronN; // センサーを含めたニューロンの数
int neuronI = cellN - neuronN; // 脳神経のインデックス

Neuron[] neurons = new Neuron[cellN]; // センサーを含めたニューロンの配列

boolean[][] isConnect = new boolean[cellN][cellN]; // ニューロンが結合しているか
float[][] edgeWeight = new float[cellN][cellN]; // 結合の強さ
float[][] edgeInput = new float[cellN][cellN]; // 伝達される刺激の大きさ
boolean[] wasFiring = new boolean[cellN]; // 前回ニューロンが発火していたか

Random r = new Random(); // 乱数用

void setup() {
  size(640, 640);
  frameRate(6); // 更新頻度 (1秒にX回)
  background(0);
  initAll();
}

int count=0;
void draw() {
  background(0);
  drawAll();
  if(count==0) { testSensor(); }
  transNeuron();
  count++;
  if(count>5) count = 0; // X回に1度だけセンサーへ入力 (テスト)
}

// センサーに対してランダムな入力
void testSensor() {
  for (int i=0;i<sensorN;i++){
    neurons[i].addPotential(r.nextFloat());
  }
}
