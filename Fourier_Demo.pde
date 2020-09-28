ArrayList<Button> buttons;
ArrayList<InputBox> inputs;
ArrayList<TextBox> texts;
Data data;
PFont font;

void setup()
{
  size(1000, 800);
  background(0);
  font = loadFont("TrebuchetMS-30.vlw");
  data = new Data();
  buttons = new ArrayList<Button>(0);
  inputs = new ArrayList<InputBox>(0);
  texts = new ArrayList<TextBox>(0);
  buttons.add(new Button(WAVETYPE, "SINE", 25, 550, data));
  buttons.add(new Button(WAVETYPE, "TRIANGLE", 25, 600, data));
  buttons.add(new Button(WAVETYPE, "SAWTOOTH", 25, 650, data));
  buttons.add(new Button(WAVETYPE, "SQUARE", 25, 700, data));
  buttons.add(new Button(ADDWAVE, "+1", 250, 550, data));
  buttons.add(new Button(REMOVEWAVE, "-1", 250, 600, data));
  buttons.add(new Button(SETNUM, "10", 250, 650, data));
  buttons.add(new Button(SETNUM, "100", 250, 700, data));
  texts.add(new TextBox("Number of waves", 475, 550));
  inputs.add(new InputBox(NUMWAVES, 475, 600, data));
  texts.add(new TextBox("Period (s)", 475, 650));
  inputs.add(new InputBox(PERIOD, 475, 700, data));
  texts.add(new TextBox(nf(frameRate, 2,2), 25, 490));
  texts.get(texts.size()-1).setSize(100, 50);
  buttons.add(new Button(FRAMERATE, "60", 150, 490, data));
  buttons.get(buttons.size()-1).setSize(100,50).setNum(60);
  texts.add(new TextBox("0", 275, 490));
  texts.get(texts.size()-1).setSize(100, 50);
  texts.add(new TextBox("Made by Liam Wrubleski", 475, 490));
  texts.get(texts.size()-1).setSize(350, 50);
}

void draw()
{
  stroke(255, 255, 255);
  noFill();
  background(0);
  frameRate(FPS);
  data.draw();
  Button b = buttons.get(buttons.size()-1);
  if(b.num - frameRate > 5){
    b.setColor(color(255, 200, 200));
  } else {
    b.setColor(color(255, 255, 255));
  }
  for(Button button : buttons){
    button.draw();
  }
  for (InputBox input : inputs){
    input.draw();
  }
  for (TextBox text : texts){
    text.draw();
  }
  textSize(200);
  textFont(font);
  texts.get(2).text = nf(frameRate, 2, 2);
  texts.get(3).text = str(data.numWaves);
}

void keyPressed(){
  
  noLoop();
  if(key != ' '){
    loop();
  }
  if(('0' <= key && key <= '9') || key == '.'){
    println(str(key)+": " + int(key));
    for(InputBox input : inputs){
      if(input.listening){
        input.input(key);
      }
    }
  }  
  if(keyCode == ENTER){
    for(InputBox input : inputs){
      if(input.listening){
        input.enter();
      }
    }
  } //<>//
  if(keyCode == BACKSPACE){
    for(InputBox input : inputs){
      if(input.listening){
        input.backspace();
      }
    }
  }
}

void mouseClicked()
{
  for (Button button : buttons){
    if(button.x_pos < mouseX && button.x_pos + 200 > mouseX && button.y_pos < mouseY && button.y_pos + 50 > mouseY){
      button.click();
    }
  }
  for (int i = 0; i < inputs.size(); i++){
    InputBox input = inputs.get(i);
    if(input.x_pos < mouseX && input.x_pos + 500 > mouseX && input.y_pos < mouseY && input.y_pos + 50 > mouseY){
      input.click();
      for(int j = 0; j < inputs.size(); j++){
        if(i == j){continue;}
        inputs.get(j).listening = false;
      }
    }
  }
}