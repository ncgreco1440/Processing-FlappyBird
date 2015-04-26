final int maxSizeWidth = 1000;
final int maxSizeHeight = 500;

int score = 0;

boolean gameState; 

bird flappyBird = new bird(); 

pipeline pipe1 = new pipeline(0);
pipeline pipe2 = new pipeline(3);
pipeline pipe3 = new pipeline(6);
pipeline pipe4 = new pipeline(0);
pipeline pipe5 = new pipeline(3);
pipeline pipe6 = new pipeline(6);
pipeline pipe7 = new pipeline(9);
pipeline pipe8 = new pipeline(12);
pipeline pipe9 = new pipeline(9);
pipeline pipe10 = new pipeline(12);

void setup() {
  size(1000, 500);
  gameState = true;
  noCursor();
}

void draw() {
  background(153, 255, 255); 
  if (gameState) {

    FlappyBird(flappyBird);

    makePipes(pipe1); 
    makePipes(pipe2);
    makePipes(pipe3);
    makePipes(pipe4);
    makePipes(pipe5);
    makePipes(pipe6);
    makePipes(pipe7);
    makePipes(pipe8);
    makePipes(pipe9);
    makePipes(pipe10);

    displayScore(); 
    
    increaseDifficulty(); 
  } else {
    background(0);
    textSize(50);
    fill(255, 255, 255);
    text("Game Over", 350, 250);
    textSize(30);
    text("Score: " + score, 350, 300);
    text("Press P to play again", 350, 400);
    if(keyPressed) {
      if(key == 'p' || key == 'P') {
        //resetGame(); 
        gameState = true;
        flappyBird.yPos = 250;
        score = 0; 
        resetPipe(pipe1);
        resetPipe(pipe2);
        resetPipe(pipe3);
        resetPipe(pipe4);
        resetPipe(pipe5);
        resetPipe(pipe6);
        resetPipe(pipe7);
        resetPipe(pipe8);
        resetPipe(pipe9);
        resetPipe(pipe10);
      }
    }
  }
}

void resetGame() {
  flappyBird.yPos = 250; 
  score = 0; 
  resetPipe(pipe + i);
}

void mouseClicked() {
  flappyBird.fly();
}

void increaseDifficulty() {
  if(score > 500 && score < 550) {
      increasePipeSpeed(pipe1); 
      increasePipeSpeed(pipe2);
      increasePipeSpeed(pipe3);
      increasePipeSpeed(pipe4);
      increasePipeSpeed(pipe5);
      increasePipeSpeed(pipe6);
      increasePipeSpeed(pipe7);
      increasePipeSpeed(pipe8);
      increasePipeSpeed(pipe9);
      increasePipeSpeed(pipe10);
    }
  if(score > 1000 && score < 1100) {
      increasePipeSpeed(pipe1); 
      increasePipeSpeed(pipe2);
      increasePipeSpeed(pipe3);
      increasePipeSpeed(pipe4);
      increasePipeSpeed(pipe5);
      increasePipeSpeed(pipe6);
      increasePipeSpeed(pipe7);
      increasePipeSpeed(pipe8);
      increasePipeSpeed(pipe9);
      increasePipeSpeed(pipe10);
    }
  if(score > 2000 && score < 2100) {
      increasePipeSpeed(pipe1); 
      increasePipeSpeed(pipe2);
      increasePipeSpeed(pipe3);
      increasePipeSpeed(pipe4);
      increasePipeSpeed(pipe5);
      increasePipeSpeed(pipe6);
      increasePipeSpeed(pipe7);
      increasePipeSpeed(pipe8);
      increasePipeSpeed(pipe9);
      increasePipeSpeed(pipe10);
   }
  if(score > 4000 && score < 4100) {
      increasePipeSpeed(pipe1); 
      increasePipeSpeed(pipe2);
      increasePipeSpeed(pipe3);
      increasePipeSpeed(pipe4);
      increasePipeSpeed(pipe5);
      increasePipeSpeed(pipe6);
      increasePipeSpeed(pipe7);
      increasePipeSpeed(pipe8);
      increasePipeSpeed(pipe9);
      increasePipeSpeed(pipe10);
   }
}

