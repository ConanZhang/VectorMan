/**
 * 
 * File:		World.as
 *
 * Author:		Georbec Ammon (u0552984@utah.edu) & Conan Zhang (conan.zhang@utah.edu)
 * Date: 		11-25-13
 * Partner:		Georbec Ammon / Conan Zhang
 * Course:		Computer Science 1410 - EAE
 *
 * Description:
 *				Main game world handles simulation and levels.
 *  
 **/
package finalproject
{
	import VectorChildren.*;
	
	import cdk.CollisionList;
	
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.utils.Timer;

	
	
	
	public class End_Level extends Sprite
	{
		/**Screen**/
		public var screen: Sprite;
		
		/**Level**/
		private var levelEndComplete: Boolean = false;
		private var currentCheckPoint: int;
		
		/**Difficulty**/
		public var drawSpeed: Number = 1;
		public var moveSpeed: Number = 1;
		
		/**Vector Shapes**/
		private var shapes:VectorShapes;
		
		/**Mover/Collider Vectors**/
		private var movers:Vector.<Particle>;
		private var platformMovers:Vector.<Player>;
		
		private var borderLine: ImmediateNoStopBaseVector;
		
		/**Physics**/
		public const gravity : GeometricVector = new GeometricVector(0, -20);
		
		/**Words Sprite**/
		private var credits  : ENDCREDITS;
		private var randomizer: ColorTransform;
		private var colorTimer: Timer;

		
		public function End_Level(screenParameter:Sprite)
		{
			/**World**/
			//Assign Members to Parameters
			screen = screenParameter;
			
			//Add to screen
			screen.addChild(this);
			//Center
			this.x = stage.stageWidth/2;
			this.y = stage.stageHeight/2;			
			//Shapes class object
			shapes = new VectorShapes();
			
			
			/**Words Sprite**/
			credits = new ENDCREDITS();
			this.addChild(credits);
			credits.scaleX = .85;
			credits.scaleY = .85;
			credits.x = 0
			credits.y = -100;
			
			randomizer = new ColorTransform();
			
			colorTimer = new Timer(500, 300);
			colorTimer.addEventListener(TimerEvent.TIMER, createPlayers);
			colorTimer.start();
			
			/**Portal**/
			var spawner: NoLoopBaseVector = new NoLoopBaseVector(this,20,-65,shapes.spiralStart.slice(),50,4,3,0x101010);
			var spawner2: NoLoopBaseVector = new NoLoopBaseVector(this,20,-65,shapes.spiralStart.slice(),50,2,3,0x101010, 1, -1);

			
			/**Movers**/
			movers = new Vector.<Particle>(1);			
			//Player
			movers[0] = new Player(this, new Point(40, 0), new GeometricVector(0,10), 1);
			
			/**Colliders**/			
			borderLine = new ImmediateNoStopBaseVector(this, -2000, 300, shapes.borderLine.slice(), 1, 1, 10, 0x101010, 1, 5);
			
			/**Start Simulation**/
			start_simulation();
		}
		
		/**FUNCTION TO START SIMULATION BY UPDATING EVERYTHING ON GUI AND LOGICALLY**/
		public function start_simulation(  ) : void
		{
			this.addEventListener( Event.ENTER_FRAME, updateAll );
		}
		
		/**FUNCTION TO END SIMULATION BY STOP UPDATING EVERY EVERYTHING ON GUI AND LOGICALLY**/
		public function stop_simulation(  ) : void
		{
			this.removeEventListener( Event.ENTER_FRAME, updateAll );
		}
		
		private function createPlayers(e:TimerEvent):void
		{
			
			movers.push(
				new Player(   this,new Point(40,0),	new GeometricVector(   Math.floor(Math.random() * (50- (-50 + 1) ) ) + -50, Math.floor(Math.random() * (50- (-50 + 1) ) ) + -50   ),1     )
			);
		}
		
		
		/**FUNCTION TO UPDATE GUI AND LOGIC**/
		protected function updateAll(event:Event):void
		{	
			/**Words**/
			randomizer.color = Math.random() * 0xffffff;
			credits.transform.colorTransform = randomizer;
			for each(var player:Mover in movers)
			{
				randomizer.color = Math.random() * 0xffffff;
				(Sprite)(player).transform.colorTransform = randomizer;
			}
			
			/**Movers**/
			//Player
			for each (var moverElement: Particle in movers)
			{					
				moverElement.add_force( gravity );//apply a negative velocity to all velocities to simulate gravity
				moverElement.move( 0.1 );// tell movers to simulate 1/10 of a second of motion every frame to simulate movement
				moverElement.clear_forces();//clear forces every frame to determine new calculations
				movers[0]
				//A player and a player collide
				if ( GUI_Collision_Detection.isColliding( moverElement as Sprite,  borderLine as Sprite ) )
				{
					(Player)(moverElement).stabilize(777);//"stabilize" player
				}
			}
			
			
		}
		
		private function checkpointReset():void
		{
			if(currentCheckPoint == 1)
			{
				(Player)(movers[0]).reset(0, -100);
			}
			else if(currentCheckPoint == 2)
			{
				(Player)(movers[0]).reset( 200, -100);
			}
		}
	}//end class
}//end package