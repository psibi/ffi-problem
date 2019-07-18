#include "cbits.h"
#include <stdio.h>

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
