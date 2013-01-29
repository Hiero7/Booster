package  
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.tweens.misc.*;
	import net.flashpunk.utils.*;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Bijan
	 */
	public class Enemy extends Entity 
	{
		public var mLevel:Level;
		public var isDead:Boolean = false;
		
		public var sfxDie:Sfx = new Sfx(Assets.EDIESFX);
		
		public function Enemy(locX:Number, locY:Number, currLevel:Level) 
		{
			x = locX;
			y = locY;
			layer = 2;
			type = "enemy";
			mLevel = currLevel;
			setHitbox(32, 32, 0, 0);
		}
		
		override public function update():void
		{
			super.update();
		}
		
		public function destroy():void
		{
			sfxDie.play();
			isDead = true;
		}
	}

}