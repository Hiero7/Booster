package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Bijan
	 */
	public class Camera extends Entity 
	{
		private var m_player:Player;
		private var m_world:GameWorld;
		
		private var cameraOffset:Number = 200;
		private var cameraSpeed:Number = 0;
		private var cameraAccel:Number = 1;
		private var cameraPadding:int = 10;
		private var mapWidth:Number = 0;
		private var mapHeight:Number = 0;
		//1: horizontal, positioned ahead of player, no y movement
		//2: balanced, positioned evenly, y movement
		//3: vertical, y movement, no x movement
		//4: default: x movement, y movement, ahead of player
		private var cameraProfile:int = 1;
		
		public function Camera(world:GameWorld) 
		{
			m_player = world.player;
			m_world = world;
			mapWidth = m_world.level.mapWidth;
			mapHeight = m_world.level.mapHeight;
			x = FP.camera.x = 0;
			y = FP.camera.y = 0;
		}
		
		override public function update():void
		{
			
			switch(cameraProfile)
			{
			case 1:
				x = FP.camera.x = m_player.x - FP.halfWidth/2;
				break;
			case 2:
				x = FP.camera.x = m_player.x - FP.halfWidth;
				break;
			case 3:
				y = FP.camera.y = m_player.y - FP.halfHeight;
				break;
			default:
				x = FP.camera.x = m_player.x - FP.halfWidth;
				y = FP.camera.y = m_player.y - FP.halfHeight;
				break;
			}
			
		}
		
		public function setProfile(profile:String):void
		{
			switch(profile)
			{
				case "horizontal":
					cameraProfile = 1;
					break;
				case "balanced":
					cameraProfile = 2;
					break;
				case "vertical":
					cameraProfile = 3;
					break;
				default:
					cameraProfile = 4;
					break;
			}
		}
		
	}

}