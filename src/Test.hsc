{-# LANGUAGE ForeignFunctionInterface #-}
module Test where

import Foreign.C
import Foreign.C.String
import Foreign.Storable
import Foreign.Marshal.Array
import Foreign.Ptr
import Data.Word
import Data.Int

#include "cbits.h"

data TestS = TestS { next :: Ptr TestS, field1 :: CString, field2 :: CString, field3 :: String }

instance Storable TestS where
    sizeOf _ = (#size struct test)
    alignment _ = (#alignment struct test)
    peek ptr = do
      pnext <- (#peek struct test, pNext) ptr
      field1 <- (#peek struct test, testField1) ptr
      field2 <- (#peek struct test, testField2) ptr
      field3 <- peekCString $ #{ptr struct test,testField3} ptr
      return $ TestS pnext field1 field2 field3

    poke ptr (TestS pnext sec usec field3) = do
      (#poke struct test, pNext) ptr pnext
      (#poke struct test, testField1) ptr sec 
      (#poke struct test, testField2) ptr usec
      let field3' = field3 ++ "\0";
      withCStringLen field3' $ (\(sptr,len) -> (copyArray (#{ptr struct test, testField3} ptr) sptr len))

foreign import ccall "cbits.h jam2" c_jam2 :: IO (Ptr TestS)

data Foo = Foo { fooField1 :: String, fooField2 :: String }

instance Storable Foo where
    sizeOf _ = (#size struct foo)
    alignment _ = (#alignment struct foo)
    peek ptr = do
      fooField1 <- peekCString $ (#ptr struct foo, foofield1) ptr
      fooField2 <- peekCString $ (#ptr struct foo, foofield2) ptr
      return $ Foo fooField1 fooField2
    poke ptr (Foo field1 field2) = do
      let field1' = field1 ++ "\0";
          field2' = field2 ++ "\0";
      withCStringLen field1' $ (\(sptr,len) -> (copyArray (#{ptr struct foo, foofield1} ptr) sptr len))
      withCStringLen field2' $ (\(sptr,len) -> (copyArray (#{ptr struct foo, foofield2} ptr) sptr len))

data Bar = Bar { barField1 :: CInt, barField2 :: Ptr Foo, barField3 :: Ptr Foo }

instance Storable Bar where
    sizeOf _ = (#size struct bar)
    alignment _ = (#alignment struct bar)
    peek ptr = do
      barField1 <- (#peek struct bar, barfield1) ptr
      let barField2 = (#ptr struct bar, barfield2) ptr
      let barField3 = (#ptr struct bar, barfield3) ptr
      return $ Bar barField1 barField2 barField3 
    poke ptr b@(Bar field1 field2 field3) = do
      (#poke struct bar, barfield1) ptr field1
      field2' <- peek field2                              
      poke (barField2 b) field2'
      field3' <- peek field3
      poke (barField3 b) field3'

foreign import ccall "cbits.h jam3" c_jam3 :: IO (Ptr Bar)
