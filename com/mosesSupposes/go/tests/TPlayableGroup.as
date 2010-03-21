
package com.mosesSupposes.go.tests {
	import org.goasap.events.*;
	import org.goasap.items.*;
	import org.goasap.utils.*;
	
	import com.mosesSupposes.go.tutorials.SizeTweenMG;
	
	import fl.motion.easing.Bounce;	

	// Extensions of Go should live in your personal classpath!
	
	/**
	 *  @author Moses Gunesch
	 */
	public class TPlayableGroup extends GoTestBase {
		
		protected var group : PlayableGroup;
		
		/**
		PlayableGroup is a generic Parallel utility.
		You can use it to control a group of playable items, 
		like tweens, with a single set of play controls.
		 
		(It is also the foundation for the SequenceStep class.)
		 */
		public function TPlayableGroup() 
		{
			group = new PlayableGroup();
			group.addEventListener(GoEvent.START, super.traceEvent);
			group.addEventListener(GoEvent.STOP, super.traceEvent);
			group.addEventListener(GoEvent.PAUSE, super.traceEvent);
			group.addEventListener(GoEvent.RESUME, super.traceEvent);
			group.addEventListener(GoEvent.CYCLE, super.traceEvent);
			group.addEventListener(GoEvent.COMPLETE, super.traceEvent);
			
			for (var i:Number=0; i<10; i++) {
	
				var t : SizeTweenMG = new SizeTweenMG();
				t.target = box(i * 20);
				t.startWidth = 10;
				t.width = 300;
				t.duration = 3;
				t.easing = Bounce.easeOut;

				// build the group
				group.addChild(t);
			}
			
			super.addHeaderText("PlayableGroup: provides a set of playable controls for a group of playable items.");
			super.addButtonUI(group, 1.5);
		}
	}
}
