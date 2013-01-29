package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Bijan
	 */
	public class ChargeParticles extends Entity 
	{
		public var sprCharge:Spritemap = new Spritemap(Assets.CHGPARTSHEET, 83, 91);
		private var mLevel:Level;
		
		public function ChargeParticles(playerX:Number, playerY:Number, currLevel:Level) 
		{
			layer = 1;
			x = playerX-10;
			y = playerY-10;
			mLevel = currLevel;
			sprCharge.add("charge", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19], 20, true);
			sprCharge.play("charge", false);
			super(x, y, sprCharge);
			visible = false;
		}
		override public function update():void
		{
			x = mLevel.player.x-10;
			y = mLevel.player.y-10;
			super.update();
		}
		public function show():void
		{
			visible = true;
		}
		public function hide():void
		{
			visible = false;
		}
	}

}