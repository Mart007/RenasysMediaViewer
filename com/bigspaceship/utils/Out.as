class com.bigspaceship.utils.Out
{
    static var _instance, _keyListener;
    function Out()
    {
    } // End of the function
    function _output(str)
    {
        _root.debug_mc.debug_txt.text = _root.debug_mc.debug_txt.text + (str + "\n");
        _root.debug_mc.debug_txt.scroll = _root.debug_mc.debug_txt.maxscroll;
    } // End of the function
    function _log(str)
    {
    } // End of the function
    static function enableLevel(level)
    {
        if (!com.bigspaceship.utils.Out._instance)
        {
            _instance = new com.bigspaceship.utils.Out();
        } // end if
        com.bigspaceship.utils.Out._levels[level] = com.bigspaceship.utils.Out._instance;
    } // End of the function
    static function enableAllLevels()
    {
        com.bigspaceship.utils.Out.enableLevel(com.bigspaceship.utils.Out.OUT_INFO);
        com.bigspaceship.utils.Out.enableLevel(com.bigspaceship.utils.Out.OUT_STATUS);
        com.bigspaceship.utils.Out.enableLevel(com.bigspaceship.utils.Out.OUT_DEBUG);
        com.bigspaceship.utils.Out.enableLevel(com.bigspaceship.utils.Out.OUT_WARNING);
        com.bigspaceship.utils.Out.enableLevel(com.bigspaceship.utils.Out.OUT_ERROR);
        com.bigspaceship.utils.Out.enableLevel(com.bigspaceship.utils.Out.OUT_FATAL);
        _keyListener = {};
        com.bigspaceship.utils.Out._keyListener.onKeyDown = com.bigspaceship.utils.Delegate.create(com.bigspaceship.utils.Out, com.bigspaceship.utils.Out.onKeyDown);
        Key.addListener(com.bigspaceship.utils.Out._keyListener);
    } // End of the function
    static function onKeyDown()
    {
        if (Key.isDown(16) && Key.isDown(32))
        {
            _root.debug_mc.swapDepths(99999);
            _root.debug_mc._visible = !_root.debug_mc._visible;
        } // end if
    } // End of the function
    static function disableLevel(level)
    {
        com.bigspaceship.utils.Out._levels[level] = null;
    } // End of the function
    static function silence($origin)
    {
        var _loc2 = typeof($origin) == "String" ? ($origin) : ($origin._classname);
        var _loc1 = com.bigspaceship.utils.Out._silenced.length;
        while (_loc1--)
        {
            if (com.bigspaceship.utils.Out._silenced[_loc1] == _loc2)
            {
                return;
            } // end if
        } // end while
        com.bigspaceship.utils.Out._silenced.push(_loc2);
    } // End of the function
    static function unsilence($origin)
    {
        var _loc2 = typeof($origin) == "String" ? ($origin) : ($origin._classname);
        var _loc1 = com.bigspaceship.utils.Out._silenced.length;
        while (_loc1--)
        {
            if (com.bigspaceship.utils.Out._silenced[_loc1] == _loc2)
            {
                com.bigspaceship.utils.Out._silenced.splice(_loc1, 1);
                break;
            } // end if
        } // end while
    } // End of the function
    static function disableAllLevels()
    {
        com.bigspaceship.utils.Out.disableLevel(com.bigspaceship.utils.Out.OUT_INFO);
        com.bigspaceship.utils.Out.disableLevel(com.bigspaceship.utils.Out.OUT_STATUS);
        com.bigspaceship.utils.Out.disableLevel(com.bigspaceship.utils.Out.OUT_DEBUG);
        com.bigspaceship.utils.Out.disableLevel(com.bigspaceship.utils.Out.OUT_WARNING);
        com.bigspaceship.utils.Out.disableLevel(com.bigspaceship.utils.Out.OUT_ERROR);
        com.bigspaceship.utils.Out.disableLevel(com.bigspaceship.utils.Out.OUT_FATAL);
    } // End of the function
    static function report()
    {
    } // End of the function
    static function info(origin, str)
    {
        if (!com.bigspaceship.utils.Out.isSilenced(origin))
        {
            com.bigspaceship.utils.Out._levels[com.bigspaceship.utils.Out.OUT_INFO]._output("INFO:   " + origin._classname + ": " + str);
        } // end if
    } // End of the function
    static function status(origin, str)
    {
        if (!com.bigspaceship.utils.Out.isSilenced(origin))
        {
            com.bigspaceship.utils.Out._levels[com.bigspaceship.utils.Out.OUT_STATUS]._output("STATUS: " + origin._classname + ": " + str);
        } // end if
    } // End of the function
    static function debug(origin, str)
    {
        if (!com.bigspaceship.utils.Out.isSilenced(origin))
        {
            com.bigspaceship.utils.Out._levels[com.bigspaceship.utils.Out.OUT_DEBUG]._output("DEBUG:  " + origin._classname + ": " + str);
        } // end if
    } // End of the function
    static function warning(origin, str)
    {
        if (!com.bigspaceship.utils.Out.isSilenced(origin))
        {
            com.bigspaceship.utils.Out._levels[com.bigspaceship.utils.Out.OUT_WARNING]._output("WARNING:" + origin._classname + ": " + str);
        } // end if
    } // End of the function
    static function error(origin, str)
    {
        if (!com.bigspaceship.utils.Out.isSilenced(origin))
        {
            com.bigspaceship.utils.Out._levels[com.bigspaceship.utils.Out.OUT_ERROR]._output("ERROR:  " + origin._classname + ": " + str);
        } // end if
    } // End of the function
    static function fatal(origin, str)
    {
        if (!com.bigspaceship.utils.Out.isSilenced(origin))
        {
            com.bigspaceship.utils.Out._levels[com.bigspaceship.utils.Out.OUT_FATAL]._output("FATAL:  " + origin._classname + ": " + str);
        } // end if
    } // End of the function
    static function traceObject(origin, $label, $obj)
    {
        for (var _loc2 in $obj)
        {
        } // end of for...in
    } // End of the function
    static function isSilenced($origin)
    {
        var _loc1 = "|" + $origin._classname + "|";
        var _loc2 = "|" + com.bigspaceship.utils.Out._silenced.join("|") + "|";
        return (_loc2.indexOf(_loc1) >= 0);
    } // End of the function
    static var OUT_INFO = 0;
    static var OUT_STATUS = 1;
    static var OUT_DEBUG = 2;
    static var OUT_WARNING = 3;
    static var OUT_ERROR = 4;
    static var OUT_FATAL = 5;
    static var _levels = new Array();
    static var _silenced = new Array();
} // End of Class
