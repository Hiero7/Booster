package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;
	import net.flashpunk.FP;
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author Bijan
	 */
	//walking enemy
	public class EnemyH extends Enemy 
	{
		private var mDirection:int = -1; //1 right, -1 left
		private var xSpeed:Number = 0;
		private var movePower:Number = 2;
		private var hFriction:Number = 0.95
		private var vFriction:Number=0.99;
		private var ySpeed:Number = 0;
		private var gravity:Number = 0.5;
		
		//private var mLevel:Level;
		public var sprEnemyH:Spritemap = new Spritemap(Assets.ENEMYH, 58, 35);
		public var sprEHDie:Spritemap = new Spritemap(Assets.ENEMYDEATH, 66, 52);
		public function EnemyH(locX:Number, locY:Number, currLevel:Level) 
		{
			sprEnemyH.add("walk", [0, 1, 2, 3, 4, 5, 6, 7], 20, true);
			sprEHDie.add("die", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],10, false);
			graphic = sprEnemyH;
			super(locX, locY, currLevel);
			setHitbox(50, 25, 0, -9);
			sprEnemyH.play("walk", false);
			sprEnemyH.flipped = true;
		}
		override public function update():void
		{
			if (!isDead)
			{
				xSpeed = mDirection * movePower;
			}
			//xSpeed *= hFriction;

			if(this.collideWith(mLevel.map, x, y+1))
			{
				ySpeed=0;
			}
			else 
			{
				ySpeed+=gravity;
			}
			if (! this.collideWith(mLevel.map, x+(FP.sign(xSpeed)*10), y + 1)) //if would fall, turn around
			{
				mDirection *= -1;
				sprEnemyH.flipped = !sprEnemyH.flipped;
			}
			ySpeed *= vFriction;
			
			adjustXPosition();
			adjustYPosition();
			super.update();
		}
		
		private function adjustXPosition():void 
		{
			for (var i:int = 0; i < Math.abs(xSpeed); i++) 
			{
				if (! this.collideWith(mLevel.map, x+FP.sign(xSpeed),y)) 
				{
					x+=FP.sign(xSpeed);
				} 
				else 
				{
					//flip direction
					xSpeed = 0;
					mDirection *= -1;
					sprEnemyH.flipped = !sprEnemyH.flipped;
					break;
				}
			}
		}
		private function adjustYPosition():void 
		{
			for (var i:int = 0; i < Math.abs(ySpeed); i++) 
			{
				if (! this.collideWith(mLevel.map, x,y+FP.sign(ySpeed))) 
				{
					y += FP.sign(ySpeed);
					if (y > mLevel.mapHeight)
						{
							FP.world.remove(this);
						}
				} 
				else 
				{
					ySpeed=0;
					break;
				}
			}
		}
		
		override public function destroy():void
		{
			super.destroy();
			xSpeed = 0;
			graphic = sprEHDie;
			sprEHDie.flipped = sprEnemyH.flipped;
			sprEHDie.play("die");
		}
		
	}
}