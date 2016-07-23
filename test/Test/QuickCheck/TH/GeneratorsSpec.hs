{-# LANGUAGE TemplateHaskell #-}
module Test.QuickCheck.TH.GeneratorsSpec (tests) where

import Test.QuickCheck.TH.Generators

import Test.Tasty
import Test.Tasty.QuickCheck as QC
import Test.Tasty.HUnit
import Language.Haskell.TH
import Data.List
import Data.Ord



-- | These example types should build arbitrary instances correctly 

data ExampleSumTypes = ExampleSum0 
                    | ExampleSum1 Int
                    | ExampleSum2 Int Int
                    | ExampleSum3 Int Int Int
                    | ExampleSum4 Int Int Int Int
                    | ExampleSum5 Int Int Int Int Int
                    | ExampleSum6 Int Int Int Int Int Int
                    | ExampleSum7 Int Int Int Int Int Int Int
 deriving (Show,Ord,Eq)

data ExampleProductType = ExampleProductType { field1 :: Int,
                                            field2 :: Int }
  deriving (Show,Ord,Eq)

makeArbitrary ''ExampleSumTypes
makeArbitrary ''ExampleProductType

instance Arbitrary ExampleSumTypes where
  arbitrary = arbitraryExampleSumTypes

instance Arbitrary ExampleProductType where
  arbitrary = arbitraryExampleProductType


tests :: TestTree
tests = testGroup "Tests" [properties]

properties :: TestTree
properties = testGroup "Properties" [qcProps]

qcProps = testGroup "(checked by QuickCheck)"
  [ QC.testProperty "ExampleSumTypes sort == sort . reverse" (
       \list -> sort (list :: [ExampleSumTypes]) == sort (reverse list)) ,
    QC.testProperty "ExampleProductTypes sort == sort . reverse" (
       \list -> sort (list :: [ExampleProductType]) == sort (reverse list)) ]

