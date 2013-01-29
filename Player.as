package  
{
	/**
	 * ...
	 * @author Bijan
	 */
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.tweens.misc.*;
	import net.flashpunk.utils.*;
	import net.flashpunk.FP;
	
	public class Player extends Entity
	{
		public var image:Image;
		private var mLevel:Level;
		
		private var origX:Number = 0;
		private var origY:Number = 0;
		private var walkPower:Number = 0.12;
		private var dashPower:Number = 0.35;
		private var jumpPower:Number = 12;
		private var boostPower:Number = 1;
		private var h_kFriction:Number = 0.96;//kinetic friction(key pressed)
		private var h_sFriction:Number = 0.85; //static friction (key not pressed)
		private var h_aFriction:Number = 0.97;//air friction (jumping)
		private var vFriction:Number=0.99;
		public  var xSpeed:Number=0;
		private var ySpeed:Number = 0;
		private var boostSpeed:Number = 0;
		private var gravity:Number = 0.5;
		private var doubleTapInterval:Number = 0.2;
		private var stopInterval:Number = 0.2;
		private var maxChargeTime:Number = 2; //2 seconds
		
		private var onTheGround:Boolean=false;
		private var isJumping:Boolean = true;
		private var hasAirBoosted:Boolean = false;
		private var isDashing:Boolean = false;
		private var isBoosting:Boolean = false;
		private var isInvuln:Boolean = false;
		private var isDead:Boolean = false;
		
		public var lives:int;
		
		public var sprBooster:Spritemap = new Spritemap(Assets.SPRSHEET, 54, 66);
		public var sprBoost:Spritemap = new Spritemap(Assets.BOOST, 72, 72);
		public var sprDie:Spritemap = new Spritemap(Assets.PLAYERDEATH, 80, 62, reset);
		
		public var sfxCharge:Sfx = new Sfx(Assets.CHARGESFX);
		public var sfxBoost:Sfx = new Sfx(Assets.BOOSTSFX);
		public var sfxJump:Sfx = new Sfx(Assets.JUMPSFX);
		public var sfxSprint:Sfx = new Sfx(Assets.SPRINTSFX);
		public var sfxDamage:Sfx = new Sfx(Assets.DAMAGESFX);
		public var sfxDie:Sfx = new Sfx(Assets.PDIESFX);
		
		private var particles:ChargeParticles;
		
		public function Player(currLevel:Level, mapX:Number=0, mapY:Number=0) 
		{
			sprBooster.add("idle", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], 10, true);
			sprBooster.add("walk", [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31], 20, true);
			sprBooster.add("run", [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47], 20, true);
			sprBooster.add("jump", [48, 49, 50, 51, 52, 53, 54, 55], 20, true);
			sprBoost.add("boost", [0, 1, 2, 3, 4, 5, 6, 7], 20, true);
			sprBoost.add("boostNE", [8, 9, 10, 11, 12, 13, 14, 15], 20, true);
			var arr:Array = new Array(48);
			for (var i:int = 0; i < 48; i++)
				arr[i] = i;
			sprDie.add("die", arr, 20, false);

			origX = mapX;
			origY = mapY;
			
			layer = 3;
			
			x = mapX;
			y = mapY;
			
			mLevel = currLevel;
			if (mLevel.mWorld.hardMode)
				lives = 1;
			else
				lives = 2;
		    setHitbox(30, 52, -14, -14);
			
			type = "player";
			
			super(x, y, sprBooster);
			sprBooster.play("idle", false);
			particles = new ChargeParticles(x, y, mLevel);
			mLevel.mWorld.add(particles);
		}
		
		private var tapTimer:Number = 0;  //count interval between double tap presses
		private var stopTimer:Number = 0;  //count how long player has been stopped
		private var chargeTimer:Number = 0;  //count how long charging
		private var boostTimer:Number = 0;
		private var invulnTimer:Number = 0;
		
		private var lastChargeTime:Number = 0;
		
		private var movingLeft:Boolean = false;
		private var movingRight:Boolean = false;
		
		override public function update():void
		{
			var pressed:Boolean = false;
			
			if (isInvuln)
			{
				invulnTimer += FP.elapsed;
				if (invulnTimer >= 1.6)
					visible = false;
				else if (invulnTimer >= 1.4)
					visible = true;
				else if (invulnTimer >= 1.2)
					visible = false;
				else if (invulnTimer >= 1.0)
					visible = true;
				else if (invulnTimer >= 0.8)
					visible = false;
				else if (invulnTimer >= 0.6)
					visible = true;
				else if (invulnTimer >= 0.4)
					visible = false;
				else if (invulnTimer >= 0.2)
					visible = true;
				else if (invulnTimer >= 0.1)
					visible = false;
			}
			if (invulnTimer >= 2)
			{
				visible = true;
				isInvuln = false;
				invulnTimer = 0;
			}
			
			if (Math.abs(xSpeed) > Globals.MAX_X_SPEED)
			{
				xSpeed = Globals.MAX_X_SPEED * FP.sign(xSpeed);
			}
			
			if (Math.abs(ySpeed) > Globals.MAX_Y_SPEED)
			{
				ySpeed = Globals.MAX_Y_SPEED * FP.sign(ySpeed);
			}

			if (isBoosting)
			{
				boostTimer += FP.elapsed;
			}
			if (boostTimer >= lastChargeTime && !isDead)
			{
				isBoosting = false;
				graphic = sprBooster;
				boostTimer = 0;
			}
			
			if (Input.check(Key.Z)  && !isDead)
			{
				particles.show();
				if (!sfxCharge.playing && chargeTimer>=0.1)
					sfxCharge.play(0.3);
				if (chargeTimer <= maxChargeTime)
					chargeTimer += FP.elapsed
				else
					chargeTimer = maxChargeTime;
			}
			if (Input.released(Key.Z) && !isDead)
			{
				particles.hide();
				sfxCharge.stop();
				
				//boosting
				if (chargeTimer >= 0.5)
				{
					sfxBoost.play(0.4);
					lastChargeTime = chargeTimer;
				}
				//sprinting
				else
				{
					if (!sfxSprint.playing)
						sfxSprint.loop();
					lastChargeTime = 0;
				}
				isDashing = true;
				isBoosting = true;

				boostSpeed = calculateBoost(chargeTimer);
				//boost direction logic
				if (Input.check(Key.UP) && Input.check(Key.LEFT) &&ySpeed!=0 && !hasAirBoosted)
				{
					hasAirBoosted = true;
					ySpeed = 0;
					ySpeed -= boostSpeed / 1.4;
					xSpeed -= boostSpeed / 2;
				}
				else if (Input.check(Key.DOWN) && Input.check(Key.LEFT) &&ySpeed!=0)
				{
					ySpeed = 0;
					ySpeed += boostSpeed / 1.4;
					xSpeed -= boostSpeed / 2;
				}
				else if (Input.check(Key.UP) && Input.check(Key.RIGHT) &&ySpeed!=0 && !hasAirBoosted)
				{
					hasAirBoosted = true;
					ySpeed = 0;
					ySpeed -= boostSpeed / 1.4;
					xSpeed += boostSpeed / 2;
				}
				else if (Input.check(Key.DOWN) && Input.check(Key.RIGHT) &&ySpeed!=0)
				{
					ySpeed = 0;
					ySpeed += boostSpeed / 1.4;
					xSpeed += boostSpeed / 2;
				}
				else if (Input.check(Key.UP) && !hasAirBoosted)
				{
					hasAirBoosted = true;
					ySpeed = 0;
					ySpeed -= boostSpeed;
				}
				else if (Input.check(Key.DOWN) &&ySpeed!=0)
				{
					ySpeed += boostSpeed;
				}
				else if (Input.check(Key.LEFT))
				{
					if (isBoosting && lastChargeTime>0 &&!isDead)
					{
						graphic = sprBoost;
						sprBoost.flipped = true;
						sprBoost.play("boost", false);
					}
					xSpeed -= boostSpeed;
				}
				else if (Input.check(Key.RIGHT))
				{
					if (isBoosting  && lastChargeTime>0 &&!isDead)
					{
						graphic = sprBoost;
						sprBoost.flipped = false;
						sprBoost.play("boost", false);
					}
					xSpeed += boostSpeed;
				}
				chargeTimer = 0;
			}
			if (Input.check(Key.LEFT) && !isDead) 
			{ 
				if (!Input.check(Key.RIGHT))
				{
					sprBooster.flipped = true;
					movingRight = false;
				}
					
				if (isDashing)
				{
					xSpeed -= dashPower;
					if (ySpeed == 0)
						sprBooster.play("run", false);
				}
				else
				{
					xSpeed -= walkPower;
					tapTimer += FP.elapsed;
					if (ySpeed == 0)
						sprBooster.play("walk", false);
				}
				movingLeft = true;
				pressed=true;
			}
			if (Input.released(Key.LEFT))
			{
				isDashing = false;
			}
			
			//check rightward movement
			if (Input.check(Key.RIGHT) && !isDead) 
			{ 
				if (!Input.check(Key.LEFT))
				{
					sprBooster.flipped = false;
					movingLeft = false;
				}
					
				if (isDashing)
				{
					xSpeed += dashPower;
					if (ySpeed == 0)
						sprBooster.play("run", false);
				}
				else
				{
					xSpeed += walkPower;
					tapTimer += FP.elapsed;
					if (ySpeed == 0)
						sprBooster.play("walk", false);
				}
				movingRight = true;	
				pressed=true;
			}
			if (Input.released(Key.RIGHT))
			{
				isDashing = false;
			}
			
			//allows jumping after *falling* off a platform 
			if (Input.check(Key.UP)  && !isJumping  &&!isDead) 
			{ 
				graphic = sprBooster;
				sfxJump.play(0.6);
				ySpeed = -jumpPower;
				isJumping=true;
			}

			
			if(this.collideWith(mLevel.map, x, y+1))
			{
				ySpeed=0;
				isJumping = false;
				
				if (Input.check(Key.UP) && !isDead) 
				{
					ySpeed = -jumpPower;
					isJumping = false;
				}
			}
			else 
			{
				ySpeed+=gravity;
			}
			
			if (ySpeed != 0 && !isDead)
			{
				sprBooster.play("jump", false);
			}
			
			if (Math.abs(xSpeed) < 1 && !pressed) 
			{
				stopTimer += FP.elapsed;
				if (stopTimer >= stopInterval)
				{
					movingLeft = false;
					movingRight = false;
					tapTimer = 0;
				}
				xSpeed = 0;
				if(ySpeed==0)
					sprBooster.play("idle", false);
			}
			
			//stop boosting if speed below threshold
			if (Math.abs(xSpeed) <= 14)
			{
				sfxSprint.stop();
				lastChargeTime = 0.5;
			}
			if (Math.abs(xSpeed) <= 14 && isBoosting &&!isDead)
			{
				graphic = sprBooster;
			}
			
			
			if (pressed && isJumping)
				xSpeed *= h_aFriction;
			else if (pressed)
				xSpeed *= h_kFriction;
			else
				xSpeed *= h_sFriction;
				
			ySpeed*=vFriction;
			adjustXPosition();
			adjustYPosition();
			
			var eCollide:Enemy = collide("enemy", x, y) as Enemy;
			
			if (collide("obstacle", x, y) && !isDead)
			{
				if (!isInvuln)
				{
					lives--;
					if (lives > 0)
					{
						sfxDamage.play(0.6);
						isInvuln = true;
					}
					xSpeed = 0;
					
				}
				if (lives == 0)
				{
					die();
				}
			}
			if (eCollide && !isDead && !eCollide.isDead)
			{
				if (isBoosting)
					eCollide.destroy();
				else
				{
					if (!isInvuln)
					{
						lives--;
						if (lives > 0)
						{
							sfxDamage.play(0.6);
							isInvuln = true;
						}
						xSpeed = 0;
					}
					if (lives == 0)
					{
						die();
					}
				}
			}
			if (collide("finish", x, y))
				finishLevel();
			
			super.update();
		}
		
		//returns the amount that will be added to speed after releasing the charge button
		private function calculateBoost(chargeTime:Number):Number
		{
			return 4*Math.pow(chargeTime+1,1.5)*boostPower;
		}
		
		private function adjustXPosition():void 
		{
			for (var i:int = 0; i < Math.abs(xSpeed); i++) 
			{
				if (! this.collideWith(mLevel.map, x+FP.sign(xSpeed),y)) 
				{
					x+=FP.sign(xSpeed);
				} 
				else if(! this.collideWith(mLevel.map, x + 2*FP.sign(xSpeed), y - 4))
				{
					y -= 4;
					x+=FP.sign(xSpeed)/1.4;
				}
				else if(! this.collideWith(mLevel.map, x + FP.sign(xSpeed), y - 8))
				{
					y -= 8;
					x+=FP.sign(xSpeed)/1.4;
				}
				else 
				{
					xSpeed=0;
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
					if (y > mLevel.mapHeight && !isDead)
					{
						isDead = true;
						reset();
					}
				} 
				else 
				{
					hasAirBoosted = false;
					ySpeed=0;
					break;
				}
			}
		}
		public function die():void
		{
			isDead = true;
			particles.hide();
			graphic = sprDie;
			sfxDie.play(2);
			sprDie.play("die");
			sprDie.flipped = sprBooster.flipped;
		}
		
		public function reset():void
		{
			mLevel.mWorld.remove(particles);
			mLevel.mWorld.unloadLevelR();
		}
		
		public function finishLevel():void
		{
			mLevel.mWorld.remove(particles);
			mLevel.mWorld.unloadLevelF();
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
	}

}