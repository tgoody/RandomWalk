class Square extends RandomGen{
  
  void move(){
    
   combinedMove = stepSize*stepScale; //the movement amount
    
   int random = int(random(4));//the random choice
    
   if(walkConstrain){ //can't go past the borders
       
         if((random == 3 && (xPos+combinedMove)>=(width-ceil(combinedMove/2))) || (random == 2) && (xPos-combinedMove)<=(200+ceil(combinedMove/2))){
             nodes.put(position, (nodes.get(position)+1));
             return;
         } //my shoddy constrain method
         if((random == 0 && (yPos+combinedMove)>=(height-ceil(combinedMove/2))) || (random == 1) && (yPos-combinedMove)<=(0+ceil(combinedMove/2))){
             nodes.put(position, (nodes.get(position)+1));
             return;
         }
          
      }

      if (random == 0) {yPos += (combinedMove);} 
      else if (random == 1) {yPos -= (combinedMove);} 
      else if (random == 2) {xPos -= (combinedMove);}  //movements
      else if (random == 3) {xPos+= (combinedMove);}
      
       
    
      
      
      position.set(xPos,yPos);
      if(!nodes.containsKey(position)){
        nodes.put(position, 1); //explained in the Hexagon class
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
