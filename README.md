# publiccodebumper

A script made in Processing 3.0 to generate videopodcast bumper animation.

When producing podcasts you need to present and introduction video for people who are joining the live stream so they know the stream is online and active.

However we cannot use a static video because topics and guests change. In order not to have to produce / render a new video for every episode this script will generate this introduction video automatically. By setting a few variables you can configure how long the video should be, what the topic is and who the guests are. In addition you can also configure the starting animation, background and background music.

## Install
To be able to generate a bumper animation you need to install:
- Processing version 3 or higher
- ffmpeg binary needed to transcode video export stream


### Get source
Clone the source for Github:
`git clone https://github.com/publiccodenet/publiccodebumper.git`

### Download and install Processing
1. Download processing for the operating system your are using: https://processing.org/download/

2. On Windows/MacOS: Go to your download folder and unzip the archive to a directory where you want to install Processing and skip step the reamining steps and follow the instructions on the next paragraph 'Install ffmpeg'

3. On Linux: Download either a tarball from https://processing.org/download/ or use your favorite package manager.

4. Extract the tar ball to the directory where you want to install Processing. Optionally you can run the supplied install.sh script to install icons for your windows manager.

5. After you installed Processing you need to install ffmpeg binary which is required for exporting the video.

### Installing ffmpeg
You need to download and install [FFmpeg](http://ffmpeg.org/) on your system before you can use this script.
Note that you might already have it installed! You can find out by typing ffmpeg or ffmpeg.exe
in the terminal. If the program is not found:

* GNU/Linux systems: use your favorite package manager.
* Windows: get a [static 32bit or 64bit binary](http://ffmpeg.zeranoe.com/builds/)
* Mac: get a [static 64bit binary](http://evermeet.cx/ffmpeg/)

For more details and download links, check the official FFmpeg website: [http://ffmpeg.org](http://ffmpeg.org/)

When you start a Processing sketch that uses this library you may be asked to indicate the location
of your FFmpeg executable. Browse to the location of the ffmpeg executable. (NOTE: ffmpeg is installed by default on a a lot of Linux distributions by default)

For more information about using ffmpeg to export video in Processing please refer to https://github.com/hamoid/video_export_processing

### Installing Required Processing Libraries
1. Start processing
2. In the menu choose: File->Open
3. Navigate to the location where you have cloned the publiccodebumper project and open the 'publiccodebumper.pde' file
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
This is because version 1.0 of the video library in Processing uses gstreamer 0.10.x, which is deprecated an may be missing in your Linux distribution. They are in the process of releasing v2.0 of the library, which has been updated to use gstreamer 1.x. But the new version has not been released on the Contributions Manager.

There are two solutions, you could side load the gstreamer 0.1 library on your system OR install the latest beta of the Video library manually.

Download the video library from this location:

https://github.com/gohai/processing-video/releases/download/v1.0.2/video.zip

Extract the archive. Go to your home/<yourusername>/sketchbook/libraries folder. Rename the video folder to OLD or delete it. Copy the 'video' folder from the extracted archive into the home/<yourusername>/sketchbook/libraries.


## Usage
The script uses a number of variables you can use to

## Technical Implementation notes

The script works as follows:
@TODO

## Contribute

## License
Music is composed by Felix Faassen (https://www.lonebeard.com) and is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.

The script is licensed https://creativecommons.org/publicdomain/zero/1.0/

All other software and libraries have their respective license.

## Resources
Tutorial about exporting videos using ffmpeg with Processing: https://timrodenbroeker.de/processing-tutorial-video-export/