void resetPipe(pipeline pipe) {
  resetSpeed(pipe);
  resetPipexPos(pipe); 
}

void increasePipeSpeed(pipeline pipe) {
  pipe.xSpeed = pipe.xSpeed * 1.005;
}

void resetSpeed(pipeline pipe) {
  pipe.xSpeed = 3; 
}

void resetPipexPos(pipeline pipe) {
  pipe.xPos = pipe.resetX;
}

void displayScore() {
  textSize(24);
  fill(0);
  text("Score: " + score, 25, 50);
}

void makePipes(pipeline pipe) {
  pipe.move();
  if (pipe.xPos <= 100 && pipe.xPos >= 25) {
    pipe.hitZone = true;
  } else {
    pipe.hitZone = false;
  }
  evaluateHitZones(pipe);
  pipe.display();
}

void FlappyBird(bird flappybird) {
  if (mousePressed) {
    flappybird.fly();
  } else {
    flappybird.drop();
  }
  flappybird.display();
}

class pipeline {

  int pipeWidth = 75; 
  int pipeHeight;
  int initX = maxSizeWidth + pipeWidth;
  int resetX;
  int modifiedX;
  boolean modX = false;
  boolean hitZone = false;
  int yPos;
  int xPos;
  int xSpeed; 
  int verticalHitBox; 

  pipeline(int x) {
    pipeHeight = randomPipeHeight();
    yPos = randomYPos();
    xPos = initX;
    xSpeed = 3; 
    xSpacer = pipeWidth * x; 
    resetX = initX;
    if (x != 0) {
      xPos = initX + xSpacer;
      resetX = resetX + xSpacer; 
      modX = true;
    }
    //initX = 0;
    //noStroke(); 
    //fill(0,155,0); 
    //rect(100, initY, pipeWidth, pipeHeight);
  }

  void display() {
    noStroke();
    fill(0, 204, 0);
    smooth();
    rect(xPos, yPos, pipeWidth, pipeHeight);
  }

  void move() {
    xPos = xPos - xSpeed; 
    modifiedX = modifiedX - xSpeed;
    if (xPos <= (0 - pipeWidth)) {
      xPos = initX; 
      pipeHeight = randomPipeHeight();
      yPos = randomYPos();
      //scoreIncrement();
    }
  }

  void randomYPos() {
    int randomY = random(1);
    if (randomY >= 0.5) {
      randomY = maxSizeHeight - pipeHeight;
      verticalHitBox = randomY;
    } else {
      randomY = 0;
      verticalHitBox = randomY + pipeHeight;
    }
    return randomY;
  }

  void randomPipeHeight() {
    int randomPipeHeight = int(random(50, 225));
    return randomPipeHeight;
  }
}

class bird {

  int gravity; 
  int diameter; 
  int xPos = 100;
  int yPos = 250; 

  bird() {
    gravity = 3; 
    diameter = 25;
  }

  void display() {
    noStroke();
    fill(255, 128, 0);
    smooth();
    ellipse(xPos, yPos, diameter, diameter);
  }

  void drop() {
    yPos = yPos + gravity; 
    if (yPos >= maxSizeHeight) {
      gameState = false;
    }
  }

  void fly() {
    yPos = yPos - (gravity * 2);
    if (yPos <= 0) {
      gameState = false;
    }
  }
}

void evaluateHitZones(pipeline pipe) {
  if (pipe.hitZone == true) {
    if (flappyBird.xPos >= pipe.xPos && flappyBird.xPos <= pipe.xPos + pipe.pipeWidth) {
      if (pipe.verticalHitBox <= 250) {
        if (flappyBird.yPos <= pipe.verticalHitBox) {
          gameState = false;
        } else {
          score = score + 1;
        }
      } else {
        if (flappyBird.yPos >= pipe.verticalHitBox) {
          gameState = false;
        } else {
          score = score + 1;
        }
      }
    }
  }
}


