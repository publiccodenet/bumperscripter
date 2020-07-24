// import the library
import com.hamoid.*;
import processing.sound.*;
import processing.video.*;
  
// Video Settings
String topic = "Let's talk Public Code";
String guest = "Cool Guest Speaker";
String guestOrganization = "Decidem" ;

//Output filename for generated animation in MP4 fileformat
String OutputFile = "publiccodebumper-out.mp4";


Movie introMovie;

// Framerates and VideoExport
float movieFPS = 30;
int movieDuration = 81; // in seconds
VideoExport videoExport;

// Fonts
PFont fontMulishRegular48, fontMulishSemiBold48, fontMulishBold80;

//Logo and imagedata needed for animation
PShape vectorlogo;
PImage logo, lobbyBackground, liveBadge;


//Additional animation calculation variables
float centerX,centerY;
float theta, angle;


//Audiofile for use as background audio
//String audioFilename = "publiccodepodcast-sonic-chapter-long.wav";
String audioFilename = "publiccodepodcast-leader-long.wav";

//Animationstates
final int animateLogo = 0;
final int animateCrossfade = 1;
final int animateFooter = 2;
final int showLobby = 3;
final int animateLive = 4;

//Timers and state
int startTime;
int timer;
int state = animateLogo;
int remaining;

int fader = 200;

  
void setup() {

  //Set video size
  size(1920, 1080);
  //Set anti-aliasing (8x oversampling)
  smooth();
  
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
  introMovie = new Movie(this, "logo-bumper.mp4");
  
  //Load and set the font
  fontMulishRegular48 = loadFont("Mulish-Regular-48.vlw");
  fontMulishSemiBold48 = loadFont("Mulish-SemiBold-48.vlw");
  fontMulishBold80 = loadFont("Mulish-Bold-80.vlw");
  
  //Initialize x,y with center coordinates
  centerX = width/2;
  centerY = width/2;
  startTime = millis()/1000;
  
    
}
void draw() {
  

  timer = millis()/1000;
   
  switch(timer){
    
    case 0: 
      state = animateLogo;
      break;
      
    case 7:
      state = animateCrossfade;
      break;
   
    case 11:
      state = showLobby;
      break;    
  
  }
  
     
 
  switch(state){
    
    case 0: //animateLogo
      introMovie.play();
      image (introMovie, 0, 0);
      break;
    
    case 1: //animateCrossfade
      if (fader >0) {
        fader = fader - 2;
        tint (255,fader);
        }
      image(introMovie, 0, 0);
      break;
      
    case 3: //showLobby
      if (fader < 256) {
        fader = fader + 3;
        tint (255,fader);
      }
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
      text(tmp,250,50);
      
      pushMatrix();
      translate(0, 0);
      scale(theta);
      image (liveBadge,10,10);

      popMatrix();

  }

   // Save a frame!
  videoExport.saveFrame(); 
  remaining = round(movieDuration-introMovie.duration()-startTime-timer);
    
  // End when we have exported enough frames 
  if(frameCount > round(movieFPS * movieDuration)) {
    videoExport.endMovie();
    exit();
  }  
}

void movieEvent(Movie m) {
  m.read();
}
