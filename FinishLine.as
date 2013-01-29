package  
{
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author Bijan
	 */
	public class FinishLine extends Entity 
	{
		
		public function FinishLine(locX:Number, locY:Number) 
		{
			type = "finish";
			setHitbox(32, 64, 0, 0);
			x = locX;
			y = locY;
		}
		
	}

}