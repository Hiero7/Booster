package  
{
	/**
	 * ...
	 * @author Bijan
	 */
	public class Assets 
	{
		//title screen assets
		[Embed(source = "../assets/titleBKGND.png")] public static const TITLE_BKGND:Class;
		[Embed(source = "../assets/titleString.png")] public static const TITLE_TEXT:Class;
		[Embed(source = "../assets/titleStripe.png")] public static const TITLE_STRIPE:Class;
		[Embed(source = "../assets/titleFlash.png")] public static const TITLE_FLASH:Class;
		
		//level 1
		[Embed(source="level1.oel", mimeType="application/octet-stream")] public static const LEVEL_ONE:Class;
		
		//level 2
		[Embed(source = "level2.oel", mimeType = "application/octet-stream")] public static const LEVEL_TWO:Class;
		
		//level 3
		[Embed(source = "level3.oel", mimeType = "application/octet-stream")] public static const LEVEL_THREE:Class;
		
		//level 4
		[Embed(source = "level4.oel", mimeType = "application/octet-stream")] public static const LEVEL_FOUR:Class;
		
		//level 5
		[Embed(source="level5.oel", mimeType="application/octet-stream")] public static const LEVEL_FIVE:Class;
		
		//tileset
		[Embed(source = "../assets/tileset.png")] public static const TILESET:Class;
		
		//default stance
		[Embed(source = "../assets/Animations/Idle/boosterIdle_00000.png")] public static const DEFAULT:Class;
		
		//idle animation
		[Embed(source = "../assets/Animations/Idle/idle_composite.png")] public static const IDLE:Class;
		
		//boost animation
		[Embed(source = "../assets/Animations/boost/boost_composite.png")] public static const BOOST2:Class;
		[Embed(source="../assets/Animations/boost/boost_sheet.png")] public static const BOOST:Class;
		
		//full sprite sheet
		[Embed(source = "../assets/Animations/spriteSheet.png")] public static const SPRSHEET:Class;
		
		//boost charge
		[Embed(source = "../assets/Animations/charge Particles/charge_composite.png")] public static const CHGPARTSHEET:Class;
		
		//obstacle
		[Embed(source = "../assets/tempObs.png")] public static const OBSTACLE:Class;
		
		//horizontal enemy
		[Embed(source="../assets/Animations/EnemyHWalk/Hwalk_composite.png")] public static const ENEMYH:Class;
		
		//vertical enemy
		[Embed(source = "../assets/Animations/EnemyVJump/VJump_Composite.png")] public static const ENEMYV:Class;
		
		//enemy death sheet
		[Embed(source = "../assets/Animations/Death/enemyDeath_Composite.png")] public static const ENEMYDEATH:Class;
		
		//player death sheet
		[Embed(source = "../assets/Animations/Death/Pdeath_Composite.png")] public static const PLAYERDEATH:Class;
		
		//charging sound
		[Embed(source = "../assets/Sounds/s_gem.mp3")] public static const CHARGESFX:Class;
		
		//boost sound
		[Embed(source = "../assets/Sounds/dead.mp3")] public static const BOOSTSFX:Class;
		
		//jump sound
		[Embed(source = "../assets/Sounds/sfx_jump.mp3")] public static const JUMPSFX:Class;
		
		//sprint sound
		[Embed(source="../assets/Sounds/wind1.mp3")] public static const SPRINTSFX:Class;
		
		//enemy die sound
		[Embed(source = "../assets/Sounds/mutantdie.mp3")] public static const EDIESFX:Class;
		
		//damage sound
		[Embed(source = "../assets/Sounds/swhit.mp3")] public static const DAMAGESFX:Class;
		
		//player die sound
		[Embed(source="../assets/Sounds/door.mp3")] public static const PDIESFX:Class;
		
		//menu click
		[Embed(source="../assets/Sounds/MenuClick.mp3")] public static const CLICKSFX:Class;
		
		//start sound
		[Embed(source="../assets/Sounds/Rifleprimary2.mp3")] public static const STARTSFX:Class;
		
		//level bg music
		[Embed(source="../assets/Sounds/IntroLite.mp3")] public static const INTROMP3:Class;
		[Embed(source = "../assets/Sounds/GFreakLite.mp3")] public static const GFREAKMP3:Class;
		[Embed(source = "../assets/Sounds/DATDigestLite.mp3")] public static const DATMP3:Class;
		[Embed(source = "../assets/Sounds/GanbareLite.mp3")] public static const GANBAREMP3:Class;
		[Embed(source = "../assets/Sounds/BudangLite.mp3")] public static const BUDANGMP3:Class;
		[Embed(source = "../assets/Sounds/RiseLite.mp3")] public static const RISEMP3:Class;
		[Embed(source="../assets/Sounds/DeathtinyLite.mp3")] public static const DEATHTINYMP3:Class;
	}

}