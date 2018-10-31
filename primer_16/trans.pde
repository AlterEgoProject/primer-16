// ニューロンの伝達やシナプス強化のサイクル
void transNeuron() {
  sumPotential();
  checkFiring();
  reinforceWeight();
  initInput(); // edgeInput を初期化
  transInput();
  initFiring(); // wasFiring を更新
}
// 前回 edgeInput に加算した刺激を伝達する
void sumPotential() {
  for (int to=0;to<cellN;to++){
    float p = 0;
    for (int from=0;from<cellN;from++){ p += edgeInput[from][to]; } 
    neurons[to].addPotential(p);
  }
}
// 今回発火するかをチェック
void checkFiring() {
  for (int i=0;i<cellN;i++){
    neurons[i].fire();
  }
}
// 前回と今回で発火が連鎖した箇所の edgeWeight を強化 (絶対値が1に近づく)
void reinforceWeight() {
  for (int from=0;from<cellN;from++){
    if (wasFiring[from]) {
      for (int to=0;to<cellN;to++){
        if (isConnect[from][to] && neurons[to].firing) {
          edgeWeight[from][to] *= (1. + 0.1*(1/abs(edgeWeight[from][to])-1) );
          edgeWeight[to][from] *= (1. + 0.1*(1/abs(edgeWeight[to][from])-1) );
  } } } }
}
// 発火によって次回 potential に加算される edgeInput を算出
// 前回発火しているニューロンへは edgeInput を加算しない
void transInput() {
  for (int from=0;from<cellN;from++){
    if (neurons[from].firing) {
      for (int to=0;to<cellN;to++){
        if (!wasFiring[to] && isConnect[from][to]) {
          edgeInput[from][to] += edgeWeight[from][to];
   }  }  }  } 
}
