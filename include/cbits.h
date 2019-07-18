struct test {
  struct test *pNext;
  char * testField1;
  char * testField2;
  char testField3[3];
};

struct test *jam2();

/* Nested example */

struct foo {
  char foofield1[10];
  char foofield2[10];
};

struct bar {
  int barfield1;
  struct foo barfield2;
  struct foo barfield3;
};

struct bar *jam3();

struct bar *bar_alloc();

void write_to_bar(struct bar *mybar);
