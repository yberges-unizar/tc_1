%{
    #include <stdio.h>
    #include <string.h>

    int column_number = 0;
    int processed_lines = 0;
    int successful_requests = 0;
    int unsuccessful_requests = 0;
    int api_requests = 0;
    enum {
        IP_ADDRESS_COLUMN_NUMBER,
        METHOD_COLUMN_NUMBER,
        PATH_COLUMN_NUMBER,
        STATUS_CODE_COLUMN_NUMBER,
        RESPONSE_TIME_COLUMN_NUMBER
    };

    char *ip_address;
    char *method;
    char *path;
    char *status_code;
    char *response_time;
%}

%%
^[0-9a-zA-Z/]+" "|\n {
    switch (column_number) {
        case IP_ADDRESS_COLUMN_NUMBER:
            ip_address = yytext;
            break;
        case METHOD_COLUMN_NUMBER:
            method = yytext;
            break;
        case PATH_COLUMN_NUMBER:
            path = yytext;
            break;
        case STATUS_CODE_COLUMN_NUMBER:
            status_code = yytext;
            break;
        case RESPONSE_TIME_COLUMN_NUMBER:
            response_time = yytext;
            break;
    }
    column_number++;
}

\n {
    column_number = 0;
    processed_lines++;

    if ((status_code == "400") || (status_code == "500")) {
        ip_address = "[ANON]";
        unsuccessful_requests++;
    } else {
        successful_requests++;
    }

    if (path == "/api/") {
        api_requests++;
    }

    printf("%s, %s, %s, %s, %s\n", ip_address, method, path, status_code, response_time);
}
%%

int main() {
    int status = yylex();
    if (status == 0) {
        printf("\nP: %d\nS: %d\nE: %d\nA: %d", processed_lines, successful_requests, unsuccessful_requests, api_requests);
    }
    return status;
}