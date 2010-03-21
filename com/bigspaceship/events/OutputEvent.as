package com.bigspaceship.events
{
    import flash.events.*;

    public class OutputEvent extends Event
    {
        public var output:String;
        public static var ALL:String = "all";
        public static var ERROR:String = "error";
        public static var FATAL:String = "fatal";
        public static var INFO:String = "info";
        public static var STATUS:String = "status";
        public static var DEBUG:String = "debug";
        public static var WARNING:String = "warning";

        public function OutputEvent(param1:String, param2:String)
        {
            super(param1);
            output = param2;
            return;
        }// end function

        override public function clone() : Event
        {
            return new OutputEvent(type, output);
        }// end function

    }
}
