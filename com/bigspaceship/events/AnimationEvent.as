package com.bigspaceship.events
{
    import flash.events.*;

    public class AnimationEvent extends Event
    {
        public var clip:Object;
        public static const ANIMATE_IN:String = "animateIn";
        public static const ANIMATE_START:String = "animateBegin";
        public static const ANIMATE_UPDATE:String = "animateUpdate";
        public static const ANIMATE_ROLLOVER:String = "animateRollOver";
        public static const ANIMATE_OUT:String = "animateOut";
        public static const ANIMATE_FINISH:String = "animateFinish";
        public static const ANIMATE_OUT_START:String = "animateOutStart";
        public static const ANIMATE_IN_START:String = "animateInStart";
        public static const ANIMATE_CANCEL:String = "animateCancel";
        public static const ANIMATE_ROLLOUT:String = "animateRollOut";
        public static const ANIMATE_COMPLETE:String = "animateComplete";

        public function AnimationEvent(param1:String, param2 = null)
        {
            super(param1);
            clip = param2;
            return;
        }// end function

        override public function clone() : Event
        {
            return new AnimationEvent(type, clip);
        }// end function

    }
}
