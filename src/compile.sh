bison -d ./src/Parser.y
mv Parser.tab.h ./src/Parser.h
mv Parser.tab.c ./src/Parser.y.c
flex ./src/Parser.lex
mv lex.yy.c ./src/Parser.lex.c
gcc -g -c ./src/Parser.lex.c -o ./src/Parser.lex.o
gcc -g -c ./src/Parser.y.c -o ./src/Parser.y.o
gcc -g -o ./src/Parser ./src/Parser.lex.o ./src/Parser.y.o -lfl
