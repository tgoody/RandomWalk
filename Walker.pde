class RandomGen{
  int xPos;
  int yPos; //declarations for location
  boolean walkConstrain;
  boolean terrain;
  boolean stroke;
  PVector position;
  HashMap<PVector, Integer> nodes;
  int colorInt;
  color myColor;
  int stepSize;
  float stepScale;
  float combinedMove;
  
  
  RandomGen(){
   
    xPos = width/2 + 200; //definitions for location
    yPos = height/2;
    walkConstrain = false;
    position = new PVector(xPos, yPos);
    nodes = new HashMap();
    
  }
  
  void display(){
  
    
  }
  
  
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

class Square extends RandomGen{
  
  
  
  void move(){
    
    combinedMove = stepSize*stepScale;
        
    int random = int(random(4));
    
   if(walkConstrain){ //can't go past the borders
       
         if((random == 3 && (xPos+combinedMove)>=width) || (random == 2) && (xPos-combinedMove)<=200){
             nodes.put(position, (nodes.get(position)+1)); //<>//
             return;
         }
         if((random == 0 && (yPos+combinedMove)>=height) || (random == 1) && (yPos-combinedMove)<=0){
             nodes.put(position, (nodes.get(position)+1)); //<>//
             return;
         }
       
          //xPos = constrain(xPos, 200, width);
          //yPos = constrain(yPos, 0, height); //can't go past the borders
          
      }

      if (random == 0) {yPos += (combinedMove);} 
      else if (random == 1) {yPos -= (combinedMove);} 
      else if (random == 2) {xPos -= (combinedMove);}  //movements
      else if (random == 3) {xPos+= (combinedMove);}
      
       
    
      
      
      position.set(xPos,yPos);
      if(!nodes.containsKey(position)){
        nodes.put(position, 1);
      }
      else{nodes.put(position, (nodes.get(position)+1));}

  }
  
  
  void display(){
      
    if(terrain){
        int timesVisited = nodes.get(position);
        if (timesVisited < 4){fill(160, 126, 84);}
        else if (timesVisited < 7){fill(143,170,64);}
        else if (timesVisited < 10){fill(134,134,134);}
        else{
          int snow = (timesVisited*20);
          if(snow > 255){snow = 255;}
          fill(snow);
        }
    }
    else{fill(255,0,255);}
    if(stroke){stroke(0);}
    else{noStroke();}
    rectMode(CENTER);
    rect(xPos, yPos, stepSize, stepSize);
    
     
  }
  
  
}

class Hexagon extends RandomGen{
  
  void move(){}
  
  void display(){}
  
  
}
