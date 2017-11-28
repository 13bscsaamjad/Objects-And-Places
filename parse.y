%{
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>

#define YYSTYPE char *

char data [6][30] = {"","","","","",""};
char *places [6] = {"pocket","bag","drawer","shelf","desktop","floor"};

void yyerror(const char *str) {
	fprintf(stderr,"error: %s\n", str);
}
 
int yywrap() {
	return 1;
}
  
int main() {
	yyparse();
	return 0;
}

int getIndex (char *place) {
	for (int index = 0; index < 6; index++){
	    if (strcmp(place, places[index]) == 0) {
		return index;
	    } 
	}
	return -1;
}

void clearPlace (char *place) {
	int* index = malloc (sizeof(int));
	*index = getIndex(place);

	if (strlen(&data[*index][0]) != 0) {
		strcpy(&data[*index][0], "");
	}
	else {
		fprintf(stderr, "%s %s %s", "ERROR: ", place, "already empty\n");
	}
	free(index);
}

bool isMoveValid (int from, int to) {
	if (strlen(&data[from][0]) == 0) {
		fprintf(stderr, "ERROR: %s is unoccupied\n", places[from]);
		return false;
	}
	if (strlen(&data[to][0]) != 0) {
		fprintf(stderr, "ERROR: %s is occupied\n", places[to]);
		return false;
	}
	return true;
}

void show (char *place) {
	int* index = malloc (sizeof(int));
	*index = getIndex(place);
	
	if (strlen(&data[*index][0]) != 0) {
		printf("%s\n", &data[*index][0]);
	}
	else {
		fprintf(stderr, "%s", "empty\n");
	}

	free(index);
}

void place (char *place, char *tmpData) {
	int* index = malloc (sizeof(int));
	*index = getIndex(place);

	if (strlen(&data[*index][0]) == 0) {
		strcpy(&data[*index][0], tmpData);
	}
	else {
		fprintf(stderr, "ERROR: %s is occupied\n", places[*index]);
	}
	free(index);
}

%}

%token PLACETOK COLOR OBJECT INTOK ONTOK CONTAINER SURFACE CLEARTOK MOVETOK TOTOK SHOWTOK DUMPTOK RESETTOK

%%

commands: /* empty */
	| commands command
	;

command:
    PLACETOK destination
    |
    CLEARTOK place
{	
	clearPlace($2);
};

    |
    MOVETOK place TOTOK place
{
	int from = getIndex($2);
	int to = getIndex($4);

	if (isMoveValid(from, to)) {	
		strcpy(&data[to][0], &data[from][0]);
		strcpy(&data[from][0], "");
	}
};
    |
    SHOWTOK place
{
	show($2);
};
    |
    DUMPTOK
{
	for (int i = 0; i < 6; i++) {
		if (strlen(&data[i][0]) != 0) {
			 printf("%s : %s\n", places[i] , &data[i][0]);
		}
	}
};
	|
	RESETTOK
{
	for (int i = 0; i < 6; i++) {
		strcpy(&data[i][0], "");
	}
};

destination:
    COLOR OBJECT INTOK CONTAINER 
{
	char temp[50] = "";
	strcpy(temp, $1);
	strcat(temp, " ");
	strcat(temp, $2);
	
	place($4, temp);
};
	|
	COLOR OBJECT ONTOK SURFACE
{
	char temp[50] = "";
	strcpy(temp, $1);
	strcat(temp, " ");
	strcat(temp, $2);

	place($4, temp);
};

place:
    CONTAINER
    |
    SURFACE
    ;
%%
