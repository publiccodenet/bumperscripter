// import the library
import com.hamoid.*;
import processing.sound.*;
  
// Video Settings
String topic = "Let's talk Public Code";
String guest = "Cool Guest Speaker";
String guestOrganization = "Decidem" ;

// Framerates and VideoExport
float movieFPS = 30;
int movieDuration = 20; // in seconds
VideoExport videoExport;

//Output filename for generated animation in MP4 fileformat
String OutputFile = "publiccodebumper-out.mp4";

// Fonts
PFont fontMulishRegular48, fontMulishSemiBold48, fontMulishBold80;

//Logo and imagedata needed for animation
PShape vectorlogo;
PImage logo, lobbyBackground, liveBadge;
PGraphics canvas, canvas2;
ArrayList< PImage > frames;


//Additional animation calculation variables
float centerX,centerY;
float angle;

//Audiofile for use as background audio
String audioFilename = "publiccodepodcast-sonic-chapter-long.wav";

//Animationstates
final int animateLogo = 0;
final int animateHeader = 1;
final int animateFooter = 2;
final int showLobby = 3;
final int animateLive = 4;

//Timers and state
int startTime;
int timer;
int state = animateLogo;
int remaining;


void setup() {

  //Set video size
  size(1920, 1080);
  //Set anti-aliasing (8x oversampling)
  smooth(8);
  
  //Setup video capturing 
  videoExport = new VideoExport(this, OutputFile);
  videoExport.setFrameRate(movieFPS);
  videoExport.setAudioFileName(audioFilename);
  videoExport.startMovie();

  //Assign media assets
  logo = loadImage("publiccodelogo.png");
  vectorlogo = loadShape("mark.svg");
  lobbyBackground = loadImage("intro-brackground.png");
  liveBadge = loadImage("livebadge.png");
  
  //Load and set the font
  fontMulishRegular48 = loadFont("Mulish-Regular-48.vlw");
  fontMulishSemiBold48 = loadFont("Mulish-SemiBold-48.vlw");
  fontMulishBold80 = loadFont("Mulish-Bold-80.vlw");
  
  //Initialize x,y with center coordinates
  centerX = width/2;
  centerY = width/2;
  startTime = millis();
  remaining = movieDuration;
  
  //create canvas buffer to draw on
  canvas = createGraphics(width, height);
  canvas2 = createGraphics(width, height);
  
  
  
 
  
}
void draw() {
  // set background color
  

  println ("Remaing:" + remaining);
  println ("Timer:" + timer);
  timer = millis()/1000;
  remaining = movieDuration - timer;
  
  switch(timer){
    
    case 1: 
      state = animateLogo;
      println ("STATE:" + state);
      
      break;
      
    case 2:
      state = animateHeader;
      println ("STATE:" + state);
      break;
   
    case 4:
      state = showLobby;
      println ("STATE:" + state);
      break;    
  
  }
  
   
  
 
  switch(state){
    
    case 0: //animateLogo
    
      canvas.beginDraw();
      canvas.background(#FFFFFF);
      angle += 0.05;
      float theta = 3 + (3 * sin(angle)); //DIFFERENCE TO A SMOOTHER OSCILATION
      //THE 3+ IS TO MOVE THE ENTIRE GRAPH UP TO POSITIVE VALUES
      canvas.pushMatrix();
      canvas.translate(width/2, height/2);
      canvas.scale(theta);
      canvas.shape(vectorlogo, -50, -50, 100, 100);
      canvas.popMatrix();
      canvas.endDraw();
      image (canvas,0,0);
      break;
    
    case 1: //animateHeader
    
      background(#FFFFFF);
      image (canvas,0,0);
      fill (0);
      textFont(fontMulishBold80);
      text("Foundation for",centerX-50,centerY);
      text("Public Code",centerX-50,centerY+100);
      
      break;
    
    case 3: //showLobby
     
      image (lobbyBackground,0,0);
      fill (1);
      
      textFont(fontMulishBold80);
      text(topic,750,420);
      
      textFont(fontMulishSemiBold48);
      text(guest,900,720);
      
      text(guestOrganization,900,820);
      
      angle += 0.05;
      theta = 0.5 + (0.5 * sin(angle)); //DIFFERENCE TO A SMOOTHER OSCILATION
      //THE 3+ IS TO MOVE THE ENTIRE GRAPH UP TO POSITIVE VALUES
      
      String tmp = "in " + remaining + " second(s)";
      text(tmp,200,50);
      
      pushMatrix();
      translate(0, 0);
      scale(theta);
      image (liveBadge,10,10);

      popMatrix();
  
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
