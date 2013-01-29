package  
{
	/**
	 * ...
	 * @author Bijan
	 */
	import flash.display.BitmapData;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	public class GameWorld extends World
	{
		public var player:Player;
		public var level:Level;
		public var cam:Camera;
		public var timer:GameTimer;
		public var hardMode:Boolean;
		
		private var background:Background;
		private var backgroundObj:BackgroundObj;
		private var lvlCounter:int;
		
		protected var mapImage:Image;
		protected var mapGrid:Grid;
		
		protected var sfxLevel1:Sfx = new Sfx(Assets.GFREAKMP3);
		protected var sfxLevel2:Sfx = new Sfx(Assets.DATMP3);
		protected var sfxLevel3:Sfx = new Sfx(Assets.GANBAREMP3);
		protected var sfxLevel4:Sfx = new Sfx(Assets.BUDANGMP3);
		protected var sfxLevel5:Sfx = new Sfx(Assets.RISEMP3);
		
		public function GameWorld(mode:Boolean = false) 
		{
			lvlCounter = 1;
			hardMode = mode;
			super();
			loadLevel(Assets.LEVEL_ONE);
			timer = new GameTimer(this);
			add(timer);
		}
		
		override public function begin():void 
		{
			super.begin();
		}
		
		public function loadLevel(mapData:Class):void
		{
			level = new Level(mapData, this);
			background = new Background(mapData);
			backgroundObj = new BackgroundObj(mapData);
			player = level.player;
			cam = new Camera(this);
			
			add(player);
			add(level);
			add(background);
			add(backgroundObj);
			add(cam);
			add(level.finish);
			for (var i:int = 0; i < level.obstaclesArray.length; i++)
				add(level.obstaclesArray[i]);
			for (var j:int = 0; j < level.enemyHArray.length; j++)
				add(level.enemyHArray[j]);
			for (var k:int = 0; k < level.enemyVArray.length; k++)
				add(level.enemyVArray[k]);
				
			//choose which track to play and camera profile to use
			switch(lvlCounter)
			{
				case 1:
					cam.setProfile("horizontal");
					if(!sfxLevel1.playing)
						sfxLevel1.loop(0.25);
					break;
				case 2:
					cam.setProfile("horizontal");
					if(!sfxLevel2.playing)
						sfxLevel2.loop(0.25);
					break;
				case 3:
					cam.setProfile("balanced");
					if(!sfxLevel3.playing)
						sfxLevel3.loop(0.25);
					break;
				case 4:
					cam.setProfile("vertical");
					if(!sfxLevel4.playing)
						sfxLevel4.loop(0.25);
					break;
				case 5:
					cam.setProfile("default");
					if(!sfxLevel5.playing)
						sfxLevel5.loop(0.25);
					break;
				default:
					break;
			}
		}
		
		//unload level and move to next one
		public function unloadLevelF():void
		{
			remove(player);
			remove(level);
			remove(background);
			remove(backgroundObj);
			remove(cam);
			remove(level.finish);
			for (var i:int = 0; i < level.obstaclesArray.length; i++)
				remove(level.obstaclesArray[i]);
			for (var j:int = 0; j < level.enemyHArray.length; j++)
				remove(level.enemyHArray[j]);
			for (var k:int = 0; k < level.enemyVArray.length; k++)
				remove(level.enemyVArray[k]);
			lvlCounter++;	
			switch(lvlCounter)
			{
				case 1:
					loadLevel(Assets.LEVEL_ONE);
					break;
				case 2:
					sfxLevel1.stop();
					loadLevel(Assets.LEVEL_TWO);
					break;
				case 3:
					sfxLevel2.stop();
					loadLevel(Assets.LEVEL_THREE);
					break;
				case 4:
					sfxLevel3.stop();
					loadLevel(Assets.LEVEL_FOUR);
					break;
				case 5:
					sfxLevel4.stop();
					loadLevel(Assets.LEVEL_FIVE);
					break;
				default:
					sfxLevel5.stop();
					FP.world = new GameOverScreen(timer.time, hardMode);
					break;
			}
		}
		
		//reset level if player dies
		public function unloadLevelR():void
		{
			remove(player);
			remove(level);
			remove(cam);
			
			//things to not reload if on level 5 due to size
			if (lvlCounter != 5)
			{
			remove(background);
			remove(backgroundObj);
			remove(level.finish);
			for (var i:int = 0; i < level.obstaclesArray.length; i++)
				remove(level.obstaclesArray[i]);
			}
			
			for (var j:int = 0; j < level.enemyHArray.length; j++)
				remove(level.enemyHArray[j]);
			for (var k:int = 0; k < level.enemyVArray.length; k++)
				remove(level.enemyVArray[k]);
			switch(lvlCounter)
			{
				case 1:
					loadLevel(Assets.LEVEL_ONE);
					break;
				case 2:
					loadLevel(Assets.LEVEL_TWO);
					break;
				case 3:
					loadLevel(Assets.LEVEL_THREE);
					break;
				case 4:
					loadLevel(Assets.LEVEL_FOUR);
					break;
				case 5:
					reloadLevelFive(Assets.LEVEL_FIVE);
					break;
				default:
					break;
			}
		}
		
		public function reloadLevelFive(mapData:Class):void  //special function to reduce loading time of level 5
		{
			level = new Level(mapData, this);
			player = level.player;
			cam = new Camera(this);
			
			add(player);
			add(level);
			add(cam);
			for (var j:int = 0; j < level.enemyHArray.length; j++)
				add(level.enemyHArray[j]);
			for (var k:int = 0; k < level.enemyVArray.length; k++)
				add(level.enemyVArray[k]);
				
			//choose which track to play and camera profile to use
			switch(lvlCounter)
			{
				case 5:
					cam.setProfile("default");
					if(!sfxLevel5.playing)
						sfxLevel5.loop(0.25);
					break;
				default:
					break;
			}
		}
		
		override public function update():void
		{
			super.update();
		}

	}

}