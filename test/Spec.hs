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
      testPtr <- peek test
      f1 <- peekCString $ field1 testPtr
      f2 <- peekCString $ field2 testPtr
      f3 <- peekCString $ field3 testPtr
      f1 `shouldBe` "helloko"
      f2 `shouldBe` "byeko"
      -- f3 `shouldBe` "AAA"
