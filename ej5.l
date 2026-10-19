%{
    #include <stdio.h>
    #include <stdbool.h>
    char* ip_address;
    char* method;
    char* response_time;
    char* path;
    char* status_code;
    int success_status_code_count;
    int error_status_code_count;
    int api_path_count;
    int request_count;
    bool success_status_code;
%}

OCTET_IP ((2[0-4][0-9])|(25[0-5])|(1[0-9][0-9])|([0-9][0-9])|([0-9]))
METHOD (GET)|(POST)|(PUT)|(DELETE)
PATH "/"[^ ]*
API_PATH "/api/"[^ ]*
SUCCESS_STATUS_CODE (2[0-9][0-9])
ERROR_STATUS_CODE ([4,5][0-9][0-9])
RESPONSE_TIME ([0-9]+ms)
BLANK_SPACES ([ \t]|\n)

%%

{OCTET_IP}[.]{OCTET_IP}[.]{OCTET_IP}[.]{OCTET_IP} {ip_address = strdup(yytext);}
{METHOD} {method = strdup(yytext);}
{API_PATH} {path = strdup(yytext); api_path_count++;}
{PATH} {path = strdup(yytext);}
{SUCCESS_STATUS_CODE} {status_code = strdup(yytext); success_status_code_count++; success_status_code = true;}
{ERROR_STATUS_CODE} {status_code = strdup(yytext); error_status_code_count++; success_status_code = false;}
{BLANK_SPACES}
{RESPONSE_TIME} {
    response_time = strdup(yytext);
    request_count++;
    if (success_status_code) {
        printf("%s", ip_address);
    } else {
        printf("[ANON]");
    };
    printf(" %s %s %s %s\n", method, path, status_code, response_time);
}


%%

int main() {
    int status = yylex();
    printf("P: %d\n", request_count);
    printf("S: %d\n", success_status_code_count);
    printf("E: %d\n", error_status_code_count);
    printf("A: %d\n", api_path_count);
    return status;
}