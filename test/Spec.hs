{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

import Data.Bits
import Data.Int (Int32)
import Data.Int
import Data.Word (Word8)
import Foreign.C.String
import Foreign.C.Types
import Foreign.Marshal.Array
import Foreign.Ptr
import Foreign.Storable
import Test
import Test.Hspec

main :: IO ()
main = hspec $ do structPlay

structPlay :: SpecWith ()
structPlay = do
  describe "struct play" $ do
    it "1st test" $ do
      test <- c_jam2
      testPtr :: TestS <- peek test
      f1 <- peekCString $ field1 testPtr
      f2 <- peekCString $ field2 testPtr
      let f3 = field3 testPtr
      f1 `shouldBe` "helloko"
      f2 `shouldBe` "byeko"
      f3 `shouldBe` "aaa"
      let newTest :: TestS = testPtr {field3 = "x"}
      poke test newTest
      testPtr2 <- peek test
      f1 <- peekCString $ field1 testPtr2
      f2 <- peekCString $ field2 testPtr2
      let f3 = field3 testPtr2
      f1 `shouldBe` "helloko"
      f2 `shouldBe` "byeko"
      f3 `shouldBe` "x"
    it "nested struct" $ do
      test <- c_jam3
      barValue :: Bar <- peek test
      barField1 barValue `shouldBe` 3
      let bf2 = barField2 barValue
          bf3 = barField3 barValue
      bf2Val :: Foo <- peek bf2
      bf3Val :: Foo <- peek bf3
      (fooField1 bf2Val) `shouldBe` "hello"
      (fooField2 bf2Val) `shouldBe` "bye"
      (fooField1 bf3Val) `shouldBe` "3hello"
      (fooField2 bf3Val) `shouldBe` "3bye"
      let newFoo = Foo "abc" "def"
      poke bf2 newFoo
      bf2Val' <- peek bf2
      (fooField1 bf2Val') `shouldBe` "abc"
      (fooField2 bf2Val') `shouldBe` "def"
