package 
{
	/**
	 * ...
	 * @author Bijan
	 */
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	[SWF(width = "1000", height = "660")]
	public class Main extends Engine
	{

		public function Main():void 
		{
			super(1000, 660, 60, false);	
		}
		
		override public function init():void
		{
			super.init();
			FP.world = new TitleScreen();
		}
		

	}
}	