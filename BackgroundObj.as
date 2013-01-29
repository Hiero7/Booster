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
	public class BackgroundObj extends Entity 
	{
		private var backgroundTiles:Tilemap;
		public var mapWidth:Number = 0;
		public var mapHeight:Number = 0;
		
		public function BackgroundObj(mapData:Class) 
		{			
			type = "backgroundObj";
			layer = 4;
			if (mapData != null)
			{
				loadBackground(mapData);
			}
			
		}
		
		private function loadBackground(mapData:Class):void
		{		
			//load xml data
			var mapXML:XML = FP.getXML(mapData);

			mapWidth = mapXML.@width;
			mapHeight = mapXML.@height;
			
			//background
			backgroundTiles = new Tilemap(Assets.TILESET, uint(mapXML.@width), uint(mapXML.@height), Globals.TILE_SIZE, Globals.TILE_SIZE);
			backgroundTiles.loadFromString(mapXML.BackgroundObj);
			addGraphic(backgroundTiles);
		}
	}

}