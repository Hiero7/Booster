package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.Sfx
	
	/**
	 * ...
	 * @author Bijan
	 */
	public class TitleScreen extends World 
	{
		protected var background:Entity;
		protected var stripe:Entity;
		protected var titleText:Entity;
		protected var titleFlash:Image;
		protected var hasPlayedTitle:Boolean = false;
		protected var normalText:Text;
		protected var hardText:Text;
		protected var lastTime:String;
		protected var lastMode:Boolean;
		protected var sfxClick:Sfx = new Sfx(Assets.CLICKSFX);
		protected var sfxStart:Sfx = new Sfx(Assets.STARTSFX);
		protected var IntroMP3:Sfx = new Sfx(Assets.INTROMP3);
		
		public function TitleScreen(last_Time:String = "0:00", last_Mode:Boolean = false) 
		{
			lastTime = last_Time;
			lastMode = last_Mode;
			super();
		}
		
		override public function begin():void
		{

			background = addGraphic(new Image(Assets.TITLE_BKGND));

			stripe = addGraphic(new Image(Assets.TITLE_STRIPE));
			stripe.x = -FP.width;
			stripe.y = FP.halfHeight/6;

			titleText = addGraphic(new Image(Assets.TITLE_TEXT));
			titleText.x = -FP.width;
			titleText.y = FP.halfHeight/6;

			titleFlash = new Image(Assets.TITLE_FLASH);
			titleFlash.alpha = 0;
			addGraphic(titleFlash);
			
			var stripeTween:VarTween = new VarTween(onIn);
			stripeTween.tween(stripe,"x",0, 0.5, Ease.expoInOut);
			addTween(stripeTween,true);
			
			

		}
		protected function onIn():void
		{
			var titleTween:VarTween = new VarTween(flashIn);
			titleTween.tween(titleText,"x",0, 0.75, Ease.expoInOut);
			addTween(titleTween,true);
		}
		protected function flashIn():void
		{
			sfxStart.play(0.5);
			IntroMP3.loop(0.5);
			var flashInTween:VarTween = new VarTween(flashOut);
			flashInTween.tween(titleFlash,"alpha",1, 0.15, Ease.quadIn);
			addTween(flashInTween, true);
		}
		protected function flashOut():void
		{	
			var flashOutTween:VarTween = new VarTween(textIn);
			flashOutTween.tween(titleFlash,"alpha",0, 0.25, Ease.quadOut);
			addTween(flashOutTween,true);
		}
		
		
		protected function textIn():void
		{
			Text.size = 32;
			if (lastTime != "0:00" && !lastMode)
				normalText = new Text("play normal. Last Time: " + lastTime);
			else
				normalText = new Text("play normal (2 lives per level)");
			normalText.x = FP.screen.width/2 - normalText.width/2;
			normalText.y = FP.screen.height - 200;
			//normalText.color = 0;
			normalText.alpha = 0;
			addGraphic(normalText, -1);
			var textTween:VarTween = new VarTween(onTextFade);
			textTween.tween(normalText, "alpha",1,0.5,Ease.quadIn);
			addTween(textTween, true);
			
			if (lastTime != "0:00" && lastMode)
				hardText = new Text("play hard. Last Time: " + lastTime);
			else
				hardText = new Text("play hard (1 life per level)");
			hardText.x = FP.screen.width/2 - normalText.width/2;
			hardText.y = FP.screen.height - 100;
			hardText.alpha = 0;
			addGraphic(hardText, -1);
			var textTween2:VarTween = new VarTween(onTextFade);
			textTween2.tween(hardText, "alpha",1,1.0,Ease.quadIn);
			addTween(textTween2, true);
			
		}

		protected function onTextFade():void
		{
			hasPlayedTitle = true;
		}
		
		override public function update():void
		{
			if (hasPlayedTitle)
			{
				if (Input.mousePressed && mouseY < 530)
				{
					if(!sfxClick.playing)
						sfxClick.play();
					IntroMP3.stop();
					FP.world = new GameWorld();
				}
				else if (Input.mousePressed && mouseY > 530)
				{
					if(!sfxClick.playing)
						sfxClick.play();
					IntroMP3.stop();
					FP.world = new GameWorld(true);
				}
			}
		}
	}

}