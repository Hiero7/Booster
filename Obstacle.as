package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Bijan
	 */
	public class Obstacle extends Entity 
	{
		
		public function Obstacle(locX:Number, locY:Number) 
		{
			var sprite:Image = new Image(Assets.OBSTACLE);
			x = locX;
			y = locY;
			type = "obstacle";
			layer = 2;
			setHitbox(16, 16, 0, 0);
			super(x, y, sprite);
		}
		override public function update():void
		{
			super.update();
		}
	}

}