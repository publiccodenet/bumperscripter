# Bumperscripter

[![bumperscripter badge](https://publiccodenet.github.io/publiccodenet-url-check/badges/bumperscripter.svg)](https://publiccodenet.github.io/publiccodenet-url-check/url-check-fails.json)

A script made in [Processing 3.0](https://processing.org) to easily generate variations of a livestreamed video bumper animation.

When producing livestreams you want an introduction video for people who are joining the livestream so they know that the stream is online, active and about to start.

You could use the same video every time but it would be better to customize it since topics and guests may change.
To simplify the production of a new video for every episode, this script will generate a introduction video automatically.
By setting a few variables you can configure how long the video should be, what the topic is and who the guests are.
In addition you can also customize the starting animation, logo, background and background music to fit whatever show you might have.

## Install

To be able to generate a bumper animation you need to install:

- Processing, version 3 or higher
- ffmpeg binary (needed to transcode video export stream)

If you already have these installed you can skip directly to [Get source](#get-source).

### Download and install Processing

1. Download Processing for the operating system your are using at: <https://processing.org/download/>
2. On Windows/MacOS: Go to your download folder and unzip the archive to a folder where you want to install Processing and skip step the reamining steps and follow the instructions on the next paragraph [Install FFmpeg](#installing-ffmpeg)
3. On Linux: Download either a tarball from <https://processing.org/download/> or use your favorite package manager. Extract the tar ball to the folder where you want to install Processing. Optionally you can run the supplied install.sh script to install icons for your windows manager.

### Installing FFmpeg

You need to download and install [FFmpeg](http://ffmpeg.org/) on your system before you can use the Bumperscripter.
Note that you might already have it installed!
You can find out by typing ffmpeg or ffmpeg.exe in the terminal.
If the program is not found:

- GNU/Linux systems: use your favorite package manager.
- Windows: get a [static 32bit or 64bit binary](https://ffmpeg.org/download.html)
- Mac: get a [static 64bit binary](http://evermeet.cx/ffmpeg/)

For more details and download links, check the official FFmpeg website: [http://ffmpeg.org](http://ffmpeg.org/)

When you start a Processing sketch that uses this library you may be asked to indicate the location of your FFmpeg executable.
Browse to the location of the ffmpeg executable.
(NOTE: ffmpeg is installed on a lot of Linux distributions by default.)

For more information about using ffmpeg to export video in Processing please refer to: [https://github.com/hamoid/video_export_processing](https://github.com/hamoid/video_export_processing).

### Get source

Clone the source for Github: `git clone https://github.com/publiccodenet/bumperscripter.git`

### Installing required Processing libraries

1. Start Processing
2. In the menu choose: File->Open
3. Navigate to the location where you have cloned the `bumperscripter` project and open the `bumperscripter.pde` file
4. In the menu choose: Tools->Add Tools
5. Click on the tab 'Libraries'
6. In the 'Filter' input field type 'video'
7. Select the 'Video' library and press the 'Install' button at the lower right corner
8. Select the 'Video Export' library and press the 'Install' button at the lower right corner
9. In the 'Filter' input field type 'sound'
10. Select the 'Sound' library and press the 'Install' button at the lower right corner
11. Close the window

You should now be able to run the script by pressing the ▶️ (Run) button at the top left corner.

On Linux you might get the error:

```
UnsatisfiedLinkError: Error looking up function 'gst_date_get_type': /usr/lib/x86_64-linux-gnu/libgstreamer-1.0.so: undefined symbol: gst_date_get_type
UnsatisfiedLinkError: Error looking up function 'gst_date_get_type': /usr/lib/x86_64-linux-gnu/libgstreamer-1.0.so: undefined symbol: gst_date_get_type
A library relies on native code that's not available.
Or only works properly when the sketch is run as a 32-bit application.
UnsatisfiedLinkError: Error looking up function 'gst_date_get_type': /usr/lib/x86_64-linux-gnu/libgstreamer-1.0.so: undefined symbol: gst_date_get_type
```

This is because version 1.0 of the video library in Processing uses gstreamer 0.10.x, which is deprecated and may not be present on your installed Linux distribution.
Processing is in the process of releasing v2.0 of the library, which has been updated to use gstreamer 1.x library.
But the new version has not been released on the Contributions Manager yet.

There are two solutions; you could sideload the gstreamer 0.10.x library on your system -OR - install the latest beta of the Video library manually.

Download the beta of the video library from this location:

<https://github.com/gohai/processing-video/releases/download/v1.0.2/video.zip>

Extract the archive.
Go to your `home/<yourusername>/sketchbook/libraries` folder.
Rename the video folder to VIDEO_OLD.
Copy the 'video' folder from the extracted archive into the `home/<yourusername>/sketchbook/libraries`.
NOTE: Be sure to keep the original video library so you can revert back to the original library version if needed.

## Using Bumperscripter

To use Bumperscripter, make sure you followed the installation instructions in the previous paragraph.

In the menu choose: File->Open Navigate to the location where you have cloned the `bumperscripter` project and open the `bumperscripter.pde` file and press the ▶️ (Run) button.

The script will wait 3 seconds and will start create a MP4 video file in the same folder where the Processing script is located.
The default filename is "bumperscripter-out.mp4" but it can be changed (see below).

The file output is the one to play at the beginning of your livestreamed video.

The script has a number of variables you can configure to create a video which fits your needs.

At the top of the `bumperscripter.pde` script you will find the most important variables.
Below is a table with their default value and what they are used for.
After changing the variables to your liking you can generate the video again, repeating until you are satisfied with the result.

Variable            | Type    | Used for                                                               | Notes
--------------------|---------| ---------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------
`topic`             | String  | Set the topic title of the video                                       | If the title is running off-screen you can set `longTitle = true`
`guest`             | String  | Set the name of the guest(s)                                           |
`guestOrganization` | String  | Set the name of the organization of the guest                          |
`longTitle`         | boolean | When title is too long to fit screen set longTitle to true             | default is `false`
`OutputFile`        | String  | Set desired output filename for generated animation in MP4 file format |
`audioFilename`     | String  | Set desired Audiofile for use as background audio                      | You can use audio files in uncompressed WAV (16-bit) or MP3\. Depending on the installed codecs on your machine mmpeg can transcode other formats as well.
`movieDuration`     | int     | Set the total desired movie duration in seconds                        |

You can customize the script more by changing the introduction movie as well as the following background image and the pulsing live badge.
Find the `void setup ()` function and look up the code below.
Please note that all external media assets must reside in the `data` sub-folder relative to the location of the Processing script.

```processing
  //Assign media assets

  //Select which logo bumper to use at the beginning
  introMovie = new Movie(this, "intro-video.mp4");

  // Background image used for waiting lobby
  lobbyBackground = loadImage("intro-background.png");
  // Live badge logo
  liveBadge = loadImage("livebadge.png");
```

## Technical implementation notes

The script works as follows:

1. Create a video export object
2. Play and read each frame of a configureable movie file to start with (your own bumper animation)
3. Export each frame on the video export object
4. Read a configureable background picture
5. Add user configureable text on the background
6. Show a live badge PNG with animation (live badge is also user configurable)
7. When the configured duration has passed save the last frame and exit script.

You can time the above sequence to your liking in the `switch (timer)` section of the `void draw()` function.
This function is called for every frame of the animation.
You can also add new animations or Processing code to your liking.

## Contribute

We would be delighted if you want to contribute.
Take a look at [CONTRIBUTING](CONTRIBUTING.md) for details on how to do that.
The [GOVERNANCE](GOVERNANCE.md) explains how decions are made in this repository.
We require you to follow our [CODE OF CONDUCT](CODE_OF_CONDUCT.md) when contributing.

## License

The script is [licensed](LICENSE.md) [Creative Commons Zero](https://creativecommons.org/publicdomain/zero/1.0/).

All other software and libraries have their respective license.

While not required under the license, we would love to see examples of the bumpers you create with this script.
Please [ping us on Twitter](https://twitter.com/publiccodenet) with a link to your livestreamed video.
We will add links to the ones we like most in this repository.

### Attribution

Example media is all licensed [CC 0](https://creativecommons.org/publicdomain/zero/1.0).
* Music: [Chill Out Theme](https://freemusicarchive.org/music/Komiku/Its_time_for_adventure__vol_2/Komiku_-_Its_time_for_adventure_vol_2_-_02_Chill_Out_Theme) by [Komiku](https://freemusicarchive.org/music/Komiku/) (shortened)
* Video: [Spain Metro tunnel](https://commons.wikimedia.org/wiki/File:Spain_Metro_tunnel.webm) by [tiburi](https://pixabay.com/en/users/tiburi-2851152/?tab=videos) (slowed down, fade and blur added)
* Graphic: [Trains icons (evolution) SVG](https://commons.wikimedia.org/wiki/File:Trains_icons_(evolution)_SVG.svg) by [Sameboat](https://commons.wikimedia.org/wiki/User:Sameboat), [Richtom80](https://en.wikipedia.org/wiki/User:Richtom80) and [Offnfopt](https://commons.wikimedia.org/wiki/User:Offnfopt)

## Resources

- Tutorial about exporting videos using ffmpeg with Processing: <https://timrodenbroeker.de/processing-tutorial-video-export/>
