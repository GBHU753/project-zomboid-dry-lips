require "MF_ISMoodle"

--Moodle creation, replace Proteins by your own moodle name.
MF.createMoodle("DryLips");

local playerLogLimiter = false;


--  ordering bad4, bad3, bad2, bad1,   good1, good2, good3, good4
local moodleThreshold =  {0.1, 0.2, 0.3, 0.4,   0.6, 0.7, 0.8, 0.9};

--note that you can override thresholds with
--MF.getMoodle("DryLips"):setThresholds(bad4, bad3, bad2, bad1, good1, good2, good3, good4)
--those 8 threasholds must be consecutive float values from 0.0 to 1.0 in order to define intervals
--note that values between bad1 and good1 used in moodle:setValue will hide the moodle (not seen in that mode)
--e.g. if bad1 == 0.3 and good == 0.365 then moodle:setValue(0.311) will remove the moodle.


local function DryLipsMoodleUpdate(player)
    

    if player == getPlayer() then

        -- guard case to check if the lip dryness value is set
        -- if not, set it to 0
        local myModData = player:getModData();
        if myModData.LipDryness == nil then
            myModData.LipDryness = 0;
            myModData.LipDryMoodlePos = 7;
        end


        local moodle = MF.getMoodle("DryLips");--get access to the moodle with that name associated to getPlayer

        
        -- if the lip dryness is equal to the threshold, then set the moodle to the next level
        if (myModData.LipDryness == SandboxVars.DryLipsHoursTill) then
            
            -- decrement the moodle position if it is not already at the lowest level
            if (myModData.LipDryMoodlePos > 0) then
                myModData.LipDryMoodlePos = myModData.LipDryMoodlePos - 1;
            end

            -- set the moodle to the next level
            moodle:setValue(moodleThreshold[myModData.LipDryMoodlePos]);

            -- reset the lip dryness counter
            myModData.LipDryness = 0;
        end

        myModData.LipDryness = myModData.LipDryness + 1;
    
    else
        if not playerLogLimiter then print ("ProteinsMoodleUpdate not being getPlayer "..player:getPlayerNum()) end
        playerLogLimiter = true;
    end

end


-- Event hooks
Events.OnPlayerDeath.Add(function()
    Events.EveryHours.Add(DryLipsMoodleUpdate);--Dry lips moodle is related to hours update (time).
--but you can use moodle for anything, not always related to player update.
end);

Events.OnCreatePlayer.Add(function()
    Events.EveryHours.Add(DryLipsMoodleUpdate);--Dry lips moodle is related to hours update (time).
--but you can use moodle for anything, not always related to player update.
end);







