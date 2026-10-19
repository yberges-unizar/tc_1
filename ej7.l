%{
	#include <stdio.h>
	#include <string.h>


%}

%%
B[C]*E {printf("[F_3]BE[F_3]"); }
B[C]*(P[C]*P[C]*P[C]*)+E {
	printf("[OK]");
	for(int i =0; i < yyleng; i++){
		if(yytext[i] != 'C'){
			printf("%c", yytext[i]);
		}
	}
	printf("[OK]");

}

B[C]*P[C]*([P[C]*P[C]*P[C]*)*E {
	printf("[F_1]");
	for(int i =0; i < yyleng; i++){
		if(yytext[i] != 'C'){
			printf("%c", yytext[i]);
		}
	}
	printf("[F_1]");

}

B[C]*P[C]*P[C]*(P[C]*P[C]*P[C]*)*E {
	printf("[F_2]");
	for(int i =0; i < yyleng; i++){
		if(yytext[i] != 'C'){
			printf("%c", yytext[i]);
		}
	}
	printf("[F_2]");

}

%%