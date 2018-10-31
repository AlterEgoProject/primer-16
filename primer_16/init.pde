// 変数を初期化
void initAll() {
  initSensor();
  initNeuron();
  initConnect();
  initWeight();
  initInput();
  initFiring();
}

void initSensor() {
  float unitX = 0.8*width/(sensorN);
  float plusX = 0.1*width+unitX/2.;
  for (int i=0;i<sensorN;i++){ neurons[i] = new Neuron(unitX*i+plusX,0.2*height); }
}

void initNeuron() {
  for (int i=0;i<neuronN;i++){ 
    float theta = PI*(i+0.5)/neuronN;
    float circleX = width * (0.4 * (cos(theta) + 1) + 0.1);
    float circleY = 0.4 * height * (sin(theta) + 1);;
    neurons[i+neuronI] = new Neuron(circleX,circleY);
  }
}

void initConnect() {
  if(BIPOLAR) {
    // 双方向
    for (int i=0;i<cellN;i++){
      for (int j=i+1;j<cellN;j++){
        boolean is = _isEdge(i,j);
        isConnect[i][j] = is;
        isConnect[j][i] = is;
    } }
  } else {
    // 単方向
    for (int i=0;i<cellN;i++){
      for (int j=0;j<cellN;j++){
        boolean is = _isEdge(i,j);
        isConnect[i][j] = is;
    } }
  }
}
// ニューロンが結合される条件
boolean _isEdge(int from, int to) {
  if (from==to) return false; // 異なるセル
  if (from<sensorN && to<sensorN) return false; // センサー同士にならない
  if (r.nextFloat()>EDGE_RATE) return false; // EDGE_RATE の割合で連結 
  return true;
}

void initWeight() {
  if(BIPOLAR) {
    // 双方向
    for (int i=0;i<cellN;i++){
      for (int j=i+1;j<cellN;j++){
        float v = (r.nextFloat()*2-1)/2; // -1.~1.の乱数
        if(isConnect[i][j]) edgeWeight[i][j] = v;
        if(isConnect[j][i]) edgeWeight[j][i] = v;
    } }
  } else {
    //単方向
    for (int i=0;i<cellN;i++){
      for (int j=0;j<cellN;j++){
        float v = r.nextFloat()*2-1; // -1.~1.の乱数
        if(isConnect[i][j]) edgeWeight[i][j] = v;
    } }
  }
}

void initInput() {
  for (int from=0;from<cellN;from++){
    for (int to=0;to<cellN;to++){
        edgeInput[from][to] = 0;
  } }  
}
void initFiring() { 
  for (int i=0;i<cellN;i++) wasFiring[i] = neurons[i].getFiring();
}
