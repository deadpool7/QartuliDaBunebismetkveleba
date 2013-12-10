﻿
package
{
	import flash.display.MovieClip;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.*
	import com.greensock.easing.*
	import flash.utils.*;
	import flash.text.*;
	
	
	public class SixTextClass extends MovieClip
	{
		private var sixthText:MovieClip;
		private var textBG:MovieClip;		
		
		private var wordsArray:Array;
		private var wrongwordsArray:Array;
		private var currectwordsArray:Array;
		private var wordsArray1:Array
		
		private var currWidth:Number;
		private var currScale:Number
		
		private var randomNumber:int;
		
		private var error:SoundControl;
		
		
		private var soundControl:SoundControl;
		private var _stageHeight:Number;
		private var _stageWidth:Number;
				
		
		public function SixTextClass(_stageWidth:Number = 1024, _stageHeight:Number = 768)
		{
			this._stageHeight = _stageHeight;
			this._stageWidth = _stageWidth;
			addEventListener(Event.ADDED_TO_STAGE, initHandler, false, 0, true)
			addEventListener(Event.REMOVED_FROM_STAGE, destroy)	
		}
		private function destroy(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			
			TweenMax.killTweensOf(textBG);
			if (sixthText)
			{
				removeChild(sixthText);
				sixthText = null;
			}
			if (error)
			{
				removeChild(error)
				error = null;
			}
			for (var i:int = 0; i < wordsArray1.length; i++)
			{
				wordsArray1[i].removeEventListener(MouseEvent.MOUSE_DOWN, wrongTextHandler)
			}
			wordsArray[randomNumber].removeEventListener(MouseEvent.MOUSE_DOWN, textClickHandler)
		}
		private function initHandler(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initHandler);
			initSixText();
		}
		
		private function initSixText():void
		{
			sixthText = new SixthText();
			
			addChild(sixthText);
		
			
			sixthText.x = _stageWidth / 2;
			sixthText.y = _stageHeight / 2;
			
			sixthText.height = _stageHeight / 13;
			sixthText.scaleX = sixthText.scaleY;   
			
			//////Arrays
			wordsArray = [sixthText.dzveli, sixthText.yvelam, sixthText.daiviwya]
			
			//
			
			randomNumber = Math.round(Math.random() * 2);
			
			wrongwordsArray = ["ხველი", "ყველა", "დავიშყა"]
			
			//
			//MouseEvent
			wordsArray[randomNumber].text = wrongwordsArray[randomNumber];
			wordsArray[randomNumber].addEventListener(MouseEvent.MOUSE_DOWN, textClickHandler)
			
			//
			currectwordsArray = ["ძველი", "ყველამ", "დაივიწყა."]
			
			//
			
			wordsArray1 = [sixthText.dzveli, sixthText.yvelam, sixthText.daiviwya, sixthText.tvitmfrinavi, sixthText.ki]
			
			//
			
			wordsArray1.splice(randomNumber, 1);
			
			for (var i:int = 0; i < wordsArray1.length; i++)
			{
				wordsArray1[i].addEventListener(MouseEvent.MOUSE_DOWN, wrongTextHandler);
			}
			
			
			
			//about textBackground
			textBG = new TextBack();
			
			sixthText.addChild(textBG);
			textBG.alpha = 0;
			textBG.parent.setChildIndex(textBG, 0);
			
		
			//////////////////////
		
		}
		
		private function wrongTextHandler(e:MouseEvent):void
		{
			
			error = new SoundControl();
			if (error.soundIsPlaying())
			{
				return
			}			
			error.loadSound("error.mp3", .5);			
			addChild(error);
			error.soundPlay();
			
		}
		
		private function textClickHandler(e:MouseEvent):void
		{
			if (error)
			{
				error.soundStop();
			}
			if (wordsArray[randomNumber].text != currectwordsArray[randomNumber])
			{
				
				wordsArray[randomNumber].text = currectwordsArray[randomNumber]
				currWidth = wordsArray[randomNumber].width;
				
				wordsArray[randomNumber].textColor = 0xD9C0A2
				currScale = currWidth / textBG.width;
				textBG.width = currWidth;
				textBG.x = wordsArray[randomNumber].x + wordsArray[randomNumber].width / 2
				textBG.y = wordsArray[randomNumber].y + wordsArray[randomNumber].height / 2
				
				//TextBgMove();
				TweenMax.fromTo(textBG, 0.5, {scaleX: 0}, {alpha: 1, scaleX:currScale})
				
			
				soundControl = new SoundControl;
				soundControl.loadSound("correct.mp3", 1);
				addChild(soundControl);
				soundControl.soundPlay();
				
			}

		
				
			
			setTimeout(destroyCall, 2000);
		}
		
		private function destroyCall():void 
		{
			
			dispatchEvent(new DataEvent(DataEvent.DATA, false, false, "endOfStage"))
			destroy(null);				
		}
		
		
		
		
	}

}

