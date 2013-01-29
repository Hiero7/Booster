package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Bijan
	 */
	//jumping enemy
	public class EnemyV extends Enemy 
	{
		private var jumpPower:Number = 16;
		private var vFriction:Number=0.99;
		private var ySpeed:Number = 0;
		private var gravity:Number = 0.5;
		private var isJumping:Boolean = false;
		private var jumpDelay:Number = 1; //1 second delay between jumps
		private var animDelay:Number = 0.7;
		//private var mLevel:Level;
		public var sprEnemyV:Spritemap = new Spritemap(Assets.ENEMYV, 66, 52);
		public var sprEVDie:Spritemap = new Spritemap(Assets.ENEMYDEATH, 66, 52);
		public function EnemyV(locX:Number, locY:Number, currLevel:Level) 
		{
			sprEnemyV.add("jump", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 20, false);
			sprEnemyV.add("fall", [10, 11, 12, 13, 14, 15, 6, 0], 20, false);
			sprEVDie.add("die", [13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25], 10,false);
			graphic = sprEnemyV;
			super(locX, locY, currLevel);
			setHitbox(50, 25, -7, -8);
		}
		
		private var jumpTimer:Number = 0;
		override public function update():void
		{
			if(this.collideWith(mLevel.map, x, y+1))
			{
				ySpeed=0;
				isJumping = false;
				
				jumpTimer += FP.elapsed;
				
				if(jumpTimer >= animDelay  && !isDead)
					sprEnemyV.play("jump", false);
				if (jumpTimer >= jumpDelay && !isDead)
				{
					jumpTimer = 0;
					ySpeed = -jumpPower;
					isJumping = true;
					setHitbox(40, 25, -13, -8);
				}
				
			}
			else 
			{
				ySpeed += gravity;
				if (ySpeed >= 0 && !isDead)
					sprEnemyV.play("fall", false);
			}
			ySpeed *= vFriction;
			adjustYPosition();
			super.update();
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
					setHitbox(50, 25, -7, -8);
					ySpeed=0;
					break;
				}
			}
		}
		
		override public function destroy():void
		{
			super.destroy();
			graphic = sprEVDie;
			sprEVDie.play("die");
		}
	}

}