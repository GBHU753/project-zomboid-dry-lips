require "MF_ISMoodle"

--Moodle creation, replace Proteins by your own moodle name.
MF.createMoodle("DryLips");

local isHealthPanelVisible = false;--specific stuff to have a conditionally visible moodle
local playerLogLimiter = false

--note that you can override thresholds with
--MF.getMoodle("Proteins"):setThresholds(bad4, bad3, bad2, bad1, good1, good2, good3, good4)
--those 8 threasholds must be consecutive float values from 0.0 to 1.0 in order to define intervals
--note that values between bad1 and good1 used in moodle:setValue will hide the moodle (not seen in that mode)
--e.g. if bad1 == 0.3 and good == 0.365 then moodle:setValue(0.311) will remove the moodle.