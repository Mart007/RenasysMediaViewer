
package com.mosesSupposes.go.tests {	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.goasap.PlayableBase;
	import org.goasap.events.*;
	import org.goasap.interfaces.IPlayable;
	import org.goasap.items.*;
	import org.goasap.utils.*;
	import org.goasap.utils.customadvance.*;
	
	import com.mosesSupposes.go.tutorials.SizeTweenMG;
	
	import fl.controls.Button;
	import fl.motion.easing.Linear;	

	// Extensions of Go should live in your personal classpath!
	
	/**
	 *  @author Moses Gunesch
	 */
	public class TSequenceCA extends GoTestBase {
		
		protected var seq : SequenceCA;
		
		protected var box1 : Sprite;
		protected var box2 : Sprite;
		protected var box3 : Sprite;
		protected var box4 : Sprite;

		/*
		There are 2 Sequence classes included in Go, Sequence and SequenceCA.
		 
		The Sequence class composes a sequence from SequenceStep instances.
		It allows you to add any playable item to it, wrapping items
		in SequenceSteps as you build the sequence. Like most elements of
		Go, Sequences are playable and dispatch events, Sequence dispatches
		one unique event, SequenceEvent.ADVANCE, as it steps forward, as well
		as dispatching normal GoEvents like COMPLETE.
		 
		This example uses the 2nd more advanced sequence class, SequenceCA, 
		which stands for "Custom Advance".The difference is that it allows 
		you to set an advance property for any step, which is of type 
		SequenceStepCA when using SequenceCA.
		 
		The custom advance setting lets you determine when a sequence advances
		to its next step. The default behavior is, all animations complete.
		Custom advances include OnPlayableComplete (e.t. one item in a step
		completes), OnDurationComplete, OnEventComplete, and OnConditionTrue.
		 
		The example below sets up an OnDurationComplete scenario.
		
		 */
		public function TSequenceCA() 
		{
			// SequenceCA has "Custom Advance" options
			seq = new SequenceCA();
			seq.playableID = "seq";

			seq.addEventListener(GoEvent.START, super.traceEvent);
			seq.addEventListener(GoEvent.STOP, super.traceEvent);
			seq.addEventListener(GoEvent.PAUSE, super.traceEvent);
			seq.addEventListener(GoEvent.RESUME, super.traceEvent);
			seq.addEventListener(GoEvent.CYCLE, super.traceEvent);
			seq.addEventListener(GoEvent.COMPLETE, super.traceEvent);
			seq.addEventListener(SequenceEvent.ADVANCE, super.traceEvent);
			
			box1 = box(20);
			box2 = box(40);
			box3 = box(60);
			box4 = box(80);

			for (var i : Number = 0;i < 4; i++) {
				var t : SizeTweenMG = new SizeTweenMG();
				t.target = this["box"+(i+1)];
				t.startWidth = 10;
				t.width = 200;
				t.easing = Linear.easeNone;
				
				//-- UNCOMMENT ONE OF THESE DURATIONS. (See the seq.lastStep.advance line below) --
				t.duration = 3; // Test trailing tween advance
//				t.duration = 5 - i*2; // Test trailing tween completion after sequence ends
//				t.duration = .5; // Test delaying tween end using late advance
				
				seq.addStep(t);
				
				// this is a custom advance at 1 second. (See docs for others: OnEventComplete, etc.)
				// We're actually adding it to a SequenceStepCA, which is auto-generated to wrap the tween.
				seq.lastStep.advance = new OnDurationComplete(1);
				seq.lastStep.playableID = "Step#"+i; // the term lastStep means the final step in the sequence.
			}
			
			super.addHeaderText("SequenceCA: adds 'custom advance' functionality to sequencing.\n" +
								"By setting the advance property of any step you can determine what triggers it to advance to the next step.");
			super.addButtonUI(seq, 1);
		}
		
		
		// The following code just runs a reset when you click start() or skipTo().
		// skipTo() doesn't reset box1 since we're skipping to the second index.
		
		override protected function onClick(e : MouseEvent) : void 
		{
			var button:Button = e.target as Button;
			var playable:IPlayable = buttonTargets[button] as IPlayable;
			if (playable==null)
				return;
			
			if (button.label=="start" || button.label.indexOf("skipTo")==0) {
				resetTargets(button.label=="start");
			}
			super.onClick(e);
		}
		
		protected function resetTargets(isStart:Boolean=false) : void {
			if (isStart) {
				box1.width = 10;
			}
			box2.width = 10;
			box3.width = 10;
			box4.width = 10;
		}
	}
}
