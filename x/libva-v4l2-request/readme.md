 I've been following @xmixahlx work on pbp-tools.  I have an rk3399 board we're developing in house (kind of) and I'm tasked with seeing what it takes to get the VPU working.  Our build system won't work with the pbp scripts but I extraced the useful bits (urls, patches, etc.) from them to get a build working with the following components.  I also wrote a BASH test script for doing validation (see link below) up to and including attempting to decode and encode to the NULL device with ffmpeg.  I'm not getting the output I'm expecting and was wondering if I've missed a step.

 

This is what I have now.  This is the order I build them as well.

        1. Linux 5.8.5 w/local config plus pbp patch
            a. url: https://github.com/xmixahlx/pbp-tools/tree/master/resources/linux/5.8
            b. linux-5.8-rc4-hwaccel_20200709.diff
        2. v4l2-utils 1.20.0 (no patches)
        3. libva (git master) with patches
            a. url: https://patch-diff.githubusercontent.com/raw/intel/libva/pull/
            b. 332.patch
            c. 340.patch
            d. patches edited based on https://github.com/xmixahlx/pbp-tools/blob/master/pbp-install-libva
        4. libva-v4l2-request (git master) with patches
            a. url: https://patch-diff.githubusercontent.com/raw/bootlin/libva-v4l2-request/pull/
            b. 30.patch
            c. 32.patch
            d. Why not 28, 29 too? (31 doesn't exist: https://github.com/bootlin/libva-v4l2-request/pulls) - I think I found these may not be needed after all, but can't remember now why I left them out.
        5. libva-utils (git master, no patches)
        6. ffmpeg n4.3.1 with patches
            a. url: https://raw.githubusercontent.com/xmixahlx/pbp-tools/master/resources/ffmpeg/4.3/
            b. ffmpeg-4.3-v4l2request-rkvdec_20200709.diff
        7. v4l2-request-test (git master, no patches)
 

The test script, which I linked at the bottom of this post, is mostly just printing out what my setup looks like and responses to various v4l2, va and ffmpeg commands suggested here, the pbp forum and for ffmpeg.  I run it like this: 


        4. libva-v4l2-request (git master) with patches
            https://github.com/atomlong/libva-v4l2-request-git/blob/master/PKGBUILD
        6. ffmpeg 4.4
            https://github.com/jernejsk/FFmpeg
            branch: 4l2-request-hwaccel-4.4

