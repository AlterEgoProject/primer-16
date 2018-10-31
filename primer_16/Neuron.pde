// ニューロンクラス
class Neuron {
  
  float x,y; // 描画する座標
  float potential; // ニューロンの電位
  float shreshold; // ニューロンの閾値
  boolean firing; // 発火しているか
  
  Neuron(float x, float y){
    this.x = x;
    this.y = y;
    potential = 0;
    shreshold = 0.5;
    firing = false;
  }
  // 電位を加える
  void addPotential(float v) {
    potential += v;
  }
  // 発火判定。その後電位をリセット
  void fire() {
    // 前回発火していれば今回は発火しない
    if(firing) {
      firing = false;
    } else {
      firing = potential>shreshold; // 電位が閾値を超えているか
    }
    potential = 0; // 減衰でもいいかも
  }
  
  boolean getFiring() { return firing; }
}
