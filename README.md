# publiccodebumper

A script made in Processing 3.0 to generate videopodcast bumper animation.

When producing podcasts you need to present and introduction video for people who are joining the live stream so they know the stream is online and active.

However we cannot use a static video because topics and guests change. In order not to have to produce / render a new video for every episode this script will generate this introduction video automatically. By setting a few variables you can configure how long the video should be, what the topic is and who the guests are. In addition you can also configure the starting animation, background and background music.

## Install

To be able to generate a bumper animation you need to install:

- Processing version 3 or higher
- ffmpeg binary needed to transcode video export stream

### Get source

Clone the source for Github: `git clone https://github.com/publiccodenet/publiccodebumper.git`

### Download and install Processing

1. Download processing for the operating system your are using: <https://processing.org/download/>

2. On Windows/MacOS: Go to your download folder and unzip the archive to a folder where you want to install Processing and skip step the reamining steps and follow the instructions on the next paragraph 'Install ffmpeg'

3. On Linux: Download either a tarball from <https://processing.org/download/> or use your favorite package manager.

4. Extract the tar ball to the folder where you want to install Processing. Optionally you can run the supplied install.sh script to install icons for your windows manager.

5. After you installed Processing you need to install ffmpeg binary which is required for exporting the video.

### Installing ffmpeg

You need to download and install [FFmpeg](http://ffmpeg.org/) on your system before you can use this script. Note that you might already have it installed! You can find out by typing ffmpeg or ffmpeg.exe in the terminal. If the program is not found:

- GNU/Linux systems: use your favorite package manager.
- Windows: get a [static 32bit or 64bit binary](http://ffmpeg.zeranoe.com/builds/)
- Mac: get a [static 64bit binary](http://evermeet.cx/ffmpeg/)

For more details and download links, check the official FFmpeg website: [http://ffmpeg.org](http://ffmpeg.org/)

When you start a Processing sketch that uses this library you may be asked to indicate the location of your FFmpeg executable. Browse to the location of the ffmpeg executable. (NOTE: ffmpeg is installed by default on a a lot of Linux distributions by default)

For more information about using ffmpeg to export video in Processing please refer to <https://github.com/hamoid/video_export_processing>

### Installing Required Processing Libraries

1. Start processing
2. In the menu choose: File->Open
3. Navigate to the location where you have cloned the `publiccodebumper` project and open the `publiccodebumper.pde` file
4. In the menu choose: Tools->Add Tools
5. Click on the tab 'Libraries'
6. In the 'filter' input field type 'video'
7. Select the 'Video' library and press the 'Install' button at the lower right corner
8. In the 'filter' input field type 'sound'
9. Select the 'Sound' library and press the 'Install' button at the lower right corner
10. Close the window

You should now be able to run the script by pressing the " PLAY" button at the top left.

On Linux you might get the error:

```
nsatisfiedLinkError: Error looking up function 'gst_date_get_type': /usr/lib/x86_64-linux-gnu/libgstreamer-1.0.so: undefined symbol: gst_date_get_type
UnsatisfiedLinkError: Error looking up function 'gst_date_get_type': /usr/lib/x86_64-linux-gnu/libgstreamer-1.0.so: undefined symbol: gst_date_get_type
A library relies on native code that's not available.
Or only works properly when the sketch is run as a 32-bit application.
UnsatisfiedLinkError: Error looking up function 'gst_date_get_type': /usr/lib/x86_64-linux-gnu/libgstreamer-1.0.so: undefined symbol: gst_date_get_type
```

This is because version 1.0 of the video library in Processing uses gstreamer 0.10.x, which is deprecated and may not be present on your installed Linux distribution. Processing is in the process of releasing v2.0 of the library, which has been updated to use gstreamer 1.x library. But the new version has not been released on the Contributions Manager.

There are two solutions, you could side load the gstreamer 0.10.x library on your system -OR- install the latest beta of the Video library manually.

Download the beta of the video library from this location:

<https://github.com/gohai/processing-video/releases/download/v1.0.2/video.zip>

Extract the archive. Go to your `home/<yourusername>/sketchbook/libraries` folder. Rename the video folder to VIDEO_OLD. Copy the 'video' folder from the extracted archive into the `home/<yourusername>/sketchbook/libraries`. NOTE: Be sure to keep the original video library so you can revert back to the original library version.

## Usage

To use the script. Make sure you followed the installation instructions in the previous paragraph.

In the menu choose: File->Open Navigate to the location where you have cloned the `publiccodebumper` project and open the `publiccodebumper.pde` file and press the PLAY button.

The script will wait 3 seconds and will start create a MP4 video file in the same folder where the Processing script is located. The default filename is "publiccodebumper-out.mp4".

You use this file to play at the beginning of your livestream prerecorded video podcast.

The script has a number of variables you can configure to create a video which fits your needs.

At the top of the `publiccodebumper.pde` script you will find the most important variables. Below is a table with their default value and where the are used for. After changing the variables to your liking you can re-generate the video again until your are satisfied with the result.

Variable                   | Used for                                                               | Notes
-------------------------- | ---------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------
`String topic`             | Set the topic title of the video                                       | If the title is running off-screen you can set `longTitle = true`
`String guest`             | Set the name of the guest(s)                                           |
`String guestOrganization` | Set the name of the organization of the guest                          |
`boolean longTitle`        | When title is too long to fit screen set longTitle to true             | default is `false`
`String OutputFile`        | Set desired output filename for generated animation in MP4 file format |
`String audioFilename`     | Set desired Audiofile for use as background audio                      | You can use audio files in uncompressed WAV (16-bit) or MP3\. Depending on the installed codecs on your machine mmpeg can transcode other formats as well.
`int movieDuration`        | Set the total desired movie duration in seconds

You can customize the script more by changing the introduction bumper as well as the background image and the pulsing live badge. Find the `void setup ()` function and look up the code below. Please note that all external media assets must reside in the `data` sub-folder relative to the location of the Processing script.

```processing
  //Assign media assets

  //Select which logo bumper to use at the beginning
  introMovie = new Movie(this, "logo-bumper-v2.mp4");

  // Logo
  vectorlogo = loadShape("mark.svg");

  // Background image used for waiting lobby
  lobbyBackground = loadImage("intro-brackground.png");
  // Live badge logo
  liveBadge = loadImage("livebadge.png");
```

## Technical Implementation notes

The script works as follows:

1. Create a video export object
2. Play and read each frame of a configureable movie file to start with (your won bumper animation)
3. Export each frame on the video export object
4. Read a configureable background picture
5. Add user configureable text on the background
6. Show a live badge PNG with animation (live badge is also user configurable)
7. When the configured duration has passed save the last frame and exit script.

You can time the above sequence to your likingn in the `switch (timer)` section of the `void draw()` function. This function is called for every frame of the animation. You can also add new animations or Processing code to your liking.

## Contribute

@TODO

## License

Music is composed by Felix Faassen (<https://www.lonebeard.com>) and is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/) license.

The script is licensed <https://creativecommons.org/publicdomain/zero/1.0/>

All other software and libraries have their respective license.

## Resources

- Tutorial about exporting videos using ffmpeg with Processing: <https://timrodenbroeker.de/processing-tutorial-video-export/>
