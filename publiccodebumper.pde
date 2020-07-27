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

//Set desired Audiofile for use as background audio
//String audioFilename = "publiccodepodcast-sonic-chapter-long.wav";
String audioFilename = "publiccodepodcast-leader-long.wav";

//Set desired movie duration in seconds
int movieDuration = 90; // in seconds


// Framerates and VideoExport
float movieFPS = 29.97;

//Movie object for intro movie bumper playback
Movie introMovie;

// VideoExport Object for exporting through ffmpef
VideoExport videoExport;

// Fonts
PFont fontMulishRegular48, fontMulishSemiBold48, fontMulishBold80;

//Logo and imagedata needed for animation
PShape vectorlogo;
PImage lobbyBackground, liveBadge;


//Additional animation calculation variables
float centerX,centerY;
float theta, angle;

//Animation states
final int animateLogo = 0;
final int animateCrossfade = 1;
final int showLobby = 2;

//Timers and state
int startTime;
int timer;
int remaining;
int introMovieTimeOffset;

// Initial opacity value for fader (128 = 50%, 255=100%)
int fader = 200;


//set initial starting state to begin movie with 
int state = animateLogo;

String remainingStr;

//Setup is run once. Initialization and setup of objects is done here  
void setup() {

  //Set video size
  size(1920, 1080);
  //Set anti-aliasing (8x oversampling)
  smooth();
  
  //Setup video object for exporting through ffmpeg 
  videoExport = new VideoExport(this, OutputFile);
  videoExport.setFrameRate(movieFPS);
  videoExport.setAudioFileName(audioFilename);
  videoExport.startMovie();
  
  //Assign media assets
  vectorlogo = loadShape("mark.svg");
  lobbyBackground = loadImage("intro-brackground.png");
  liveBadge = loadImage("livebadge.png");
  introMovie = new Movie(this, "logo-bumper.mp4");
  
  //Setup video bumper framereate
  introMovie.frameRate(movieFPS);
  
  //Load and set the font
  fontMulishRegular48 = loadFont("Mulish-Regular-48.vlw");
  fontMulishSemiBold48 = loadFont("Mulish-SemiBold-48.vlw");
  fontMulishBold80 = loadFont("Mulish-Bold-80.vlw");
  
  //Set fill color to black for text fonts
  fill (1);
  
  //Initialize x,y with center coordinates
  centerX = width/2;
  centerY = width/2;
  startTime = millis()/1000;
   
}

//Draw is called every frame
void draw() {
   
  //Depending on the timer start a new animation
  switch(timer){
    
    case 0: //Play the intro bumper from 0
      state = animateLogo;
      break;
      
    case 7: // Start the crossfade at 7 seconds
      state = animateCrossfade;
      break;
   
    case 9: // Show the title and guest on the Lobby screen at 9 seconds
      state = showLobby;
      break;    
  
  }
     
  //Based on the animation state draw the specific animation
  switch(state){ 
    
    case 0: //animateLogo
      introMovie.play();
      //introMovieTimeOffset = round(introMovie.duration());
      image (introMovie, 0, 0);
      break;
    
    case 1: //animateCrossfade
      if (fader >0) {
        fader = fader - 2;
        tint (255,fader);
        }
      image(introMovie, 0, 0);
      break;
      
    case 2: //showLobby
      if (fader < 256) {
        fader = fader + 3;
        tint (255,fader);
      }
      // Set the background
      image (lobbyBackground,0,0);     
      
      // Write the title and guest(s)
      textFont(fontMulishBold80);
      text(topic,750,420);
      
      // Write the guests
      textFont(fontMulishSemiBold48);
      text(guest,900,720);
      
      // Write the organization
      text(guestOrganization,900,820);
      
      int seconds = remaining % 60;
      int minutes = (remaining / 60) % 60;
      
      if ( seconds < 10){
        remainingStr = "in " + minutes + ":0" + seconds; 
      
      }
      else {
        
        remainingStr = "in " + minutes + ":" + seconds; 
      
      }
      
      
      text(remainingStr,250,50);

      // Animate the Live blinking badge
      angle += 0.05;
      theta = 0.5 + (0.5 * sin(angle)); //DIFFERENCE TO A SMOOTHER OSCILATION//Animate the 
      pushMatrix();
      translate(0, 0);
      scale(theta);
      image (liveBadge,10,10);
      popMatrix();

  }
  
  //Update the timer in seconds
  timer = round (millis()/1000);
  
  // Calculate seconds remaining until end of movie
  remaining = round(movieDuration-(frameCount/movieFPS));
     
   // Save a frame to the export movie object
  videoExport.saveFrame(); 

   // End when we have exported enough frames 
  if(frameCount > round(movieFPS * movieDuration )) {
    videoExport.endMovie();
    exit();
  }  
}

//Read every frame of IntroMovie
void movieEvent(Movie m) {
  m.read();
}

void MsConversion(int MS)

{
int totalSec= (MS / 1000);
int seconds = (MS / 1000) % 60;
int minutes = (MS / (1000*60)) % 60;
int hours = ((MS/(1000*60*60)) % 24);                      

String HumanTime= (hours+": " +minutes+ ": "+ seconds);
println (HumanTime);
}
