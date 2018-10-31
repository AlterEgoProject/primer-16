void drawAll() {
  drawCell();
  drawEdge();
}
// セルを描画
void drawCell() {
  stroke(255);
  strokeWeight(1);
  for (int i=0;i<cellN;i++){
    Neuron n = neurons[i];
    if(n.firing) {
      fill(255,0,0); // 発火していれば赤色
    } else {
      fill(255,255,255);
    }
    rect(n.x-10,n.y-10,20,20); // セルの形
  }
}
// ニューロンの結合を描画
void drawEdge() {
  if(BIPOLAR) {
    // 双方向
    for (int i=0;i<cellN;i++){
      for (int j=i+1;j<cellN;j++){
        if(isConnect[i][j]) {
          _edgeStyle(edgeWeight[i][j]);
          line(neurons[i].x,neurons[i].y,neurons[j].x,neurons[j].y);
        }
    } }
  } else {
     //単方向
    for (int i=0;i<cellN;i++){
      for (int j=0;j<cellN;j++){
        if(isConnect[i][j]) {
          _edgeStyle(edgeWeight[i][j]);
          line(neurons[i].x,neurons[i].y,neurons[j].x,neurons[j].y);
        }
    } }
  }
}
// 興奮性(正の値)は赤く、抑制性(負の値)は青く
void _edgeStyle(float w) {
  float weight = abs(w) * 3;
  strokeWeight(weight); // 絶対値が大きいほど太く
  float stdW = (w+1.)/2 * 255;
  stroke(stdW,100,255-stdW/255.*200); // いい感じのグラデーション?
}
