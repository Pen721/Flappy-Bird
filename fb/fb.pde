color c111, b111; //used as colors of the buttons
int m;            //milisecond(not commonly used)
PImage pip, bg, gr, bir, open, playh, playnh; //images such as background, ground, pipes, and flappy bird
int screen;  //screen being displayed


//page 0/homepage
button play; 
button[] buttons = new button[10];//buttons on homepage
int bcount; //amount of players

//page 1/birdsetup screen
ArrayList<birdsetup> bs;  //hmmm the list of birdsetups sorry for the name

//page2/play screen
boundry ground;
pipe closest;
ArrayList<bird> abirds; //ArrayList of all alive birds
pipe s, s2; //we wanted to only move 3 pipes at a time to save space, see details at Grame page void movePipes():)
Stack<pipe> pipes;
int dis;    //distance between pipes

String [] answers = new String[]{"Hello! My name is Penny and I'm a two year Upper! My email is pbrant@exeter.edu, but you can also reach out to me on messenger.", "In addition to ECC, I’m also involved with ESSO, Physics club, and robotics (I also play the piano). I will not be going abroad next year.", "In ECC, I’ve been organizing weekly meetings for learning group through coding tutorials and lectures. In addition, I also helped organize HackExeter through sending emails, advertising it through devpost and facebook, organizing budget, building the website, and organizing meetings out of ECC meeting times. I also compete in USACO for fun and am currently in the gold division. I enjoy every part of ECC, but my favorite thing is definitely during HackExeter because it's a time when most of the club comes together to make something amazing happen.", 
"At Exeter, I have taken CS405, 505, 999(ML), 590(Creative Computing), 999(ML). Before Exeter, I had very little knowledge of coding, this sequence essentially taught me everything from introductory java to advance machine learning architecture. Some of my most interesting projects from these classes are a Generative Adversarial Network that I built from scratch last Spring, a phone software that has the potential of converting water patterns into music, and the DRAGON(Deep Regret Analytic GAN)VEEGAN(Variational Encoder Enhancement GAN) that I’m implementing in CS999 right now.", 
"ECC has been a very great learning opportunity for me, not only in coding knowledge, since it has also taught me important lessons in teamwork. Along the way, I also developed many meaningful friendships. I think the main reason my ECC experience has been so great this year is due to the inclusive and friendly atmosphere the current senior co-heads - Arun, Jenny, Pavan, and Evan -  have created in the club. I really want to continue what they have done this year through weekly meetings so incoming students can have the same experience I’ve had. In addition, I also want to use the knowledge I’ve learned through helping to organize HackExeter in the past two years to make sure future attendees have the best possible experience.", 
"My favorite CS project is definitely one that I made during Winter term. Originally, Andrew Woo and I wanted to investigate alternative minecraft engines that could make it compute large number of pixels quickly. Along the way, we realized this method of stacking large pixelated data into 3-D structures could be combined with multi-dimensional traversal algorithm to enhance radiologist’s comprehension of MRI data. This was definitely my favorite project as something we did for fun could actually help people in our community. The runner up for my favorite CS project is the image recognition software we implemented on our robot for robotics Worlds. ", 
"Ideas I have for ECC next year: Invite alumni that work in the technology field to club meetings, reach out to companies/alumni to sponsor HackExeter prices, club sessions where students can present CS related projects/research, compete in competitions like google code jam, Metrohacks, BluePrint Hacks, encourage CS classes to present end of term projects in ECC."};


//page 3.end game
button learn;
button exit2;
Stack<bird> ranks;  //the rank of teh players, in order of death

//page4
int wspan, sizeb2;
bird b2;
Stack<pipe> pipes2;
pipe s11, s22;

//data
int d1;
int d2;
int d3;
int d4;
int[][][][] data; //a way to store data from birds of x, y, to the closest pipe and if they jumped and not...used to train future birds
bird b;

int al = 1;
int question = 1;


