class RandomGen{
  float xPos;
  float yPos; //declarations for location
  boolean walkConstrain;
  boolean terrain;
  boolean stroke;
  boolean start;
  PVector position;
  HashMap<PVector, Integer> nodes;
  int colorInt;
  color myColor;
  int iterCount;
  int stepSize;
  float stepScale;
  float combinedMove;
  int random;
  int randomSeed;
  
  
  RandomGen(){
   
    xPos = width/2 + 200; //definitions for location
    yPos = height/2;
    walkConstrain = false;
    position = new PVector(xPos, yPos);
    nodes = new HashMap();
    start = true;
  }
  
  void display(){
  
    
  }
  //////////////////////////////NONE OF THIS CODE USED FOR PROJECT2
  
  void move() {
    
      int random = int(random(4));
    
      if (random == 0) {yPos++;} 
      else if (random == 1) {yPos--;;} 
      else if (random == 2) {xPos--;}  //movements
      else if (random == 3) {xPos++;}
      
      
      if(walkConstrain){
          xPos = constrain(xPos, 200, width-1);
          yPos = constrain(yPos, 0, height-1); //can't go past the borders
      }
      
      position.set(xPos,yPos);
      if(!nodes.containsKey(position)){
        nodes.put(position, 1);
      }
      else{nodes.put(position, (nodes.get(position)+1));}

      
    }
}
 //<>// //<>// //<>// //<>//
