int direita, esquerda;
int xDireita, xEsquerda;
int alturaRect, compRect;
int tamBola;
int xBola, yBola, resetXE, resetXD, resetY;
int cont;
char direcaoE, direcaoD, direcaoBH, direcaoBV = 'p';
PFont fonte;
int pontE, pontD;
int pontMax;
int time, xGift, yGift;
boolean comecar;


void setup() {
  pontMax = 10;
  fonte = loadFont("font.vlw");
  direita = 250;
  esquerda = 250;
  alturaRect = 40;
  compRect = 10;
  tamBola = 15;
  xBola = 20;
  yBola = 280;
  resetXE = 20;
  resetXD = 770;
  resetY = 280;
  xDireita = 780;
  xEsquerda = 10;
  cont=0;
  time = 0;
  pontE=0;
  pontD=0;
  comecar = false;
  xGift = (int)random(0,width);
  yGift = (int)random(0,height);
  size(800, 600);
  background(#5F23A5);
}

void draw() {
  if (comecar) {
    background(#5F23A5);
    //escrever pontuação
    textFont(fonte);
    text(pontE, 302, 50);
    text(pontD, 462, 50);
    
    cont=0;
    //desenhar raquete e bolinha 
    rect (xBola, yBola, tamBola, tamBola);
    rect(xEsquerda, esquerda, 10, 80);
    rect(xDireita, direita, 10, 80);
    
    //desenha linha central
    while (cont<=height) {
      fill(255, 255, 255, 255);
      rect(392, cont, compRect, alturaRect);
      noStroke();
      cont+=80;
    } 
    
    //movimentação raquete direita
    switch (direcaoD) {
      case ('u'):
      if (direita>(alturaRect/2)-12) direita-=5;
      break; 
  
      case ('d'): 
      if (direita<height-2*alturaRect-5) direita+=5; 
      break;
  
      case ('l'):
      if (xDireita>width/2+5) xDireita-=5;
      break; 
  
      case ('r'): 
      if (xDireita<=width-2*compRect) xDireita+=5; 
      break;
    }
  
    //movimentação raquete esquerda
    switch (direcaoE) {
      case ('u'):
      if (esquerda>(alturaRect/2)-12) esquerda-=5;
      break; 
  
      case ('d'): 
      if (esquerda<height-2*alturaRect-5) esquerda+=5; 
      break;
  
      case ('l'):
      if (xEsquerda>(alturaRect/2)-12) xEsquerda-=5;
      break; 
  
      case ('r'): 
      if (xEsquerda<width/2-20) xEsquerda+=5; 
      break;
    }
    
    colisaoParede (xBola, yBola);
    colisaoRaquete (xBola, yBola);
    
    //movimentação bolinha
    switch (direcaoBV) {
      case ('u'):
      yBola-=5;
      break; 
  
      case ('d'): 
      yBola+=5; 
      break;
    }
    switch (direcaoBH) {
      case ('l'):
      xBola-=5;
      break; 
  
      case ('r'): 
      xBola+=5; 
      break;
    }
    
    verificarGol(xBola, yBola);
    verificaPontuacao();
    
    //Gifts aleatórios
    if (time == 200) {
      xGift = (int)random(0,width);
      yGift = (int)random (0, height);
      text("+1", xGift, yGift);
       time=0; 
    }
    else {
      text("+1", xGift, yGift);
      time++;
    }
    colisaoGift();
  }
  else {
    background(#5F23A5);
    textFont(fonte);
    text("Aperte c para começar!", width/2-300, height/2);
  }
}

void keyPressed () {
  if (key == CODED) {
    if (keyCode == UP) direcaoD = 'u';
    if (keyCode == DOWN) direcaoD = 'd';
    if (keyCode == LEFT) direcaoD = 'l';
    if (keyCode == RIGHT) direcaoD = 'r';
  }
  if (keyPressed) {
    if (key == 'w') direcaoE = 'u';
    if (key == 's') direcaoE = 'd';
    if (key == 'd') direcaoE = 'r';
    if (key == 'a') direcaoE = 'l';
    if (key == 'c') comecar = true;
  }
}

void colisaoParede (int x, int y) {
  if (y==0) direcaoBV = 'd';
  if (y==height) direcaoBV = 'u';
}

void colisaoRaquete(int x, int y) {
  if (x <= xEsquerda+10 && x >= xEsquerda-10) {
    if (y>esquerda && y<esquerda+40) {
      direcaoBH = 'r'; 
      direcaoBV = 'u';
    }
    else if (y<esquerda+80 && y>esquerda+40) {
      direcaoBH = 'r';
      direcaoBV = 'd';
    }
  } 
  if (x <= xDireita+10 && x >= xDireita-10) {
    if (y>direita && y<direita+40) {
      direcaoBH = 'l';  
      direcaoBV = 'u';
    }
    else if (y>direita+40 && y<direita+80) {
      direcaoBH = 'l';
      direcaoBV = 'd';
    }
  }
}

void verificarGol (int x, int y) {
  if (x<=0) {
    xBola = resetXD;
    yBola = resetY;
    direcaoBH = 'p';
    direcaoBV = 'p';
    pontD++;
    pontE--;
  }
  else if (x>=width) {
    xBola = resetXE;
    yBola = resetY;
    direcaoBH = 'p';
    direcaoBV = 'p';
    pontE++;
    pontD--;
  }
}

void verificaPontuacao () {
  if (pontD == pontMax || pontE == pontMax) {
    setup();
  }
}

void colisaoGift () {
  if (yGift>=direita && yGift<=direita+80 && xGift>=xDireita && xGift<=xDireita+10) {
    pontD++;
    time = 200;
  }
  else if (yGift>=esquerda && yGift<=esquerda+80 && xGift>=xEsquerda && xGift<=xEsquerda+10) {
    pontE++;
    time=200;
  }
}

