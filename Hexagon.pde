class Hexagon extends RandomGen{
  
  float angle; 
  
  
  
  void drawHexagon(float x, float y, float radius, int npoints) {
    float angle = TWO_PI / npoints;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius; //this template for polygons was on the processing.org website
      float sy = y + sin(a) * radius;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
  
  boolean constrain(int random){
    float ourAngle = ((random+1) * 60) - 30; //finding the angle
    float tempX = cos(radians(ourAngle))*(stepSize*sqrt(3))*stepScale; //setting x and y values for movement
    float tempY = sin(radians(ourAngle))*(stepSize*sqrt(3))*stepScale;
    
    if ((random == 2 || random == 3) && (xPos + tempX) <= (200 + combinedMove) || 
    (random == 0 || random == 5) && (xPos + tempX) >= (width - combinedMove)){
      nodes.put(position, (nodes.get(position)+1)); //if, given certain random values, the x is over/under the bounds, store it in hashmap and don't move
      return false;
    }
    else if(((random > 2) && (yPos + tempY) <= (0 + combinedMove)) ||((random < 3) &&  yPos + tempY >= (height - combinedMove))){
      nodes.put(position, (nodes.get(position)+1)); //same thing, but for y
      return false;
    }
    return true;
    
  }
  
  
  
  
  
  void move(){
    
   combinedMove = stepSize*stepScale; //only used for constrain
    
   int random = int(random(6));

   if(walkConstrain){ //can't go past the borders
         boolean free = constrain(random);
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
      yPos += (sin(radians(angle))*(stepSize*sqrt(3)))*stepScale; //move a certain amount
      position.set(floor(xPos),floor(yPos));
      if(!nodes.containsKey(position)){
        nodes.put(position, 1); //store in hashmap if not there
      }
      else{nodes.put(position, (nodes.get(position)+1));} //increment otherwise

  }
  
  
  void display(){
      
    if(terrain){
        int timesVisited = nodes.get(position);
        if (timesVisited < 4){fill(160, 126, 84);}
        else if (timesVisited < 7){fill(143,170,64);} //colors for times visited
        else if (timesVisited < 10){fill(134,134,134);}
        else{
          int snow = (timesVisited*20);
          if(snow > 255){snow = 255;} //for values over 255
          fill(snow);
        }
    }
    else{fill(255,0,255);}
    if(stroke){stroke(0);} //stroke
    else{noStroke();}
    
    drawHexagon(xPos, yPos, stepSize, 6); //draw it
    
     
  }
  
  
}
