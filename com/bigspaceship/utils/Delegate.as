class com.bigspaceship.utils.Delegate extends Object
{
    var func;
    function Delegate(f)
    {
        super();
        func = f;
    } // End of the function
    static function create(obj, func)
    {
        var _loc2 = function ()
        {
            var _loc2 = arguments.callee.target;
            var _loc4 = arguments.callee.func;
            var _loc3 = arguments.callee.args;
            return (_loc4.apply(_loc2, _loc3.concat(arguments)));
        };
        _loc2.target = arguments.shift();
        _loc2.func = arguments.shift();
        _loc2.args = arguments;
        return (_loc2);
    } // End of the function
    function createDelegate(obj)
    {
        return (com.bigspaceship.utils.Delegate.create(obj, func));
    } // End of the function
} // End of Class
