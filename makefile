.RECIPEPREFIX = >
MAKEFLAGS += --no-builtin-rules
###############
## VARIABLES ##
###############
CFLAGS = -MMD -Wall -Wextra -Werror -g3
CC = gcc
CC = clang
ADRESS_SANITIZER = -fsanitize=address
LINKER = $(CC)
ANALYZER = -fanalyzer
NAME = lem_in

# Conditionally add the analyzer flag if CC is "gcc"
ifeq ($(CC),gcc)
    CFLAGS += $(ANALYZER)
endif
CFLAGS		+=	$(ADRESS_SANITIZER) 
# CFLAGS		+=	-DNDEBUG

# LDFLAGS		+=	$(ADRESS_SANITIZER) 
LDLIBS = -lasan

SRC/SOURCES  = $(wildcard src/*.c)
OBJ/OBJECTS	= $(patsubst src/%.c, obj/%.o, $(SRC/SOURCES))
OBJ/DEPS	= $(patsubst %.o, %.d, $(OBJ/OBJECTS))

############
## RULES  ##
############
all:   $(NAME) 

# Reminder : LDFLAGS (-L) must come before object files and LDLIBS !
$(NAME): ${OBJ/OBJECTS}
> $(LINKER) $(LDFLAGS) $^ $(LDLIBS) -o $@

obj/%.o: src/%.c ${DEPS} | obj
> ${CC} ${CFLAGS} -c $< -o $@

-include $(OBJ/DEPS)

obj:   
> mkdir obj

clean:   
> rm -rf obj

fclean: clean
> rm -rf $(NAME)

re: fclean all

print_name:
> @echo $(NAME)

.PHONY: all clean fclean re print_name
