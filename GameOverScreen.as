package  
{
	import net.flashpunk.World;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.tweens.misc.*;
	import net.flashpunk.utils.*;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Bijan
	 */
	public class GameOverScreen extends World 
	{
		protected var finalTime:String;
		protected var mode:Boolean;
		protected var OutroMP3:Sfx = new Sfx(Assets.DEATHTINYMP3);
		protected var stripe:Image;
		protected var finishText:Text;
		protected var resultsText:Text;
		protected var returnText:Text;
		protected var hasPlayed:Boolean = false;
		
		public function GameOverScreen(final_Time:String, hard_mode:Boolean) 
		{
			finalTime = final_Time;
			mode = hard_mode;
			super();
		}
		
		override public function begin():void
		{
			OutroMP3.play(0.5);

			stripe = new Image(Assets.TITLE_STRIPE);
			stripe.x = 0;
			stripe.y = FP.halfHeight / 6;
			stripe.alpha = 0;
			addGraphic(stripe);
			
			Text.size = 100;
			finishText = new Text("Congratulations!");
			finishText.x = FP.screen.width/2 - finishText.width/2;
			finishText.y = FP.halfHeight-100;
			finishText.alpha = 0;
			//finishText.color = 0;
			addGraphic(finishText, -1);
			
			var textTween:VarTween = new VarTween(showText);
			textTween.tween(finishText, "alpha",1,4.0,Ease.quadIn);
			addTween(textTween, true);
			
			var stripeTween:VarTween = new VarTween();
			stripeTween.tween(stripe,"alpha",1, 2.0, Ease.quadIn);
			addTween(stripeTween,true);

		}
		
		public function showText():void
		{
			Text.size = 40;
			resultsText = new Text("Your final time: " + finalTime);
			resultsText.x = FP.screen.width/2 - resultsText.width/2;
			resultsText.y = FP.halfHeight+100;
			resultsText.alpha = 0;
			addGraphic(resultsText, -1);

			var textTween:VarTween = new VarTween(retText);
			textTween.tween(resultsText, "alpha",1,2.0,Ease.quadIn);
			addTween(textTween, true);
			
			
		}
		
		public function retText():void
		{
			returnText = new Text("Click to Return");
			returnText.x = FP.screen.width/2 - returnText.width/2;
			returnText.y = FP.halfHeight+200;
			returnText.alpha = 0;
			addGraphic(returnText, -1);
			
			var textTween:VarTween = new VarTween(onTextFade);
			textTween.tween(returnText, "alpha",1,2.0,Ease.quadIn);
			addTween(textTween, true);
		}
		
		protected function onTextFade():void
		{
			hasPlayed = true;
		}
		
		override public function update():void
		{
			if (Input.mousePressed && hasPlayed)
			{
				OutroMP3.stop();
				FP.world = new TitleScreen(finalTime, mode);
			}
		}
	}

}