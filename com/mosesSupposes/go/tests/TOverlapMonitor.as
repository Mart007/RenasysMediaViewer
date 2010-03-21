
package com.mosesSupposes.go.tests {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.goasap.GoEngine;
	import org.goasap.events.GoEvent;
	import org.goasap.managers.OverlapMonitor;
	
	import com.mosesSupposes.go.tutorials.SizeTweenMG;
	
	import fl.controls.Button;
	import fl.motion.easing.*;	

	// The Go core package will not include any tweens!
	
	/**
	 * @author Moses Gunesch
	 */
	public class TOverlapMonitor extends GoTestBase {
		
		protected var tween1 : SizeTweenMG;		
		protected var tween2 : SizeTweenMG;		
		protected var tween3 : SizeTweenMG;		
		
		/**
		MANAGERS
		
		This file demonstrates the one manaager included in the Go system, OverlapMonitor.
		OverlapMonitor tries to prevent different GoItems from controlling the same
		properties on the same targets at once, but doing this requires that tween classes
		implement the IManageable interface. Take a look at the SizeTweenMg class for a
		tutorial on making GoItems management-compatible.
		 */
		public function TOverlapMonitor() 
		{
			
			/**
			 * SETUP -- CALL ONCE TO ACTIVATE THE MANAGER IN THIS PROJECT.
			 * (comment out this setup later to see the difference.)
			 */
			GoEngine.addManager(new OverlapMonitor());
			
			// single target that different tweens will attempt to manipulate.
			var target : Sprite = super.box(100);
			
			// Width tween
			tween1 = new SizeTweenMG(target);
			tween1.playableID = "tween1";
			tween1.easing = Linear.easeNone;
			tween1.duration = 3;
//			tween1.startWidth = 10;
			tween1.width = 150;
			tween1.addEventListener(GoEvent.STOP, super.traceEvent);
			
			// WIdth & height tween
			tween2 = new SizeTweenMG(target);
			tween2.playableID = "tween2";
			tween2.easing = Linear.easeNone;
			tween2.duration = 3;
			tween2.width = 150;
//			tween2.startWidth = 10;
//			tween2.startHeight = 10;
			tween2.height = 150;
			tween2.addEventListener(GoEvent.STOP, super.traceEvent);
			
			// WIdth & height tween + delay
			tween3 = new SizeTweenMG(target);
			tween3.playableID = "tween3";
			tween3.easing = Linear.easeNone;
			tween3.duration = 3;
//			tween3.startHeight = 10;
			tween3.height = 150;
			tween3.addEventListener(GoEvent.STOP, super.traceEvent);
			
			super.addHeaderText("Click start buttons while running to interrupt the tween.\n"
								+ "You should see Overlap monitor stopping the running tween in the output window.");
			
			super.addButtonUI(tween1);
			super.addButtonUI(tween2);
			super.addButtonUI(tween3);
			
			var b:Button = new Button();
			addChild(b);
			b.label = "reset";
			b.x = buttonX;
			b.y = buttonY;
			b.addEventListener(MouseEvent.MOUSE_DOWN, reset);
		}
		
		protected function reset(event : MouseEvent) : void {
			trace("\n* reset *");
			tween1.stop();
			tween2.stop();
			tween3.stop();
			tween1.target.width = 10;
			tween1.target.height = 10;
		}
	}
}
