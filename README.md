# Welcome to the PoECraftingSimulator wiki!

More detailed information about PoECraftingSimulator can be found on this page.

## PoE - Path of Exile [official website](https://www.pathofexile.com)
Is a game designed by GGG (Grinding Gear Games). That runs an in game season roughly every 3 months, in which the game content is updated. The game itself is a mix of ARPG and hack/slash where you progress through maps and acquire "currency" items to be able to craft your own gear.

## Purpose of the program
Some of the in-game currency are rare and take a lot of time to acquire which limits the amount of people who have experience in using them and making them scared of "wasting" currency that they have spent a lot of time acquiring. The purpose of this program is to enable a testing ground for players for using currency and giving them some self confidence in using them.

## Current state
Currently the program is limited to weapons only and the odds for all the stats that the item can get are the same. So you can't use the program as a reference to what crafting would be in game. The program has been designed so that it is relatively easy to add the odds to the database and thus making it viable to be used. That is one of the next points in the program development.

## Graphical content & Images
Some of the images are taken from free image repositories, but mostly are taken from official game website, thus GGG maintains the rights to those images. The game content is kinda dark and since the crafting system mimics of the game so I tried to make the item display and theme as close to that one as possible.

## Program content
* Missing web server - so the database file isn't currently within the program so it's to be added to the program manually currently aka the program doesn't work without it (file in web would enable easier db updates and the installation is faster since the database file doubles the program size)
* Database contains 200+ SQLite tables which store the various item stats (base item, prefixes, suffixes etc.). 
* Asynchronously downloads the necessary images.
* Persist data - saves the program state to a file on exit and loads on start up
* Data manager - saving item data and loading it from file
* Element sizes - are made by using constraints so they mostly scale with the used device. Further testing is needed.
