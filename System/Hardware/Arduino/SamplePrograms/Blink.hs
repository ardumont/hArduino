-------------------------------------------------------------------------------
-- |
-- Module      :  System.Hardware.Arduino.SamplePrograms.Blink
-- Copyright   :  (c) Levent Erkok
-- License     :  BSD3
-- Maintainer  :  erkokl@gmail.com
-- Stability   :  experimental
--
-- The /hello world/ of the arduino world, blinking the led.
-------------------------------------------------------------------------------

module System.Hardware.Arduino.SamplePrograms.Blink where

import Control.Monad           (forever)
import Control.Monad.Trans     (liftIO)
import System.IO               (hSetBuffering, BufferMode(NoBuffering), stdout)

import System.Hardware.Arduino

-- | Blink the led connected to port 13 on the Arduino UNO board.
-- The blinking will synchronize with the printing of a dot on stdout.
--
-- Note that you do not need any other components to run this example: Just hook
-- up your Arduino to the computer and make sure StandardFirmata is running on it.
-- However, you can connect a LED between Pin13 and GND if you want to blink an
-- external led, like so:
--
--  <<http://github.com/LeventErkok/hArduino/raw/master/System/Hardware/Arduino/SamplePrograms/Schematics/Blink.png>>
blink :: IO ()
blink = withArduino False "/dev/cu.usbmodemfd131" $ do
           liftIO $ hSetBuffering stdout NoBuffering
           let led = pin 13
           setPinMode led OUTPUT
           forever $ do liftIO $ putStr "."
                        digitalWrite led True
                        delay 1000
                        digitalWrite led False
                        delay 1000