void setup(){  

  screen = 0;
  size(540,960);
  pip = loadImage("pipe1.png");
  bir = loadImage("fb.png");
  gr = loadImage("ground.png");
  bg = loadImage("bg.jpg");
  open = loadImage("fbopenpage.jpg");
  playh = loadImage("playbuttonh.png");
  playnh = loadImage("playbuttonnh.png");
  color c111 = color(255,255,255);
  color b111 = color(230,230,230);
  b = new bird(40, bir, 40, 50, 50);
  b.display(bir);

  
  //screen1, setuppage
  play =  new button(740,900,120,70,c111, b111);


  //screen2, gamepage
  pipes = new LStack<pipe>();
  ground = new boundry(0,800,1000,1000);
  for(int i=0;i<200;i++){
    int h = int(random(300, 600));
    h = 700;
   pipes.push(new pipe(h, pip, 1000));
  }
  int hs = int(random(300,600));
  int hs2 = int(random(300,600));
  s2 = new pipe(hs, pip, 1000);
  s = new pipe(hs2, pip, 1000);
  dis = 650;
  
  //screen3, gameoverpage
  ranks = new LStack<bird>();
  learn = new button(595,780,230,40, c111, b111);
  exit2 = new button(400,780,120,40,c111,b111);
  
  //screen4
  wspan = int(random(1,3));
  sizeb2 = int(random(1,3));
  //b2 = new bird(c111, sizeb2*30, bir, wspan*10 + 20, 100,200);
  pipes2 = new LStack<pipe>();
  for(int i=0;i<20;i++){
    int h = int(random(100,600));
   pipes2.push(new pipe(h, pip, 1000));
  }
   s11 = new pipe(hs, pip, 1000);
  s22 = new pipe(hs2, pip, 1000);
}

void draw(){
        //represent different states/screens of game
        if(screen == 0){
        Homepage();
        }
        
        if(screen == 2){   
        screen = Gamepage();
        }
        
        
        //display buttons on the gamesoverpage
        if(screen ==4){
          image(bg, 0,0,540,960);
          fill(255,255, 255);
          textAlign(LEFT);
          text("your Score Was " + b.score, 50, 20, 200, 400);
          if(b.score < 6){
          text(answers[b.score], 50, 100, 480, 800);
          }
          else{
            text("Ok you win you're a god at flappy bird.", 50, 100, 480, 800);
          }
           fill(0,0,0);
           textSize(20);   
          exit2.display();
          fill(0,0,0);
           textSize(20);
           text("exit game", 400,810);
          if(exit2.pressed){
            exit();
          }
           
        }
        
        if(screen ==5){
          birdrun2();
        }
  }

//class structure of a bird
class bird{
float ypos;
float xpos;
float s;
float wingspan;
float m;
float v;
boolean l;
boundry bo;
color c123;
int score;
int player;
boolean alive;

//initialization
bird(float size, PImage p, float w, float x, float y){
  s = size;
  wingspan = w;
  v = 0;
  xpos = x;
  ypos = y;
  image(p, x, y, size, 0.75*size);
  noTint();
  l = true;
  bo = new boundry(xpos, ypos, size, 0.75*size);
  alive = true;
  score = 0;
}


void display(PImage pi){
  if(alive){
image(pi, xpos, ypos, s, 0.75*s);
noTint();
updatebo();
  }
}

void grav(){
  v-= 0.6*12;
  ypos-= 0.6*v;
  updatebo();
}

void jump(){
  v = wingspan;
  updatebo();
  }
  
void death(){
   v =0;
   alive = false;
   updatebo(); //update the boundries of the bird
 }


void updatebo(){
  bo = new boundry(xpos, ypos, s, 0.75*s);
}
}

//a data strcuture containing a background, a bird and a button. This made it easier to set up the dispalying on the birdsetup page
//birdsetup class is used mainly for screen1, when users can click a button and the shape of the birds will be randomly generated
class birdsetup{
  bird b;
  button bu;
  
  //images
  PImage bir;
  PImage bg;
  
  float x;  //xpos
  float y;  //ypos
  float s;  //size
  float w; //wingspan
  color c; // color for the bird
  color c111, b111; //color for the buttons
  
  //birdsetup constructor
  birdsetup(float xo, float yo, PImage br, PImage pg){
    bg = pg;
    color c111 = color(250,250,250);
    color b111 = color(230,230,230);
    x = xo;
    y = yo;
    bir = br;
    bu = new button(x, y, 20.0, 20.0, c111, b111);
  }
  
  //displaying new randomly generated bird
  void display(){
    image(bg, x,y,170,170);
    bu.display();
    b.display(bir);
    if(bu.pressed){
    }
  }
  
  //setting b into a random bird
}

//strcture boundry, this dedicates if there's a collision between two objects
class boundry{
  float x1;
  float y1;
  float x2;
  float y2;
  float w;
  float h;
  
  boundry(float x, float y, float wi, float he){
  x1 = x;
  y1 = y;
  x2 = x1+wi;
  y2 = y1+he;
  w = wi;
  h = he;
  }
  
  
  
}



