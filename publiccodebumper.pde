// import the library
import com.hamoid.*;
import processing.sound.*;
  
// create a new VideoExport-object
float movieFPS = 30;
float movieDuration = 10.0; // in seconds
VideoExport videoExport;

//Output filename for generated animation in MP4 fileformat
String OutputFile = "publiccodebumper-out.mp4";

// Create font
PFont font;

//Logo and imagedata needed for animation
PShape vectorlogo;
PImage logo;
PImage background;
PGraphics layer1;
PGraphics layer2;
PGraphics layer3;

//Additional animation calculation variables
float x,y;
float angle;

//Audiofile for use as background audio
String audioFilename = "publiccodepodcast-sonic-chapter-long.wav";

//Animationstates
final int animateLogo = 0;
final int animateHeader = 1;
final int animateFooter = 2;
final int showLobby = 3;
final int animateLive = 4;

int startTime;
int timer;
int state = animateLogo;

void setup() {
  // Some settings
  size(1920, 1080);
  smooth(8);

  videoExport = new VideoExport(this, OutputFile);
  videoExport.setFrameRate(movieFPS);
  videoExport.setAudioFileName(audioFilename);
  videoExport.startMovie();

  logo = loadImage("publiccodelogo.png");
  vectorlogo = loadShape("mark.svg");
  background = loadImage("intro-brackground.png");
  
  //Load and set the font
  font = loadFont("Mulish-SemiBold-48.vlw");
  textFont(font);
  
 
  
  //Initialize x,y with center coordinates
  x = width/2;
  y = width/2;
  startTime = millis();
  
  
  layer1 = createGraphics(width, height);
  
 
  
}
void draw() {
  // set background color
  background(#FFFFFF);
  
  

  println ("Timer:" + timer);
  timer = millis()/1000;
  
  switch(timer){
    
    case 1: 
      state = animateLogo;
      println ("STATE:" + state);
      break;
      
      
    case 3:
      state = animateHeader;
      println ("STATE:" + state);
      break;
   
    
  
  }
  
   
  
 
  switch(state){
    
    case 0:
 
  
      angle += 0.05;
      float theta = 3 + (3 * sin(angle)); //DIFFERENCE TO A SMOOTHER OSCILATION
      //THE 3+ IS TO MOVE THE ENTIRE GRAPH UP TO POSITIVE VALUES
         
      
      pushMatrix();
      
      translate(width/2, height/2);
      scale(theta);
      shape(vectorlogo, -50, -50, 100, 100);
      popMatrix();
 
    
  
      break;
    
    case 1:
      
      pushMatrix();
      fill (0);
      text("Foundation for Public Code",1050,height/2);
       popMatrix();
  
     
      break;

    
    
  
  }

   // Save a frame!
  videoExport.saveFrame(); 
    
  // End when we have exported enough frames 
  // to match the sound duration.
  if(frameCount > round(movieFPS * movieDuration)) {
    videoExport.endMovie();
    exit();
  }  
}


void drawLogo(int delay) {
  
   
  if (millis() - startTime > startTime + (delay * 1000)){
  
  
  }
  
}

void drawLogoText(int delay) {
  
  if (millis() - startTime > startTime + (delay * 1000)){
  
  
  }
  
  
  
}

void drawfooter() {
  
}

void drawLobby() {
  
  image(background,0,0);
  
}
