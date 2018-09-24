#
# Copyright (C) %YEAR% by %USER% <%MAIL%>
# All rights reserved
#

TARGET!=basename `pwd` | sed 's/src\.//'
SOURCES!=ls *.c
OBJECTS=$(SOURCES:.c=.o)

RM=rm -f
CC=gcc

CFLAGS+=-Wall -O2 -I.
LFLAGS+=

%.o:%.c
	$(CC) $(CFLAGS) -c $< -o $@

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) -o $@ $(OBJECTS) $(LFLAGS)

clean:
	$(RM) $(OBJECTS)
	$(RM) $(TARGET)

rebuild: clean all
