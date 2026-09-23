%{
    #include <stdio.h>

    int hit_counter = 0;
%}

%%
hotmail {hit_counter++; printf("%s", yytext);}
%%

int main() {
    int status = yylex();
    if (status == 0) {
        printf("\nTotal hotmail: %d\n", hit_counter);
    }
    return status;
}