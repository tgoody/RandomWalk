class Hexagon extends RandomGen{
  
  float angle; 
  
  
  
  void drawHexagon(float x, float y, float radius, int npoints) {
    float angle = TWO_PI / npoints;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius;
      float sy = y + sin(a) * radius;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
  
  boolean constrain(int random){
    float ourAngle = (random+1) * 60;
    float tempX = cos(radians(angle))*(stepSize*sqrt(3))*stepScale;
    float tempY = sin(radians(angle))*(stepSize*sqrt(3))*stepScale;
    
    if ((random == 2 || random == 3) && (xPos + tempX) <= (200 + combinedMove) || 
    (random == 0 || random == 5) && (xPos + tempX) >= (width - combinedMove)){
      nodes.put(position, (nodes.get(position)+1));
      return false;
    }
    else if(((random > 2) && yPos + tempY <= (0 + combinedMove)) ||((random < 3) &&  yPos + tempY >= (height - combinedMove))){
      nodes.put(position, (nodes.get(position)+1));
      return false;
    }
    return true;
    
  }
  
  
  
  
  
  void move(){
    
   combinedMove = stepSize*stepScale;
    
   int random = int(random(6));//[randomCounter];

   if(walkConstrain){ //can't go past the borders
       
         boolean free = constrain(random);
       
          //xPos = constrain(xPos, 200, width);
          //yPos = constrain(yPos, 0, height); //can't go past the borders
          if (!free){return;}
          
      }

      switch(random){
        
      case 0: 
        angle = 30;
        break;
      case 1: 
        angle = 90;
        break;
      case 2: 
        angle = 150;
        break;
      case 3: 
        angle = 210;
        break;
      case 4: 
        angle = 270;
        break;
      case 5: 
        angle = 330;
        break;
      }
    
      xPos += (cos(radians(angle))*(stepSize*sqrt(3)))*stepScale;
      yPos += (sin(radians(angle))*(stepSize*sqrt(3)))*stepScale;
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
    
    drawHexagon(xPos, yPos, stepSize, 6);
    
     
  }
  
  
}
