package {
	import com.bigspaceship.events.FrameEvent;
	
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.Timer;
	//	import flash.net.URLRequest;
	//	import flash.net.navigateToURL;
    
    
    //---------------------------------------
	//
	//		Document Class for TranspennineExpress.fla
	//
	//		stage instances are set to auto declare	
	//---------------------------------------
	
	
	public class TranspennineExpress extends MovieClip
	{

		public var journeyTime:int	=	400;

		public var delay:int	=	2000;
		
		public var mainTimer:Timer = new Timer( this.delay, 1 );
				
		public var endTimer:Timer = new Timer( 4000, 1 );

		private var _labelRef:Object;
		private var _labelMethods:Object;
		


		//		***   CONSTRUCTOR	***

		public function TranspennineExpress()
		{
			init();
						
		}

		
		private function init():void
		{			
			assignLabelEvents();
			
			//	sectionName	= "MetabolicTesting";			
		
			//	textContent =  view.loadedXMLContent[sectionName];
						
			//	this.addEventListener( MouseEvent.CLICK, movieClick);
			
			assignLabelMethods();
			
			mainTimer.start();
						
			mainTimer.addEventListener( TimerEvent.TIMER_COMPLETE, timerHandler );
						
		}


		//	function: assignLabelEvents - makes an object containg all frame labels and assigns an _onFrameLabel to each labelled frame
		
		public function assignLabelEvents():void
		{
			_labelRef = {};
			_labelMethods = {};
			
			// jk: populate label ref with all the labels so we can refer to them by object
			
			var labels:Array = this.currentLabels;
			
			for(var i:Number=0;i<labels.length;i++)
			{
				var frameLabel:FrameLabel = labels[i];
				
				_labelRef[frameLabel.name] = frameLabel.frame-1;
				
				addFrameScript(frameLabel.frame-1, _onFrameLabel );		//	add _onFrameLabel event to each frame with a label 

				trace ("assignFrameFunctions: i = " + i + "	&   label: " + frameLabel.name);
				
			};

			//	trace ("labels: ", labels);

		};		
		

		// utility

		public function addMethodToLabel($label:String,$func:Function):void
		{
			removMethodFromLabel($label);
			_labelMethods[$label] = $func;
		}		
		
		
		public function removMethodFromLabel($label:String):void 
		{
			 _labelMethods[$label] = null;
			 
			 trace ('removMethodFromLabel called') 
		}



		//	function: assignLabelMethods - methods that for on a specified frame label
		
		private function assignLabelMethods():void  
		{ 	
			addMethodToLabel( "start",  		startFrame 	);
			addMethodToLabel( "glasgow",  		standardFrame 	);
			addMethodToLabel( "journey",  		journeyFrame 	);
			addMethodToLabel( "manchester",	 	manchesterFrame );
			addMethodToLabel( "priceBoard", 	priceBoardFrame 	);
			addMethodToLabel( "rabbit", 	 	rabbitFrame 	);
		
		}
		


		//		***		FRAME LABEL EVENTS	***
		

		//	CUSTOM ENTER FRAME EVENT: part of assign frame label methods script

		private function _onFrameLabel():void
		{
			if (_labelMethods[currentLabel] != null) _labelMethods[currentLabel]();

			var f:FrameLabel = new FrameLabel(currentLabel,currentFrame);	//	create a new FrameLabel event 

			dispatchEvent(new FrameEvent(FrameEvent.LABEL, new FrameLabel(currentLabel,currentFrame)));

		}			

		
		private function timerHandler(e:TimerEvent):void
		{
			play();
			
			mainTimer.reset();
			
			trace('timerHandler called')
			
		}
		

		private function standardFrame():void
		{
			this.stop();
			
			//	reset timer
			
			mainTimer.start();
					
			trace ("standardFrame() called");
			
		}
		
		
		private function startFrame():void
		{
			stop();
			
			resetMovie();
			
			mainTimer.delay = delay;
			
			mainTimer.start();
			
			landscape.gotoAndStop(1);
					
		}


		private function journeyFrame():void
		{
			stop();
			
			glasgowSign.play();
			
			landscape.play();
					
		}


		private function manchesterFrame():void
		{
			this.stop();
			
			//	mainTimer.delay = 7000;
			
			mainTimer.start();
			
			this.train.stop();
					
		}



		private function priceBoardFrame():void
		{
			this.stop();
			
			mainTimer.start();
			
			this.manchesterSign.play();		
			
		}


		private function rabbitFrame():void
		{
			this.stop();
			
			//	sign.buyNowButton.alpha = 0;
			
			mainTimer.delay = 7000;
			
			mainTimer.start();
			
			//	this.manchesterSign.play();		
			
		}


		public function resetMovie():void
		{
			glasgowSign.gotoAndStop('start');
			
			manchesterSign.gotoAndStop('start');
			
			train.gotoAndPlay('idle');
			
			//	sign.buyNowButton.alpha = 100;
						
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