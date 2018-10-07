import controlP5.*;

ControlP5 controlP5;
RandomGen randomGen;
Square square;
Hexagon hexagon;
controlP5.Button start;
controlP5.CheckBox checkboxes; //so many globals
controlP5.Slider iterations;
controlP5.Slider stepcount;
controlP5.Slider stepSize;
controlP5.Slider stepScale;
controlP5.DropdownList dropdown;
controlP5.Textfield textfield;
boolean letGo; //if start button has been released
boolean reset; //if the screen has been reset
boolean constrainBool;
boolean terrainBool;
boolean strokeBool;
boolean randomBool;
boolean hasEnded;
int iterCount; //how many iterations it has been
double colorValue; //for stroke

void setup(){
  size(1280,800);
  background(54,81,94); //hopefully this color is close enough
  controlP5 = new ControlP5(this); 
  
  randomGen = new RandomGen(); //construct the random walk
  square = new Square(); //squares and hexagons
  hexagon = new Hexagon();
  letGo = true; //start button isn't pressed
  reset = false; //screen is cleared
  hasEnded = false;

  start = controlP5.addButton("Start", 0, 15, 35, 95, 25).setColorBackground(color(0,255,0));
  controlP5.getController("Start").getCaptionLabel().setSize(25);   //start button 
 
  checkboxes = controlP5.addCheckBox("checkbox").setPosition(15, 535).setSize(30,30).setSpacingRow(30)
  .addItem("Constrain Steps", 0).addItem("Simulate Terrain", 1) 
  .addItem("Use Stroke", 2).addItem("Use Random Seed", 3);
  controlP5.getController("Constrain Steps").getCaptionLabel().setSize(12).getStyle().setMargin(25,10,-20,-33);
  controlP5.getController("Simulate Terrain").getCaptionLabel().setSize(12).getStyle().setMargin(25,10,-20,-33);//checkboxes
  controlP5.getController("Use Stroke").getCaptionLabel().setSize(12).getStyle().setMargin(25,10,-20,-33);
  controlP5.getController("Use Random Seed").getCaptionLabel().setSize(12).getStyle().setMargin(25,10,-20,-33);
  
  dropdown = controlP5.addDropdownList("Shapes").setHeight(120).setWidth(150)
                      .setPosition(15,75)
                      .addItem("SQUARES", square).addItem("HEXAGONS", hexagon) //dropdown
                      .setItemHeight(40).setBarHeight(40).setValue(0);
                     
  
  iterations = controlP5.addSlider("MAXIMUM STEPS").setPosition(15,240).setSize(175,25).setRange(100,500000).setDecimalPrecision(0);                
  iterations.getCaptionLabel().setVisible(false);                
  iterations.getValueLabel().setSize(20); 
  Textlabel maxsteps = controlP5.addTextlabel("maxsteps").setText("Maximum Steps") //Max steps slider
                          .setPosition(13,220);
  
  
  stepcount = controlP5.addSlider("STEP RATE").setPosition(15,300).setSize(175,25).setRange(1,1000).setDecimalPrecision(0);                
  stepcount.getCaptionLabel().setVisible(false);                
  stepcount.getValueLabel().setSize(20);    
  Textlabel ratetext = controlP5.addTextlabel("ratetext").setText("Step Rate") //steprate slider
                          .setPosition(13,280);
 
  stepSize = controlP5.addSlider("Step Size").setPosition(15,400).setSize(100,25).setRange(10,100).setDecimalPrecision(0);                
  stepSize.getCaptionLabel().setVisible(false);                
  stepSize.getValueLabel().setSize(20);   
  Textlabel steptext = controlP5.addTextlabel("steptext").setText("Step Size") //step size slider
                          .setPosition(13,430);
  
  stepScale = controlP5.addSlider("Step Scale").setPosition(15,450).setSize(100,25).setRange(1,1.5f);               
  stepScale.getCaptionLabel().setVisible(false);                
  stepScale.getValueLabel().setSize(20);   
  Textlabel scaletext = controlP5.addTextlabel("steprate").setText("Step Scale") //step scale slider
                          .setPosition(13,480);
                          
                          
                          
  textfield = controlP5.addTextfield("Seed Value")                        
                       .setPosition(110,700)   
                       .setSize(80,30)   //text field for seed value
                       .setText("0")
                       .setInputFilter(controlP5.INTEGER);
                       
}

void draw(){

  fill(127); //fill that rectangle with gray 
  rectMode(CORNER);
  rect(0,0, 200, 800);
  
  constrainBool = checkboxes.getState(0);
  terrainBool = checkboxes.getState(1);
  strokeBool = checkboxes.getState(2); //set bools every frame
  randomBool = checkboxes.getState(3);
  
  square.walkConstrain = constrainBool;
  hexagon.walkConstrain = constrainBool;
  //if(!terrainBool){colorValue = color(255,0,255);}
  square.terrain = terrainBool;
  hexagon.terrain = terrainBool; //setting all the bools in the shape classes equal to those bools
  square.stroke = strokeBool;
  hexagon.stroke = strokeBool;
  square.stepSize = (int)stepSize.getValue();
  square.stepScale = stepScale.getValue();
  hexagon.stepSize = (int)stepSize.getValue();
  hexagon.stepScale = stepScale.getValue();
  square.iterCount = (int)iterations.getValue();
  hexagon.iterCount = (int)iterations.getValue();
  
   //<>//

  
    if(start.isPressed() && letGo){ //if button is pressed
      letGo = false; 
      Reset(); //default
      
        if(randomBool){
            String inputString = textfield.getText();
            int randomSeed = Integer.parseInt(inputString); //if start is pressed and random is pressed, change the seed
            randomSeed(randomSeed);
          }
    }
    else if(!start.isPressed()){
      letGo = true; //start button is no longer pressed 
    }
    
    if(reset && !hasEnded){ //if the program is running
      
      
      if(dropdown.getValue() == 0){
          for(int i = 0; i < (int)stepcount.getValue(); i++){
              square.move(); //<>//
              square.display(); //if we are on squares, do the square movements
              iterCount++;
              if(iterCount == (int)iterations.getValue()){break;} //if gradual gets to end
          }
      
       }
      
      else if(dropdown.getValue() == 1){
          for(int i = 0; i < (int)stepcount.getValue(); i++){
              hexagon.move(); //<>//
              hexagon.display(); //if we are on hexagon, do the hexagon movements
              iterCount++;
              if(iterCount == (int)iterations.getValue()){break;} //if gradual gets to end
          }
      }
    
    
    
    }
    
    
    if(iterCount == (int)iterations.getValue()){
      hasEnded = true;
      iterCount = 0; //reset
    }
  
}
      


void Reset(){
  background(54,81,94);
  square.xPos = width/2 + 200; //defaults
  square.yPos = height/2;
  hexagon.xPos = width/2 + 200;
  hexagon.yPos = height/2;
  square.nodes.clear();
  hexagon.nodes.clear();
  square.start = true;
  hexagon.start = true;
  reset = true;
  hasEnded = false;
  iterCount = 0;
  
}
