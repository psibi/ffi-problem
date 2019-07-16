#include <sys/select.h>

struct test {
  struct test *pNext;
  char * testField1;
  char * testField2;
  char testField3[3];
};

struct test *jam2();
