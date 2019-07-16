
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


  
