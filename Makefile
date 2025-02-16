all:
	gcc -o basix \
		src/main.c \
		src/scanner.c \
		src/basix.c \
		-I src \
		-llua -lespeak-ng

clean:
	rm -rf basix
