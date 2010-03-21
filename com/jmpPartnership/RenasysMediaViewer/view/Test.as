package {
	import com.bigspaceship.events.FrameEvent;
	
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.Timer;
	//	import flash.net.URLRequest;
	//	import flash.net.navigateToURL;

	import org.goasap.utils.customadvance.OnDurationComplete;	
	import com.hydrotik.go.HydroSequence;
	import com.hydrotik.go.HydroTween;
    
    
    //---------------------------------------
	//
	//		Document Class for TranspennineExpress.fla
	//
	//		stage instances are set to auto declare	
	//---------------------------------------
	
	
	public class Test extends MovieClip
	{

		public var journeyTime:int	=	400;

		public var delay:int	=	9000;
		
		//	public var mainTimer:Timer = new Timer( this.delay, 1 );
				
		public var endTimer:Timer = new Timer( 4000, 1 );

		private var _labelRef:Object;
		private var _labelMethods:Object;
		


		//		***   CONSTRUCTOR	***

		public function Test()
		{
			init();
						
		}

		
		private function init():void
		{			
			stop();
			
			HydroTween.go( ball, {x:20, y:300, scaleX:3, scaleY:3 }, .8, 0, null  );
						
		}


		
		private function timerHandler(e:TimerEvent):void
		{
			play();
			
			//	mainTimer.reset();
			
			trace('timerHandler called')
			
		}
		

		private function standardFrame():void
		{
			this.stop();
			
			//	reset timer
			
			//	mainTimer.start();
					
			trace ("standardFrame() called");
			
		}
		
		

		//		***		EVENT HANDLER FUNCTIONS 	***


		private function movieClick(e:Event):void 
		{	
			//	var content:String = e.currentTarget.content;
			
			//	trace ("view video: ", video );

			this.play();
			
		}



	}

}