#include "cbits.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct test a = {
                 .pNext = NULL,
                 .testField1 = "helloko",
                 .testField2 = "byeko",
                 .testField3 = "aaa"
};

struct test *jam2() {
  return &a;
}

struct bar b = {
                .barfield1 = 3,
                .barfield2 = {
                              .foofield1 = "hello",
                              .foofield2 = "bye"
                              },
                .barfield3 = {
                              .foofield1 = "3hello",
                              .foofield2 = "3bye"
                              },
};
  
struct bar *jam3() {
  return &b;
}

struct bar *bar_alloc() {
  struct bar *temp = malloc(sizeof(struct bar));
  return temp;
}

void write_to_bar(struct bar *mybar) {
  mybar->barfield1 = 4;
  strcpy(mybar->barfield2.foofield1,"hi");
  strcpy(mybar->barfield2.foofield2,"bi");
  strcpy(mybar->barfield3.foofield1,"hi2");
  strcpy(mybar->barfield3.foofield2,"bi2");
}
