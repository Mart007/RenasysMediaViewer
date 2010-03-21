
package com.mosesSupposes.go.tests {	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	import org.goasap.PlayableBase;
	import org.goasap.events.GoEvent;
	import org.goasap.events.SequenceEvent;
	import org.goasap.interfaces.IPlayable;
	import org.goasap.utils.SequenceBase;
	
	import fl.controls.Button;	

	/**	 * 1. Extend this class with a test. 
	 * 2. Make one or more targets passing a yOffset, like box(20);
	 * 3. Set the public var playable to whatever go object you want the buttons to control. 
	 * 4. Optionally set skipToAmount.
	 * 5. A convenient traceEvent method is provided for adding listeners on your go instances.
	 * 
	 * @author Moses Gunesch	 */	public class GoTestBase extends MovieClip {
		
		protected var buttonX: Number = 20;
		protected var buttonY: Number = 20;
		
		protected var buttonTargets: Dictionary = new Dictionary();
		protected var skipToAmounts: Dictionary = new Dictionary();

		public function GoTestBase() {
			// Do nothing. You should call super.addButtonUI from your subclass
			// to link a new row of buttons to a playable instance.
		}
		
		// you can call this before making buttonUIs to stick some text onscreen.
		protected function addHeaderText(text : String) : void {
			var t:TextField = new TextField();
			t.autoSize = "left";
			t.text = text;
			addChild(t);
			t.x = buttonX;
			t.y = buttonY;
			buttonY += t.height + 10;
		}
		
		protected function addButtonUI(playable:IPlayable, skipToAmount:Number=1.5):void {
			
			var startX:Number = buttonX;
			
			skipToAmounts[playable] = skipToAmount;
			
			addButton("start", playable);
			addButton("pause/resume", playable);
			addButton("stop", playable);
			addButton("skipTo("+skipToAmount+")", playable);
			
			// carriage return in case called again.
			buttonX = startX;
			buttonY += 30;
		}
		
		protected function addButton(label : String, target:IPlayable) : Button {
			var b:Button = new Button();
			buttonTargets[b] = target;
			addChild(b);
			b.label = label;
			b.x = buttonX;
			b.y = buttonY;
			buttonX += b.width + 10; 
			b.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
			return b;
		}

		protected function traceEvent(e : Event) : void 
		{ 
			switch (e.type) {
				case GoEvent.START: 
					trace("\t :: START :: "+e.target+"\n");
					return;
				case GoEvent.STOP: 
					trace("\t :: STOP :: "+e.target+"\n");
					return;
				case GoEvent.COMPLETE: 
					trace("\t :: COMPLETE :: "+e.target+"\n");
					return;
				case SequenceEvent.ADVANCE: 
					trace("\t :: ADVANCE :: "+e.target+" :: step="+(e.target as SequenceBase).playIndex+"\n"); 
					return;
				default:
					trace("\t :: "+e.type + " :: "+e.target+"\n");
			}
		}
		
		protected function box(yOffset : Number = 0) : Sprite 
		{
			var s : Sprite = new Sprite();
			s.graphics.beginFill(0xFF3300);
			s.graphics.drawRect(0, 0, 10, 10);
			this.addChild(s);
			s.x = 100;
			s.y = 100 + yOffset;
			return s;
		}
		
		protected function onClick(e : MouseEvent) : void 
		{
			var button:Button = e.target as Button;
			var playable:IPlayable = buttonTargets[button] as IPlayable;
			if (playable==null)
				return;
			
			trace("\n*click "+button.label+"*");
			
			if (button.label=="start") {
				playable.start();
			}
			else if (button.label=="stop") {
				playable.stop();
			}
			else if (button.label.indexOf("pause")==0) {
				if (playable.state == PlayableBase.PAUSED)
					playable.resume();
				else
					playable.pause();
			}
			else if (button.label.indexOf("skipTo")==0) {
				playable.skipTo(Number(skipToAmounts[playable]));
			}
		}
	}}