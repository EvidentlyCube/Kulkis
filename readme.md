![Kulkis logo](.readme/logo.png?raw=true)

[![Kulkis Screen 1](.readme/screen_1_thumb.png?raw=true)](.readme/screen_1.png?raw=true) [![Kulkis Screen 2](.readme/screen_2_thumb.png?raw=true)](.readme/screen_2.png?raw=true) [![Kulkis Screen 3](.readme/screen_3_thumb.png?raw=true)](.readme/screen_3.png?raw=true) [![Kulkis Screen 4](.readme/screen_4_thumb.png?raw=true)](.readme/screen_4.png?raw=true) [![Kulkis Screen 5](.readme/screen_5_thumb.png?raw=true)](.readme/screen_5.png?raw=true)

Kulkis is an arcade game about a ball bouncing up'n'down and destroying colorful blocks. It's a fun coffee-breaker that can be completed in a single sitting.

This repository contains the freely available source code and assets for the game by [Evidently Cyue](https://www.evidentlycube.com) (formerly Retrocade.net).

# General info

## Meta

 * **Title**: Kulkis
 * **Technology:** ActionScript 3.0, Flash
 * **First release date:** Apr 19, 2011
 * **Play the game:** 
   * **Web (flash):** https://evidentlycube.itch.io/kulkis
   * **Desktop (WIN):** https://evidentlycube.itch.io/kulkis
 * **Homepage:** https://www.evidentlycube.com/games/kulkis
 * **Opensoure resources:** hhttps://www.evidentlycube.com/open-source/kulkis
 * **License:**
   * **Source code:** [MIT](https://opensource.org/licenses/MIT)
   * **Levels:** [CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/legalcode)
   * **Art:** [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/legalcode)
   * **Music:** [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) by [RoccoW](http://freemusicarchive.org/music/RoccoW/)
 * **Who to credit:**
   * **Source Code:** Evidently Cube
   * **Art:** Aleksander Kowalczyk, Evidently Cube

## Licensing

File LICENSE.txt contains the actual body of the license for Source Code, Artworks and Sound Effects for the project. If any text file is licensed by someone else in a different manner the text of the license will be at the top of the file. Non-text file licenses are presented in a format `<filename>.<extension>.LICENSE.txt`, eg. `music.mp3.LICENSE.txt`. Alternatively `LICENSE.txt` might exist in a directory - in this case this license covers the whole contents of the directory and its subdirectories. 

## Supporting Evidently Cube

The simplest way is to either donate to this project via [Itch.io](https://evidentlycube.itch.io/kulkis) or donate/buy any of our [other projects](https://evidentlycube.itch.io/).

## More Projects

Evidently Cube is at the slow process of releasing the source code and graphical assets of almost all of their old projects. If you're interested in other games please visit [this page](https://www.evidentlycube.com/open-source/archive).

## File Formats

In case you encounter arcane and unknown file formats here are the tools you might need:

 * **PMP** - [Pro Motion project file, by Cosmigo](http://www.cosmigo.com/promotion/index.php)
 * **RWD** - [Real Draw project file, by Media Chance](http://www.mediachance.com/realdraw/)
 * **FLP** - [Fruity Loops project file, by Image-Line](https://www.image-line.com/flstudio/)
 * **MOD** - [Module Tracker music](https://en.wikipedia.org/wiki/MOD_(file_format))

# Kulkis

## How to build the project

Open `build.cmd` in your text editor, update `MXMLC_PATH` variable with the path to Flex SDK (it should support at least Flash Player 10.1), and then run `build.cmd`. If you're on a non-windows o/s the commands used in the file should still work fine so you can use them as basis.

## Making levels

Unfortunately the level editor used for creating levels got lost. If you'd like to make new ones you'll have to use one of your choice (eg. Ogmo Editor or Tiled) and write your own code for parsing the level format. Alternatively at some point Kulkis 1.5 will also be released and it includes an Ogmo Editor project and levels and feature wise pretty much everything in Kulkis is also in Kulkis 1.5.
