package
{
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	
    public class GameTimer extends Entity
    {
        private var seconds:Number = 0;
		private var minutes:int = 0;
		private var paused:Boolean = false;
		private var mWorld:GameWorld;
		
		public var time:String;
		
        public function GameTimer(gameWorld:GameWorld)
        {
            graphic = new Text("00000000");
			graphic.scrollX = 0;
			graphic.scrollY = 0;
			time = minutes.toString() +":"+ int(seconds).toString();
			Text(graphic).text = time;
			Text(graphic).scale = 1.5;
			mWorld = gameWorld;
			x = mWorld.cam.x+FP.halfWidth*1.8;
			y = mWorld.cam.y+FP.halfHeight/8;
			layer = 0;
        }
 
        override public function update():void
        {
			if(!paused)
				seconds += FP.elapsed;
			if (seconds >= 60)
			{
				seconds = 0;
				minutes++;
			}
			
			if (seconds < 10)
				time = minutes.toString() +":0" + int(seconds).toString();
			else
				time = minutes.toString() +":"+ int(seconds).toString();
 
            Text(graphic).text = time;
        }
		
		public function pause():void
		{
			paused = true;
		}
		public function resume():void
		{
			paused = false;
		}
        public function bonusTime():void
		{
			seconds -= 10;
		}
 
    }
 
}