class button{
int rectX, rectY;      // x, y position of the button
int rectSize = 90;  
boolean rectOver;    //indicare if the mosue hovers over the button
boolean pressed;    //indicate if the button is clicked
float x, y, w, h;
color c, b;            // c= color of button, b = colro of button when hovered

button(float x1, float y1, float w1, float h1, color c1, color b1){
  pressed = false;
  x = x1;
  y = y1;
  w = w1;
  h = h1;
  c = c1;
  b = b1;
} 


void overRect()  {
  if (mouseX >= x && mouseX <= (x+w) && //if the mouse hovers over the area of the button
      mouseY >= y && mouseY <= (y+h)) {
    rectOver = true;
  } else {
    rectOver = false;
  }
}

void display(){
  overRect();
  pressed = false;
  if(rectOver){
    fill(b);
    rect(x, y, w, h);
    noFill();
    if(mousePressed){
       pressed = true;
     }
  }
  else{
    fill(c);
    rect(x, y, w, h);
    noFill();
  }
}
}

 
//the run for the AI bird
  void birdrun2() {
  closest = findclose2();
  int m = millis();
  image(bg, 0, 0, 1000, 1000);
  s11.display(pip);
   s11.move();
  s22.display(pip);
  pipes.topValue().display(pip);
  pipesmove();
  
  image(gr, 0-(m*0.05)%50, 800, 1000, 250);
  
  //birds fall based on gravity
    b2.display(bir);
    b2.grav();
    int c1111 = int(closest.xpos - b.xpos)/40 + 5;
    int d1111 = int((closest.ypos+927 - b.ypos)/40) + 20;
    if(data[wspan][sizeb2][c1111][d1111] == 1){
      b2.jump();
    }
  
  //bird collides with pipes/ground/celing
  if(collision(b2.bo, pipes2.topValue().bo2)|| collision(b2.bo, pipes2.topValue().bo) || collision(b2.bo, s22.bo2) 
  || collision(b2.bo, s22.bo) || collision(b2.bo, s11.bo2) || collision(b2.bo, s11.bo) || (b2.ypos>=800)|| b2.ypos<=-10){
      b2.death();
      exit();
  }
  }
   
   
     //Game page
  
  int Gamepage() {
    print(b.score);
  closest = findclose();
  int a11 = 0, b11 = 0, c11 = 0, d11 =0;
  int m = millis();
  image(bg, 0, 0, 1000, 1000);
  //pipes
  s.display(pip);
   s.move();
  s2.display(pip);
  pipes.topValue().display(pip);
  
  //shifts the pipes and get score
  pipesmove();
  
  image(gr, 0-(m*0.05)%50, 800, 1000, 250);
  
  //birds fall based on gravity
    b.display(bir);
    b.grav();
  
  //birds jump is key is pressed
    if(keyPressed){
        b.jump();
        a11 = int((b.wingspan - 20)/10);
        b11 = int(b.s/30);
        c11 = int(closest.xpos - b.xpos)/40 + 5;
        d11 = int((closest.ypos+927 - b.ypos)/40) + 20;
      }
  
  //bird collides with pipes
  if(collision(b.bo, pipes.topValue().bo2)|| collision(b.bo, pipes.topValue().bo) || collision(b.bo, s2.bo2) 
  || collision(b.bo, s2.bo) || collision(b.bo, s.bo2) || collision(b.bo, s.bo) || (b.ypos>=800)|| b.ypos<=-10){
      b.death();
      al = 0;
  }
  
  if(b.alive){
  return 2;
  }else{
 return 4;
  }
  }
   
     
  pipe findclose(){
    if(s.xpos<=-70){
    return s2;
  }
  else{
    return s;}
  }
  
  pipe findclose2(){
  if(s11.xpos<= -70){
  return s22;
}else{
  return s11;
  }
  }
 
  //method determines whether two objects are colliding 
  boolean collision(boundry b1, boundry b2){
    return (Math.max(b1.y1, b2.y1) <= Math.min(b1.y2, b2.y2) && 
    Math.min(b1.x2, b2.x2) >= Math.max(b1.x1, b2.x1));
  }
  
  //page where birds are randomly set up
   
 void pipesmove(){
   if(s2.xpos - s.xpos >= dis){
    s2.move();
  }
  
  if(pipes.topValue().xpos - s2.xpos >= dis){
  pipes.topValue().move();
  }
  
  if(s.xpos<=-75){
  s = s2;
  s2 = pipes.pop();
  b.score++;
  print(b.score);
  }
  }
  
     void Homepage() {
   image(open, 0,0,540,960);
   //text
     fill(255,255,255);
     textAlign(CENTER);
     textSize(50);
     text("Play",270,240);
     textSize(20);
     text("To collect co-head applciation responses!", 270, 360);
     c111 = color(255, 255, 255);
     b111 = color(230,230,230);
     if(mouseX > 50 && mouseX < 240 && mouseY < 700 && mouseY > 580){
       image(playh, 50, 610,195,105);
       if(mousePressed){
         screen = 2;
       }
     }
  }

