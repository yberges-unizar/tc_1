%{
    #include <stdio.h>
    char* ip_address;
%}

OCTET_IP ((2[0-4][0-9])|(25[0-5])|(1[0-9][0-9])|([0-9][0-9])|([0-9]))
METHOD (GET)|(POST)|(PUT)|(DELETE)
PATH "/"[^ ]*" "

%%

^{OCTET_IP}[.]{OCTET_IP}[.]{OCTET_IP}[.]{OCTET_IP}" "{METHOD}" "

%%

int main() {
    int status = yylex();
    return status;
}