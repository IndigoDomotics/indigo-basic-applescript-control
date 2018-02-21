-------------------------------------------------
-- Internal functions for dispatching commands to Indigo's python scripting engine:
on _getIphPath()
	set iph7 to "/Library/Application Support/Perceptive Automation/Indigo 7/IndigoPluginHost.app/Contents/MacOS/IndigoPluginHost"
	set iph6 to "/Library/Application Support/Perceptive Automation/Indigo 6/IndigoPluginHost.app/Contents/MacOS/IndigoPluginHost"
	set iph5 to "/Library/Application Support/Perceptive Automation/Indigo 5/IndigoPluginHost.app/Contents/MacOS/IndigoPluginHost"
	tell application "System Events"
		if exists file iph7 then
			return iph7
		else if exists file iph6 then
			return iph6
		else if exists file iph5 then
			return iph5
		else
			error "Indigo Server not installed"
		end if
	end tell
end _getIphPath

on _executeIphCommand(command)
	set iphPath to _getIphPath()
	do shell script quoted form of iphPath & " -e " & quoted form of command
end _executeIphCommand

-------------------------------------------------
-- Helper functions for executing an action group (by name or ID):
on executeActionGroup_byName(groupName)
	_executeIphCommand("indigo.actionGroup.execute(\"" & groupName & "\")")
end executeActionGroup_byName

on executeActionGroup_byID(groupID)
	_executeIphCommand("indigo.actionGroup.execute(" & groupID & ")")
end executeActionGroup_byID

-------------------------------------------------
-- Helper functions for on/off control of a devices (by name or ID):
on turnOn_byName(devName)
	_executeIphCommand("indigo.device.turnOn(\"" & devName & "\")")
end turnOn_byName

on turnOff_byName(devName)
	_executeIphCommand("indigo.device.turnOff(\"" & devName & "\")")
end turnOff_byName

on toggle_byName(devName)
	_executeIphCommand("indigo.device.toggle(\"" & devName & "\")")
end toggle_byName

on turnOn_byID(devID)
	_executeIphCommand("indigo.device.turnOn(" & devID & ")")
end turnOn_byID

on turnOff_byID(devID)
	_executeIphCommand("indigo.device.turnOff(" & devID & ")")
end turnOff_byID

on toggle_byID(devID)
	_executeIphCommand("indigo.device.toggle(" & devID & ")")
end toggle_byID

-------------------------------------------------
-- Helper functions for setting a variable value (by name or ID):
on updateVariable_byName(varName, newValue)
	_executeIphCommand("indigo.variable.updateValue(\"" & varName & "\", \"" & newValue & "\")")
end updateVariable_byName

on updateVariable_byID(varID, newValue)
	_executeIphCommand("indigo.variable.updateValue(" & varID & ", \"" & newValue & "\")")
end updateVariable_byID

-------------------------------------------------
-- Examples (uncomment or replace with your calls):

--executeActionGroup_byName("cooking scene")
--executeActionGroup_byID("1969538881")
--
--turnOn_byName("office lamp")
--turnOff_byName("office lamp")
--toggle_byName("office lamp")
--
--turnOn_byID("1091151457")
--turnOff_byID("1091151457")
--toggle_byID("1091151457")
--
--updateVariable_byName("houseMode", "someNewValue1")
--updateVariable_byID("1389001099", "someNewValue2")

