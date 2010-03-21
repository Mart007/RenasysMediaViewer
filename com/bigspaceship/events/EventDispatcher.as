class com.bigspaceship.events.EventDispatcher
{
    var _dispatchQueue, _loc3;
    function EventDispatcher()
    {
    } // End of the function
    static function _removeEventListener(queue, event, handler)
    {
        if (queue != undefined)
        {
            var _loc4 = queue.length;
            var _loc1;
            for (var _loc1 = 0; _loc1 < _loc4; ++_loc1)
            {
                var _loc2 = queue[_loc1];
                if (_loc2 == handler)
                {
                    queue.splice(_loc1, 1);
                    return;
                } // end if
            } // end of for
        } // end if
    } // End of the function
    static function initialize(object)
    {
        if (com.bigspaceship.events.EventDispatcher._fEventDispatcher == undefined)
        {
            _fEventDispatcher = new com.bigspaceship.events.EventDispatcher();
        } // end if
        object.addEventListener = com.bigspaceship.events.EventDispatcher._fEventDispatcher.addEventListener;
        object.removeEventListener = com.bigspaceship.events.EventDispatcher._fEventDispatcher.removeEventListener;
        object.dispatchEvent = com.bigspaceship.events.EventDispatcher._fEventDispatcher.dispatchEvent;
        object.dispatchQueue = com.bigspaceship.events.EventDispatcher._fEventDispatcher.dispatchQueue;
        object.getTotalListeners = com.bigspaceship.events.EventDispatcher._fEventDispatcher.getTotalListeners;
    } // End of the function
    static function initializePrivate(object)
    {
        if (com.bigspaceship.events.EventDispatcher._fEventDispatcher == undefined)
        {
            _fEventDispatcher = new com.bigspaceship.events.EventDispatcher();
        } // end if
        object._addEventListener = com.bigspaceship.events.EventDispatcher._fEventDispatcher.addEventListener;
        object._removeEventListener = com.bigspaceship.events.EventDispatcher._fEventDispatcher.removeEventListener;
        object._dispatchEvent = com.bigspaceship.events.EventDispatcher._fEventDispatcher.dispatchPrivateEvent;
        object._dispatchQueue = com.bigspaceship.events.EventDispatcher._fEventDispatcher.dispatchQueue;
        object._getTotalListeners = com.bigspaceship.events.EventDispatcher._fEventDispatcher.getTotalListeners;
    } // End of the function
    function dispatchQueue(queueObj, eventObj)
    {
        var _loc7 = "__q_" + eventObj.type;
        var _loc4 = queueObj[_loc7];
        if (_loc4 != undefined)
        {
            var _loc5;
            for (var _loc5 in _loc4)
            {
                var _loc1 = _loc4[_loc5];
                var _loc3 = typeof(_loc1);
                if (_loc3 == "object" || _loc3 == "movieclip")
                {
                    if (_loc1.handleEvent != undefined)
                    {
                        _loc1.handleEvent(eventObj);
                    } // end if
                    if (_loc1[eventObj.type] != undefined)
                    {
                        if (com.bigspaceship.events.EventDispatcher.exceptions[eventObj.type] == undefined)
                        {
                            _loc1[eventObj.type](eventObj);
                        } // end if
                    } // end if
                    continue;
                } // end if
                _loc1.apply(queueObj, [eventObj]);
            } // end of for...in
        } // end if
    } // End of the function
    function dispatchEvent(eventObj)
    {
        if (eventObj.target == undefined)
        {
            eventObj.target = this;
        } // end if
        this[eventObj.type + "Handler"](eventObj);
        this.dispatchQueue(this, eventObj);
    } // End of the function
    function dispatchPrivateEvent(eventObj)
    {
        if (eventObj.target == undefined)
        {
            eventObj.target = this;
        } // end if
        this[eventObj.type + "Handler"](eventObj);
        this._dispatchQueue(this, eventObj);
    } // End of the function
    function addEventListener(event, handler)
    {
        var _loc3 = "__q_" + event;
        if (this[_loc3] == undefined)
        {
            this[_loc3] = new Array();
        } // end if
        _global.ASSetPropFlags(this, _loc3, 1);
        com.bigspaceship.events.EventDispatcher._removeEventListener(this[_loc3], event, handler);
        this[_loc3].push(handler);
    } // End of the function
    function removeEventListener(event, handler)
    {
        var _loc2 = "__q_" + event;
        com.bigspaceship.events.EventDispatcher._removeEventListener(this[_loc2], event, handler);
    } // End of the function
    function getTotalListeners(event)
    {
        var _loc2 = "__q_" + event;
        return (this[_loc2].length);
    } // End of the function
    static var _fEventDispatcher = undefined;
    static var exceptions = {move: 1, draw: 1};
} // End of Class
