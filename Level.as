package  
{
	import flash.display.BitmapData;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	import net.flashpunk.FP;

	/**
	 * ...
	 * @author Bijan
	 */
	public class Level extends Entity 
	{
		private var tiles:Tilemap;
		private var backgroundTiles:Tilemap;
		private var mapGrid:Grid;
		protected var mapImage:Image;
		public var map:Entity;
		public var player:Player;
		public var mapWidth:Number = 0;
		public var mapHeight:Number = 0;
		public var mWorld:GameWorld;
		public var obstaclesArray:Array;
		public var enemyHArray:Array;
		public var enemyVArray:Array;
		public var finish:FinishLine;
		
		public var tempObstacle:Obstacle;
		public function Level(mapData:Class, currWorld:GameWorld) 
		{
			mWorld = currWorld;
			
			type = "level";
			layer = 1;
			if (mapData != null)
			{
				loadLevel(mapData);
			}
			else
			{
				
				// Create a debug map.
				mapGrid = new Grid(640, 480, 16, 16, 0, 0);
				mapGrid.usePositions = true;
				mapGrid.setRect(0, 0, 640, 480, true);
				mapGrid.setRect(32, 32, 1216, 1216, false);
				player = new Player(this, 320, 240);
			}
			
			// Create an image based on the map's data and scale it accordingly.
			mapImage = new Image(mapGrid.data);
			mapImage.scale = 16;
			
			// Create a map entity to render and check collision with.
			map = new Entity(0, 0, mapImage, mapGrid);
			
		}
		
		private function loadLevel(mapData:Class):void
		{		
			//load xml data
			var mapXML:XML = FP.getXML(mapData);

			mapWidth = mapXML.@width;
			mapHeight = mapXML.@height;
			
			//create mapgrid
			mapGrid = new Grid(uint(mapXML.@width), uint(mapXML.@height), 4, 4, 0, 0);
			mapGrid.loadFromString(String(mapXML.Solids), "", "\n");
			
			//create tilemap
			tiles = new Tilemap(Assets.TILESET, uint(mapXML.@width), uint(mapXML.@height), Globals.TILE_SIZE, Globals.TILE_SIZE);
			tiles.loadFromString(mapXML.Tiles);
			addGraphic(tiles);
			
			
			//create a player at player start
			player = new Player(this, int(mapXML.Objects.Player.@x), int(mapXML.Objects.Player.@y));
			
			//read in obstacles
			obstaclesArray = new Array();
			for (var i:int = 0; i < mapXML.Objects.child("obstacle").length(); i++)
			{
				obstaclesArray.push(new Obstacle(int(mapXML.Objects.child("obstacle")[i].@x),int(mapXML.Objects.child("obstacle")[i].@y)));
			}
			
			//read in horizontal enemies
			enemyHArray = new Array();
			for (var j:int = 0; j < mapXML.Objects.child("enemyH").length(); j++)
			{
				enemyHArray.push(new EnemyH(int(mapXML.Objects.child("enemyH")[j].@x),int(mapXML.Objects.child("enemyH")[j].@y), this));
			}
			
			//read in vertical enemies
			enemyVArray = new Array();
			for (var k:int = 0; k < mapXML.Objects.child("enemyV").length(); k++)
			{
				enemyHArray.push(new EnemyV(int(mapXML.Objects.child("enemyV")[k].@x),int(mapXML.Objects.child("enemyV")[k].@y), this));
			}
			
			//read in finish line
			finish = new FinishLine(int(mapXML.Objects.finish.@x), int(mapXML.Objects.finish.@y));
			
		}
	}

}