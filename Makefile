all:
	gcc -o basix \
		src/main.c \
		src/basix.c \
		src/scanner.c \
		src/chunk.c \
		-lespeak-ng

clean:
	rm -rf basix