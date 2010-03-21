/** * Copyright (c) 2007 Moses Gunesch *  * Permission is hereby granted, free of charge, to any person obtaining a copy * of this software and associated documentation files (the "Software"), to deal * in the Software without restriction, including without limitation the rights * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell * copies of the Software, and to permit persons to whom the Software is * furnished to do so, subject to the following conditions: *  * The above copyright notice and this permission notice shall be included in * all copies or substantial portions of the Software. *  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN * THE SOFTWARE. */package com.mosesSupposes.go.tutorials {	import flash.display.DisplayObject;		import org.goasap.items.LinearGo;		/**	 * This simple x/y tween class is featured in Go Video Tutorial #1,	 * "Build a Go tween class in 3 easy steps," available at go.mosessupposes.com.	 * 	 * @author Moses Gunesch	 */	public class MotionTweenStu extends LinearGo {		public function get target() : DisplayObject {			return _target;		}		public function set target(target : DisplayObject) : void {			if (super._state==STOPPED) {				_target = target;			}		}				public function get xTo() : Number {			return _xTo;		}				public function set xTo(xTo : Number) : void {			if (super._state==STOPPED) {				_xTo = xTo;			}		}				public function get yTo() : Number {			return _yTo;		}				public function set yTo(yTo : Number) : void {			if (super._state==STOPPED) {				_yTo = yTo;			}		}				protected var _target : DisplayObject;		protected var _xTo: Number;		protected var _yTo: Number;		protected var _startX : Number;		protected var _startY : Number;		protected var _changeX : Number;		protected var _changeY : Number;				public function MotionTweenStu(target : DisplayObject=null, 						xTo:Number=NaN, 						yTo:Number=NaN, 						easing:Function=null						) 			{						if (target!=null) {				this.target = target;			}			if (isNaN(xTo)==false) {				this.xTo = xTo;			}			if (isNaN(yTo)==false) {				this.yTo = yTo;			}			if (easing!=null) {				super._easing = easing;			}		}		override public function start():Boolean {						if (target==null || (isNaN(xTo) && isNaN(yTo))) {				return false;			}			if (isNaN(_xTo)==false) {				_startX = target.x;				if (super.useRelative) {					_changeX = _xTo;				}				else {					_changeX = (_xTo - _startX);				}			}			if (isNaN(_yTo)==false) {				_startY = target.y;				if (super.useRelative) {					_changeY = _yTo;				}				else {					_changeY = (_yTo - _startY);				}			}			return super.start();		}		//		Function to do the animating!!				override protected function onUpdate(type : String) : void {//			trace(super._position);			if (isNaN(_xTo)==false) {				target.x = super.correctValue( _startX + (_changeX * _position) );//				trace("x: "+target.x);			}			if (isNaN(_yTo)==false) {				target.y = super.correctValue( _startY + (_changeY * _position) );//				trace("y: "+target.y);			}		}	}}