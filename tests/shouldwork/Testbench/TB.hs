module TB where

import CLaSH.Prelude

type Inp   = (Signed 4,Outp)
type Outp  = (Maybe (Signed 8,Bool),Bit)

topEntity :: Unbundled Inp -> Unbundled Outp
topEntity = transfer <^> initS

transfer s i = (i,o)
  where
    o = snd s

initS = (0,(Nothing,0))

testInput :: Signal Inp
testInput = stimuliGenerator $(v ([ (1,(Just (4,True), 0))
                                  , (3,(Nothing, 1))
                                  ]::[(Signed 4,(Maybe (Signed 8,Bool),Bit))]))

expectedOutput :: Signal Outp -> Signal Bool
expectedOutput = outputVerifier $(v ([(Nothing,0)
                                      ,(Just (4,False), 1)
                                      ]::[(Maybe (Signed 8,Bool),Bit)]))

