# Objects-And-Places
Simple Natural Language Processor in C for given (limited) grammer.

## Description
C program that takes user commands from stdin and outputs messages to stdout and stderr as applicable.
The commands operate on imaginary *objects* and *places*. 
The command language is defined as follows:
 
    command ::= "place" color object destination
              | "clear" place
              | "move" place "to" place
              | "show" place
              | "dump"
              | "reset"
 
    destination ::= "in" container | "on" surface
 
    place ::= container | surface
 
    color ::= "green" | "yellow" | "black" | "white" | "blue" | "red"
 
    object ::= "ball" | "pen" | "eraser" | "phone" | "wallet"
 
    container ::= "pocket" | "bag" | "drawer"
 
    surface ::= "shelf" | "desktop" | "floor"
 
Lexical tokens are separated by one or more spaces (' ').
Possible initial and trailing spaces are ignored. 
Each command is terminated by a linefeed ('\n'). The session is terminated with an EOF.
 
When the program starts, every place is empty. A place can hold only a single object.
 
The semantics of the commands is as follows:
 
    "place" color object destination
        Place a new object of the specified color in the given
        destination. Issue an error message if the destination is
        occupied.
 
    "clear" place
        Remove the contents of the given place. Issue an error message
        if the destination is unoccupied.
 
    "move" place "to" place
        Move the contents of the first place to the second place. Issue
        an error message if the first place is unoccupied or the second
        place is occupied.
 
    "show" place
        Print out the object that is in the given place. If the place is
        empty, print "empty".
 
    "dump"
        Print out every occupied place together with its contents.
 
    "reset"
        Clear every place.
 
 
A sample session:  
 
 dump </br>
 place yellow eraser in pocket </br> 
 dump </br>
 pocket: yellow eraser </br> 
 place black pen on shelf </br>
 move pocket to floor </br>
 show pocket </br>
 empty </br>
 show floor </br>
 yellow eraser </br>
 dump </br>
 floor: yellow eraser </br>
 shelf: black pen </br>
 place red ball in bag </br>
 clear drawer </br>
 ERROR: drawer already empty </br>
 clear floor </br>
 reset </br>
 dump </br>
 ^D </br>

## Solution
The program is created using flex and bison utilities.
* Flex split the word stream into tokens.
* Bison finds the structure within these tokens.

The lexer file is lex.l and parser file is parse.y. 
The flex and bison utilities read these two files and create lex.yy.c and (y.tab.c + y.tab.h) files respectively.
If you want to test after removing lex.yy.c , y.tab.c and y.tab.h files that are created by flex and bison:
Install flex and bison using following commands (for Ubuntu).

1. sudo apt-get install flex
2. sudo apt-get install bison

Run make command to compile the source files and then ./start to start executing.

## Keywords
C, flex, lex, bison, yacc