class pipe{
float height;
float xpos;
PImage pi;
boundry bo;
boundry bo2;
float ypos;


pipe(float h, PImage p, float xp){
  height = h;
  pi = p;
  xpos = xp;
  ypos = height-799;
  bo = new boundry(xpos, ypos, 115, 668);
  bo2 = new boundry(xpos, ypos+893, 115, 707);
}

void move(){
  xpos = xpos-15*al;
  updatebo();
  }
  
  void display(PImage pi){
    image(pi, xpos, ypos, 115,1500);
  }
  
  void updatebo(){
  bo = new boundry(xpos, ypos, 115, 668);
  bo2 = new boundry(xpos, ypos+893, 115, 707);
}
}

BufferedReader reader;
String line;
 
//readling data from out.txt and converting into the 4d array
/*void readline(){
  reader = createReader("out.txt");    
  for(int i=0;i<int((d1)*(d2)*(d3)*(d4));i++){
  try {
    line = reader.readLine();
  } catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
  if (line == null) {
    noLoop();  
  } else {
    //breakdown each line into componets of the 4d array
    String[] pieces = split(line, ' ');
    int x = int(pieces[0]);
    int y = int(pieces[1]);
    int h = int(pieces[2]);
    int z = int(pieces[3]);
    int u = int(pieces[4]);
    data[x][y][h][z] = u;
    }
    }
  }
  */


  /** Array-based stack implementation */
/** Stack ADT */
public interface Stack<E> {
/** Reinitialize the stack. The user is responsible for
reclaiming the storage used by the stack elements. */
public void clear();
/** Push an element onto the top of the stack.
@param it The element being pushed onto the stack. */
public void push(E it);
/** Remove and return the element at the top of the stack.
@return The element at the top of the stack. */
public E pop();
/** @return A copy of the top element. */
public E topValue();
/** @return The number of elements in the stack. */
public int length();
};


import java.io.BufferedWriter;
import java.io.FileWriter;
PrintWriter output;

//updates out.txt after each run
/*void set(){
  output = createWriter("out.txt");
  // Write some text to the file
  for(int i111=0; i111<d1; i111++){//50-159/80
  //30-80 / 80
    for(int x111=0;x111<d2;x111++){
      //1 - 650/40 
      for(int y111 = 0;y111<d3;y111++){
        //0 - 800 / 40
        for(int h111 = 0;h111<d4;h111++){
            //keeps record of data in out.txt
            output.println(i111 + " " + x111 + " " + y111 + " " + h111 + " " + data[i111][x111][y111][h111]);
        }
      }
    }
  }
  output.close();
  //exit();
}*/

/**
 * Appends text to the end of a text file located in the data directory, 
 * creates the file if it does not exist.
 * Can be used for big files with lots of rows, 
 * existing lines will not be rewritten
 */
 
/*void appendTextToFile(String filename, String text){
  File f = new File(dataPath(filename));
  if(!f.exists()){
    createFile(f);
  }
  try {
    PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(f, false)));
    out.println(text);
    out.close();
  }catch (IOException e){
      e.printStackTrace();
  }
}

/**
 * Creates a new file including all subfolders
 */
/*void createFile(File f){
  File parentDir = f.getParentFile();
  try{
    parentDir.mkdirs(); 
    f.createNewFile();
  }catch(Exception e){
    e.printStackTrace();
  }*/
  
    /** Singly linked list node */
class Link<E> {
  private E element; // Value for this node
  private Link<E> next; // Pointer to next node in list
  // Constructors
  
  Link(E it, Link<E> nextval)
  { element = it; next = nextval; }
  
  Link(Link<E> nextval) { next = nextval; }
  
  Link<E> next() { return next; } // Return next field
  
  Link<E> setNext(Link<E> nextval) // Set next field
  { return next = nextval; } // Return element field
  E element() { return element; } // Set element field
  E setElement(E it) { return element = it; }
}


/** Linked stack implementation */
class LStack<E> implements Stack<E> {
  private Link<E> top;          // Pointer to first element
  private int size;             // Number of elements
  /** Constructors */
  public LStack() { top = null; size = 0; }
  public LStack(int size) { top = null; size = 0; }
  /** Reinitialize stack */
  public void clear() { top = null; size = 0; }
  /** Put "it" on stack */
  public void push(E it) {
    top = new Link<E>(it, top);
size++; }
  /** Remove "it" from stack */
  public E pop() {
    assert top != null : "Stack is empty";
    E it = top.element();
    top = top.next();
    size--;
return it; }
  /** @return Top value */
  public E topValue() {
    assert top != null : "Stack is empty";
    return top.element();
  }
  /** @return Stack length */
  public int length() { return size; }
}


//thanks for reading