PImage bg1, bg2, end1, end2, enemy1, fighter, hp, start1, start2, treasure;
final int GAME_START=1, GAME_RUN=2, GAME_OVER=3;  
int gameState;

//gamebackground
int bg1X, bg2X, bg3X;

//fighter
float fighterX, fighterY;
int fighterSpeed = 5;

//fightermove
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

//hp
int hpLong;

//enemy
int [] enemyC = new int [5];
int [] enemyB = new int [5];
int [] enemyA = new int [8]; 
int enemyY1, enemyY2, enemyY3; 
int enemyWidth, enemyHeight;
int enemySpeed;
int enemySpacing;
boolean showing = true;


//treasure
int treasureX, treasureY;



void setup(){
  size(640,480);
  colorMode(RGB);
  
  gameState = GAME_START;
  
  //image
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  enemy1 = loadImage("img/enemy.png");
  fighter = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  treasure = loadImage("img/treasure.png");
  
  //background
  bg1X=0;
  bg2X=0;
  
  //fighter
  fighterX = 640-62;
  fighterY = 240;
  
  //hp
  hpLong = 50;
  
  //enemy
  enemyB[1]=-(width+enemyWidth*5+enemySpacing*4+250);
  enemyA[0]=-(width*2+enemyWidth*5+enemySpacing*4+600);
  enemyY1 = floor(random(0,height-enemyHeight));
  enemyY2 = floor(random(0,height-enemyHeight*5));
  enemyY3 = floor(random(enemyHeight*2,height-enemyHeight*5));
  enemySpeed = 5;
  enemyWidth = 61;
  enemyHeight = 61;
  enemySpacing = 2;

  
  //treasure
  treasureX = floor(random(0,640-41));
  treasureY = floor(random(0,480-41));
  
  
}

