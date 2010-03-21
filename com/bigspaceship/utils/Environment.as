class com.bigspaceship.utils.Environment
{
    static var __get__DOMAIN, __get__IS_IN_BROWSER, __get__IS_AREA51, __get__IS_BIGSPACESHIP, __get__IS_IN_DEVELOPMENT;
    function Environment()
    {
    } // End of the function
    static function get IS_IN_BROWSER()
    {
        return (System.capabilities.playerType == "PlugIn" || System.capabilities.playerType == "ActiveX");
    } // End of the function
    static function get DOMAIN()
    {
        return (new LocalConnection().domain());
    } // End of the function
    static function get IS_AREA51()
    {
        //return (com.bigspaceship.utils.Environment.DOMAIN() == "area51.bigspaceship.com");
    } // End of the function
    static function get IS_BIGSPACESHIP()
    {
        //return (com.bigspaceship.utils.Environment.DOMAIN() == "www.bigspaceship.com" || com.bigspaceship.utils.Environment.__get__DOMAIN() == "bigspaceship.com");
    } // End of the function
    static function getFlashVar($str)
    {
        return (_root[$str]);
    } // End of the function
    static function get IS_IN_DEVELOPMENT()
    {
        if (!com.bigspaceship.utils.Environment.__get__IS_IN_BROWSER())
        {
            return (true);
        }
        else
        {
            //return (com.bigspaceship.utils.Environment.IS_AREA51() || _root._url.indexOf("file://") > -1);
        } // end else if
    } // End of the function
    static function callJS($method, $params)
    {
        if ($params == undefined)
        {
            $params = {x: "undefined"};
        } // end if
        if (com.bigspaceship.utils.Environment.__get__IS_IN_BROWSER())
        {
            flash.external.ExternalInterface.call($method, $params);
        }
        else
        {
            var _loc2 = "{";
            for (var _loc3 in $params)
            {
                _loc2 = _loc2 + (_loc3 + ": " + $params[_loc3] + ",");
            } // end of for...in
            _loc2 = _loc2.slice(0, _loc2.length - 1) + "}";
        } // end else if
        false;
    } // End of the function
} // End of Class
