/** * Copyright (c) 2007 Moses Gunesch *  * Permission is hereby granted, free of charge, to any person obtaining a copy * of this software and associated documentation files (the "Software"), to deal * in the Software without restriction, including without limitation the rights * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell * copies of the Software, and to permit persons to whom the Software is * furnished to do so, subject to the following conditions: *  * The above copyright notice and this permission notice shall be included in * all copies or substantial portions of the Software. *  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN * THE SOFTWARE. */package com.mosesSupposes.go.tests {	import flash.display.Sprite;	import flash.events.MouseEvent;		import org.goasap.events.GoEvent;	import org.goasap.events.SequenceEvent;	import org.goasap.utils.SequenceCA;	import org.goasap.utils.customadvance.OnDurationComplete;	import org.goasap.utils.customadvance.OnPlayableComplete;		import com.mosesSupposes.go.tutorials.blocktweenmg.BlockParserMG;		import fl.controls.Button;	import fl.motion.easing.*;		/**	 * Be sure you look at TBlockTweenMG and TBlockParserMG first, this is part 3.	 * 	 * After you check out these sequences, I wanted to point something out.	 * If you open up BlockParserMG and look at the parseAction() method,	 * just for fun delete the "custom advance" block temporarily, because 	 * that's sort of a special feature. Without that in there I wanted to show	 * you how incredibly simple the parser is -- just a few lines of code!! 	 * 	 * @author Moses Gunesch	 */	public class TBlockParserMG2 extends GoTestBase {		protected var seq1 : SequenceCA;		protected var seq2 : SequenceCA;				protected var targ1 : Sprite;		protected var targ2 : Sprite;		public function TBlockParserMG2() 		{			// BlockParserMG example #2: A basic sequence			targ1 = super.box(40);			seq1 = BlockParserMG.sequence(										{ target: targ1,							  x:50,							  scaleX:1.5,							  duration:.5,							  useRelative:true,							  easing:Quadratic.easeIn							},																						{ target: targ1,							  y:-10,							  scaleY:1.5,							  duration:.5,							  useRelative:true,							  easing:Quadratic.easeOut							},																					{ target: targ1,							  rotation:360,							  alpha:-.25,							  useRelative:true							}																					);																								seq1.stop(); // sequence() starts immediately, but for testing here I'm leaving it to the button UI.													seq1.playableID = "Example 1";			seq1.addEventListener(SequenceEvent.ADVANCE, super.traceEvent);			seq1.addEventListener(GoEvent.COMPLETE, super.traceEvent);						// LOOP feature (Part of the Go sequencing framework, not BlockParserMG.) 			// This sequence will play twice ... default is 1 ... 0=infinite. 			// The useRelative option is used in all actions so it will keep changing.			//	seq1.repeatCount = 2;									// --									// The 2nd example shows parallel & custom-advance features.						targ2 = super.box(120);			seq2 = BlockParserMG.sequence([ // a parallel-action array runs 2 different tweens at once.										   { target: targ2,                                             x:400,                                             duration:3,                                             easing:Cubic.easeInOut                                            },                                                                                      { target:targ2,                                           	 scaleX:8,                                           	 duration:1,                                           	 easing:Elastic.easeOut,				                        	 // custom-advance example #1: determines when sequence advances 				                        	 // advance early for overlapped tweens - here after this tween completes				                        	 // while the x tween (the other action in this group) continues to play.                                           	 advance:new OnPlayableComplete()                                           }                                          ],                                          // Drop & bounce while still sliding over...                                          { target: targ2,                                             y:80,                                             useRelative:true,                                             scaleY:5,                                             duration:2,                                             easing:Bounce.easeOut,				                        	// custom-advance example #2: advance after 3/4 of a second.				                        	// there are other types as well like OnEventComplete & OnConditionTrue				                        	// plus you can write your own custom advance types.                                             advance: new OnDurationComplete(.75)                                            },                                                                                      // Spin & fade out while still sliding & bouncing                                           { target: targ2,                                             rotation:360,                                             alpha:0,                                             easing:Back.easeInOut                                           });			seq2.stop(); // sequence() starts immediately, but for testing here I'm leaving it to the button UI.			//	seq2.id = "Example 2";			seq2.addEventListener(SequenceEvent.ADVANCE, super.traceEvent);			seq2.addEventListener(GoEvent.COMPLETE, super.traceEvent);									// -						// Test UI			super.addButtonUI(seq1, 1); // 2nd param: skipToAmount (skipTo jumps to a play index in the sequence.)			super.addButtonUI(seq2, 1);			var b:Button = new Button();			addChild(b);			b.label = "reset";			b.x = buttonX;			b.y = buttonY;			b.addEventListener(MouseEvent.MOUSE_DOWN, reset);		}		protected function reset(event : MouseEvent) : void {			trace("\n* reset *");			seq1.stop();			seq2.stop();			targ1.x = targ2.x = 100;			targ1.y = 140;			targ2.y = 220;			targ1.alpha = targ2.alpha = 1;			targ1.scaleX = targ2.scaleX = 1;			targ1.scaleY = targ2.scaleY = 1;		}	}}