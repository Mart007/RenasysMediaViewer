package
{
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
    
	import com.jmpPartnership.renasysMediaViewer.view.MainMenu
    
    
    //---------------------------------------
	//
	//		Document Class for renasysContentViewer.fla
	//
	//		stage instances are set to auto declare	
	//---------------------------------------
	
	
	public class RenasysMediaViewer extends MovieClip
	{

		public var journeyTime:int	=	2000;

		public var delay:int	=	2000;
		
		//	public var mainTimer:Timer = new Timer( this.delay, 1 );
				
		public var endTimer:Timer = new Timer( 4000, 1 );

		private var _labelRef:Object;
		
		private var _labelMethods:Object;
		
		private var captionsOrigin: Object = { x: 30, y: 334 };
		
		private var captions: Array = new Array();
		
		private var currentCaption: MovieClip;
		
		private var targetCaption: String;

		private var mainMenu: MainMenu;

		


		//		***   CONSTRUCTOR	***

		public function RenasysMediaViewer()
		{
			init();
			
		}

		
		private function init():void
		{			
			//	assignLabelEvents();
									
			//	assignLabelMethods();
			
			stop();
			
			introTitle.addEventListener( MouseEvent.CLICK, introClickHandler );
			
			backgroundStripes.y = -770;
			
			introTitle.alpha = 0;
			
			intro("start");
			
			//	setStageButtons();
			
			//	mainTimer.start();
						
			//	mainTimer.addEventListener( TimerEvent.TIMER_COMPLETE, timerHandler );
			
			//	captions.push(caption1);
						
		}


		//	function: assignButtonListeners -
		
		private function intro( action:String) : void
		{
			var seq1:HydroSequence = new HydroSequence(
			
				{target:backgroundStripes, x:-20, y:0, duration:4, advance: new OnDurationComplete(2) },

				{target:introTitle, alpha:1, duration:2 }
							
			);

			seq1.start();
		
		}
						
			
		//	function: assignButtonListeners -
		
		private function setStageButtons():void
		{
			//	stage1.addEventListener(MouseEvent.CLICK, stageButtonClick );
			
			//	stage1.buttonNumber.text = 1;
			
		}
						
			
		//	function: disableButtons
		
		private function disableButtons():void
		{
			//	stage1.removeEventListener(MouseEvent.CLICK, stageButtonClick );
						
		}


		private	function introClickHandler (e:MouseEvent): void 
		{			
			createMainMenu();
			
		}
		
		
		//	function: starts the build main menu sequence 
		
		private function createMainMenu():void
		{
			if ( !mainMenu )
			{
				mainMenu = new MainMenu();
				
				mainMenu.x = 1040;
				mainMenu.y = -10;
				
				this.addChild(mainMenu);
				
				this.swapChildren(introTitle, mainMenu);
				
				//	tween mainMenu to position
				
				HydroTween.go( mainMenu, {x:280}, 3, 0, null, onComplete  );


				var seq1:HydroSequence = new HydroSequence(
				
					//	{target:mainMenu, x:280, duration:3, advance: new OnDurationComplete(.4) },
					
					{target:mainMenu, x:280, duration:1, advance: new OnDurationComplete(.3) },
	
					{target:introTitle, alpha:0, duration:2, func: onComplete, scope:this }
								
				);
				
				//	seq1.addItem([{target:productBoxes.MetabolicTesting, x:720, scaleX: .82, scaleY: .82, alpha:1, duration:.4, func:boxEventHandlers, args:["activate"], scope:this}]);
				
				seq1.start();

				
				
				
			}

		}


		
		private function onComplete() : void
		{
			this.removeChild(introTitle);
			
			//	mainMenu.buildMenu();
			
			trace ('onComplete called!')
		
		}



		/*	function: assignLabelEvents - makes an object containg all frame labels and assigns an _onFrameLabel to each labelled frame
		
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
		*/
		
		/*
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
		*/


		//		***		FRAME LABEL EVENTS	***
		
		/*
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
			
			trainMovie.train.gotoAndPlay('idle');
			
			//	sign.buyNowButton.alpha = 100;
						
		}		
		*/

		//		***		EVENT HANDLER FUNCTIONS 	***


		private function movieClick(e:Event):void 
		{	
			//	var content:String = e.currentTarget.content;
			
			//	trace ("view video: ", video );

			this.play();
			
		}



	}

}