void draw(){
  switch(gameState){
    case GAME_START: //start
    image(start2,0,0);
    if (mouseX > 200 && mouseX < 454 && mouseY > 372 && mouseY < 415){
      if (mousePressed){
        //click
        gameState = GAME_RUN;
      }else{
      image(start1,0,0);}
    }
    break;
    
    case GAME_RUN: //run
    //background
    bg1X =(bg1X+1)%1280;
    image(bg1,bg1X,0);
    bg2X =(bg1X-640+1)%1280;
    image(bg2,bg2X,0);
    bg3X =(bg2X-640+1)%1280;
    image(bg1,bg3X,0);
    
    // figtermove
    image(fighter, fighterX, fighterY);
    if (upPressed){
    fighterY = fighterY-fighterSpeed;
    if(fighterY<0){
      fighterY=0;
    }
  }
    if (downPressed){
    fighterY = fighterY+fighterSpeed;
      if(fighterY>419){
        fighterY=419;}
    }
    if (leftPressed){
    fighterX = fighterX-fighterSpeed;
       if(fighterX<0){
         fighterX=0;}
  }
    if (rightPressed){
    fighterX = fighterX+fighterSpeed;
      if(fighterX>579){
        fighterX=579;}
    }  
    
    
    
    //hp
    rectMode(CORNERS);
    rect(10,9,hpLong,25);
    fill(255,0,0);
    stroke(255,0,0);
    image(hp,2,5);
    if(hpLong >= 210){
    hpLong = 210;}
    
    //enemy
    
    
    //level C
    for(int i=0; i<enemyC.length; i++){
      int x = enemyC[1]-i*(enemyWidth+enemySpacing);
      image(enemy1,x,enemyY1);
      if(fighterX >= x && fighterX <= x+enemyWidth && fighterY >= enemyY1 && fighterY <= enemyY1+enemyHeight){
        hpLong -= 20;showing=false;}
      else if(fighterX+51 >= x && fighterX+51 <= x+enemyWidth && fighterY+51 >= enemyY1 && fighterY+51 <= enemyY1+enemyHeight){
        hpLong -= 20;showing=false;}
        
    }
    
    if(enemyC[4]>width){
    enemyY1 = floor(random(0,height-enemyHeight));}
    enemyC[1] += enemySpeed;
    enemyC[1] %= width*3+enemyWidth*10+enemySpacing*6+100;
    
 
    
    //level B
    for(int i=0; i <enemyB.length; i++){
      int x = enemyB[1]-i*(enemyWidth+enemySpacing);
      int y = enemyY2+i*(enemyHeight);
      image(enemy1,x,y);
       if(fighterX >= x && fighterX <= x+enemyWidth && fighterY >= y && fighterY <= y+enemyHeight){
        hpLong -= 20;}
      else if(fighterX+51 >= x && fighterX+51 <= x+enemyWidth && fighterY+51 >= y && fighterY+51 <= y+enemyHeight){
        hpLong -= 20;} 
    }
    
    if(enemyB[4]>width){
    enemyY2 = floor(random(0,height-enemyHeight*5));}
    enemyB[1] += enemySpeed;
    enemyB[1] %= width*3+(enemyWidth*10+enemySpacing*6);
    
 
   
   //level A
   int Xmoving = enemyWidth*2+enemySpacing*2;
   int Ymoving = -enemyHeight*2;
   
   for(int i=0; i<3; i++){
     int x= enemyA[0]-i*(enemyWidth+enemySpacing);
     int y= enemyY3+i*(enemyHeight);
     image(enemy1,x,y);
     if(fighterX >= x && fighterX <= x+enemyWidth && fighterY >= y && fighterY <= y+enemyHeight){
        hpLong -= 20;}
      else if(fighterX+51 >= x && fighterX+51 <= x+enemyWidth && fighterY+51 >= y && fighterY+51 <= y+enemyHeight){
        hpLong -= 20;} 
   }
   
   for(int i=0; i<3; i++){
     int x= enemyA[0]-i*(enemyWidth+enemySpacing)-Xmoving;
     int y= enemyY3+i*(enemyHeight)+Ymoving;
     image(enemy1,x,y);
     if(fighterX >= x && fighterX <= x+enemyWidth && fighterY >= y && fighterY <= y+enemyHeight){
        hpLong -= 20;}
      else if(fighterX+51 >= x && fighterX+51 <= x+enemyWidth && fighterY+51 >= y && fighterY+51 <= y+enemyHeight){
        hpLong -= 20;} 
   } 
   
   for(int i =6; i<7; i++){
     int x= enemyA[0]-Xmoving/2;
     int y= enemyY3+Ymoving/2;
     image(enemy1,x,y);
     if(fighterX >= x && fighterX <= x+enemyWidth && fighterY >= y && fighterY <= y+enemyHeight){
        hpLong -= 20;}
      else if(fighterX+51 >= x && fighterX+51 <= x+enemyWidth && fighterY+51 >= y && fighterY+51 <= y+enemyHeight){
        hpLong -= 20;} 
   }
   
   for(int i =7; i<8; i++){
     int x= enemyA[0]-Xmoving*3/2;
     int y= enemyY3-Ymoving/2;
     image(enemy1,x,y);
     if(fighterX >= x && fighterX <= x+enemyWidth && fighterY >= y && fighterY <= y+enemyHeight){
        hpLong -= 20;}
      else if(fighterX+51 >= x && fighterX+51 <= x+enemyWidth && fighterY+51 >= y && fighterY+51 <= y+enemyHeight){
        hpLong -= 20;} 
   }
   
   if(enemyA[2]>width){
    enemyY3 = floor(random(enemyHeight*2,height-enemyHeight*5));}
    enemyA[0] += enemySpeed;
    enemyA[0] %= width*3+(enemyWidth*10+enemySpacing*6);
    
  
  
   
   
 
    
    
   
    

  
    
    //treasure
    image(treasure, treasureX, treasureY);
    if(fighterX >= treasureX && fighterX <= treasureX+41 && fighterY >= treasureY && fighterY <= treasureY+41){
    hpLong += 20;}
    else if(fighterX+51 >= treasureX && fighterX+51 <= treasureX+41 && fighterY+51 >= treasureY && fighterY+51 <= treasureY+41){
    hpLong += 20;}
    else if(fighterX >= treasureX && fighterX <= treasureX+41 && fighterY+51 >= treasureY && fighterY+51 <= treasureY+41){
    hpLong += 20;}
    if(fighterX >= treasureX && fighterX <= treasureX+41 && fighterY >= treasureY && fighterY <= treasureY+41){
     treasureX = floor(random(0,640-41)); treasureY = floor(random(0,480-41));}
    else if(fighterX+51 >= treasureX && fighterX+51 <= treasureX+41 && fighterY+51 >= treasureY && fighterY+51 <= treasureY+41){
    treasureX = floor(random(0,640-41)); treasureY = floor(random(0,480-41));}
    else if(fighterX >= treasureX && fighterX <= treasureX+41 && fighterY+51 >= treasureY && fighterY+51 <= treasureY+41){
    treasureX = floor(random(0,640-41)); treasureY = floor(random(0,480-41));}
    
    //die
    if(hpLong <= 10){
    gameState = GAME_OVER;}
    
    break;
    
    case GAME_OVER: //gameover
    image(end1,0,0);
    if (mouseX >= 204 && mouseX < 434 && mouseY >= 306 && mouseY <= 350){
      if(mousePressed){
        gameState = GAME_RUN; fighterX = 580 ; fighterY = 240; hpLong = 50;
        enemyC[4]=0;
        enemyB[4]=-(width+enemyWidth*5+enemySpacing*4+250);
        enemyA[2]=-(width*2+enemyWidth*5+enemySpacing*4+600);
        enemyY1 = floor(random(0,height-enemyHeight));
        enemyY2 = floor(random(0,height-enemyHeight*5));
        enemyY3 = floor(random(enemyHeight*2,height-enemyHeight*5));
      }
    }
    else{image(end2,0,0);}
    break;
  }
}



void keyPressed(){
  if(key == CODED){
    switch (keyCode){
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
      }
    }
  }
  
void keyReleased(){
  if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }

}
