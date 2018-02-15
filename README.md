### Indigo Control AppleScript

As discussed on our blog, we are [deprecating Indigo's built-in support of AppleScript](http://www.indigodomo.com/blog/2017/09/09/future-applescript-and-indigo/)
in favor of the much more robust python scripting architecture Indigo now has. We encourage users to convert their AppleScripts to python when possible, but also
realize there are some cases where that is difficult or impossible. An example would be a 3rd party app that allows for easy execution of AppleScript.

There are a couple of different ways to use AppleScript to control Indigo (devices, variable values, etc.): RESTful Web API calls and direct Indigo python scripting engine calls. Using AppleScript to make RESTful Web API calls [as shown here](http://wiki.indigodomo.com/doku.php?id=indigo_s_restful_urls#applescript_the_restful_api) is a good solution but requires that Indigo's Web server be enabled and that the username and password be embedded in the AppleScript. The IndigoControl.applescript solution discussed here avoids those requirements and works as long as the AppleScript is being executed on the same Mac as the Indigo Server. This technqiue can also be used to work around the macOS bug which causes the ("Application isn't running" errors discussed here)[http://forums.indigodomo.com/viewtopic.php?p=103428#p103428].

### Usage

Download the IndigoControl.applescript file from this github repository. Use the file (or copy/paste its contents)
into the AppleScript you are using. You can then use the internally defined functions to command Indigo, like this:

```executActionGroup_byName("cooking scene")
executActionGroup_byID("1969538881")

turnOn_byName("office lamp")
turnOff_byName("office lamp")
toggle_byName("office lamp")

turnOn_byID("1091151457")
turnOff_byID("1091151457")
toggle_byID("1091151457")

updateVariable_byName("houseMode", "someNewValue1")
updateVariable_byID("1389001099", "someNewValue2")
```

Note you can use either object names or IDs. We recommend using IDs (rigfht-click on the objects in Indigo to copy out their ID) because they will
remain constant for the lifetime of the object, even if it is renamed. Note that ID's have to be passed in as strings (quoted).

### Caveats

The biggest caveat to this technique is that it is slow. Under-the-hood each call requires a new Indigo host process to be created temporarily
to handle passing the command to Indigo. If you have several commands that need to be executed back-to-back then this probably isn't the best
solution, although you might be able to prevent problems by adding all the commands to an Action Group in Indigo and executiung the Action Group
instead.
