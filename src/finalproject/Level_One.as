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
	import flash.geom.Point;
	
	
	
	public class Level_One extends Sprite
	{
		/**Screen**/
		public var screen: Sprite;
		
		/**Level**/
		private var levelOneComplete: Boolean = false;
		private var floorOneComplete: Boolean = false;
		private var floorTwoComplete: Boolean = false;

		private var currentCheckPoint: int;
		private var one:BaseVector;

		/**Difficulty**/
		public var drawSpeed: Number = 1;
		public var moveSpeed: Number = 1;
		
		/**Vector Shapes**/
		private var shapes:VectorShapes;
		
		/**Mover/Collider Vectors**/
		private var movers:Vector.<Particle>;
		private var platformMovers:Vector.<Mover>;
		
		/**TEST COLLISION**/
		private var collisionList:CollisionList;
		
		/**Physics**/
		public const gravity : GeometricVector = new GeometricVector(0, -20);
		
		public function Level_One(screenParameter:Sprite)
		{
			/**World**/
			//Assign Members to Parameters
			screen = screenParameter;
			
			currentCheckPoint = 1;

			//Add to screen
			screen.addChild(this);
			//Center
			this.x = stage.stageWidth/2;
			this.y = stage.stageHeight/2;			
			//Shapes class object
			shapes = new VectorShapes();
			
			/**One HUD**/
			one = new BaseVector(this, 0,0,shapes.oneLoop.slice(),25,1,1,0x101010);


			/**Movers**/
			movers = new Vector.<Particle>(1);			
			//Player
			movers[0] = new Player(this, new Point(0,0), new GeometricVector(0,10), 1);
			
			//Platforms
			platformMovers = new Vector.<Mover>(1);
			
			platformMovers[0] = new MovingBaseVector(this, -5000, 0 , shapes.rectangleLoop.slice(), 10, 1*drawSpeed,1,0x00ff00,1,1,1,0, 1*moveSpeed, 100, 1);

			
			/**Colliders**/
			//create collision list with player as target
			collisionList = new CollisionList(movers[0],
				
											/**CHECKPOINTS**/
											/**Floor 1**/
											new CheckpointImmediateVector(this, -10, 10, shapes.rectangleLoop.slice(), 24, 1*drawSpeed, 1, 0x0000ff),//checkpoint 1
											new CheckpointImmediateVector(this, 1900, 10, shapes.rectangleLoop.slice(), 24, 1*drawSpeed, 1, 0x0000ff),//checkpoint 2
											
											/**Floor 2**/
											new CheckpointImmediateVector(this, 2700, -1200, shapes.rectangleLoop.slice(), 24, 1*drawSpeed, 1, 0x0000ff),//checkpoint 1
											new CheckpointImmediateVector(this, 1400, -1550, shapes.rectangleLoop.slice(), 24, 1*drawSpeed, 1, 0x0000ff),//checkpoint 2
											new CheckpointImmediateVector(this, 0, -1550, shapes.rectangleLoop.slice(), 24, 1*drawSpeed, 1, 0x0000ff),//checkpoint 3

											/**Floor 3**/
											new CheckpointImmediateVector(this, 0, -2450, shapes.rectangleLoop.slice(), 24, 1*drawSpeed, 1, 0x0000ff),//checkpoint 1
											new CheckpointImmediateVector(this, 600, -3300, shapes.rectangleLoop.slice(), 24, 1*drawSpeed, 1, 0x0000ff),//checkpoint 1
											new CheckpointImmediateVector(this, 2100, -3500, shapes.rectangleLoop.slice(), 24, 1*drawSpeed, 1, 0x0000ff),//checkpoint 1

											/**NORMAL PLATFORMS**/
											/**Floor 1**/
											//Beginning
											new ImmediateBaseVector(this, 300, 50, shapes.rectangleLoop.slice(), 24, 1, 1,0x00ff00, 1, 2),//first platform
											new BaseVector(this, 500, 50, shapes.stairsLoop.slice(),15,1*drawSpeed, 1, 0x00ff00,1, 1.5,1.5),//first stair loop
											
											//Platform Section 1
											new BaseVector(this, 900, -100, shapes.rectangleLoop.slice(), 10, 1*drawSpeed),//platform 1
											new BaseVector(this, 1100, 0, shapes.rectangleReverseLoop.slice(), 10, 1*drawSpeed),//platform 2
											new BaseVector(this, 1300, -100, shapes.rectangleLoop.slice(), 10, 1*drawSpeed),//platform 3
											new BaseVector(this, 1500, 0, shapes.rectangleReverseLoop.slice(), 10, 1*drawSpeed),//platform 4
											new BaseVector(this, 1700, -100, shapes.rectangleLoop.slice(), 10, 1*drawSpeed),//platform 5
											
											//Platform/Spike Section 1
											new BaseVector(this, 2100, -50, shapes.headLoop.slice(), 10, 1*drawSpeed),//platform 1
											new BaseVector(this, 2300, -50, shapes.headReverseLoop.slice(), 10, 1*drawSpeed),//platform 2
											new BaseVector(this, 2500, -50, shapes.headLoop.slice(), 10, 1*drawSpeed),//platform 3
											new BaseVector(this, 2700, -50, shapes.headLoop.slice(), 10, 1*drawSpeed),//platform 4

											//Wall Jump Section 1
											new ImmediateBaseVector(this, 2900, -200, shapes.rectangleLoop.slice(), 24, 1*drawSpeed,1,0x00ff00,1,1,1,90),//platform 1
											new ImmediateBaseVector(this, 2700, -350, shapes.rectangleReverseLoop.slice(), 24, 1*drawSpeed,1,0x00ff00,1,1,1,90),//platform 2
											new ImmediateBaseVector(this, 2900, -500, shapes.rectangleLoop.slice(), 24, 1*drawSpeed,1,0x00ff00,1,1,1,90),//platform 3
											new ImmediateBaseVector(this, 2700, -650, shapes.rectangleReverseLoop.slice(), 24, 1*drawSpeed,1,0x00ff00,1,1,1,90),//platform 4
											new ImmediateBaseVector(this, 2900, -800, shapes.rectangleLoop.slice(), 24, 1*drawSpeed,1,0x00ff00,1,1,1,90),//platform 5
											new ImmediateBaseVector(this, 2700, -950, shapes.rectangleLoop.slice(), 24, 1*drawSpeed,1,0x00ff00,1,1,1,90),//platform 6
											new ImmediateBaseVector(this, 2900, -1100, shapes.rectangleLoop.slice(), 24, 1*drawSpeed,1,0x00ff00,1,1,1,90),//platform 7

											/**Floor 2**/
											//Beginning
											new NoLoopBaseVector(this, 2600, -1275, shapes.stairsStart.slice(), 15, 1*drawSpeed,1,0x00ff00,1, -1.5,1.5),//stair 1
											new NoLoopBaseVector(this, 2400, -1425, shapes.stairsStart.slice(), 15, 1*drawSpeed,1,0x00ff00,1, -1.5,1.5),//stair 2
											
											//Good/Bad Platform Section
											new ImmediateBaseVector(this, 2000, -1700, shapes.rectangleReverseLoop.slice(), 24, 1*drawSpeed),//platform 1
											new ImmediateBaseVector(this, 1800, -1650, shapes.rectangleReverseLoop.slice(), 24, 1*drawSpeed),//platform 2
											new ImmediateBaseVector(this, 1600, -1750, shapes.rectangleLoop.slice(), 24, 1*drawSpeed),//platform 3
											
											//Good/Bad Stair Section
											new BaseVector(this, 1200, -1550, shapes.stairsLoop.slice(), 25, 1*drawSpeed,1, 0x00ff00, 1, -1.5, 1.5),//stair 1
											new BaseVector(this, 795, -1550, shapes.stairsReverseLoop.slice(), 25, 1*drawSpeed,1, 0x00ff00, 1, 1.5, 1.5),//stair 2
											new ImmediateBaseVector(this, 700, -1550, shapes.stairsBack.slice(), 50, 1*drawSpeed,1, 0x00ff00, 1, -1.5, 1.5),//stair 2
											new ImmediateBaseVector(this, 295, -1550, shapes.stairsBack.slice(), 50, 1*drawSpeed,1, 0x00ff00, 1, 1.5, 1.5),//stair 2

											//Wall Jump Section
											new BaseVector(this,-200, -1700, shapes.rectangleLoop.slice(), 15, 1*drawSpeed,1,0x00ff00,1,1,1,90),//platform 1
											new BaseVector(this, 0, -1825, shapes.rectangleReverseLoop.slice(), 15, 1*drawSpeed,1,0x00ff00,1,1,1,90),//platform 2
											new BaseVector(this, -200, -1950, shapes.rectangleLoop.slice(), 15, 1*drawSpeed,1,0x00ff00,1,1,1,90),//platform 3
											new BaseVector(this, 0, -2075, shapes.rectangleReverseLoop.slice(), 15, 1*drawSpeed,1,0x00ff00,1,1,1,90),//platform 4
											new BaseVector(this, -200, -2200, shapes.rectangleLoop.slice(), 15, 1*drawSpeed,1,0x00ff00,1,1,1,90),//platform 5
											new ImmediateBaseVector(this, 0, -2325, shapes.rectangleLoop.slice(), 24, 1*drawSpeed,1,0x00ff00,1,1,1,90),//platform 6
											new ImmediateBaseVector(this, -200, -2450, shapes.rectangleLoop.slice(), 24, 1*drawSpeed,1,0x00ff00,1,1,1,90),//platform 7

											/**Floor 3**/
											//Good/Bad Stair Up
											new ImmediateBaseVector(this, 200, -2450, shapes.stairsBack.slice(), 50, 1*drawSpeed,1, 0x00ff00, 1, 1.5, 1.5),//stair 1
											new ImmediateBaseVector(this, 250, -2725, shapes.stairsBack.slice(), 50, 1*drawSpeed,1, 0x00ff00, 1, -1.5, 1.5),//stair 2
											new ImmediateBaseVector(this, 200, -2975, shapes.stairsBack.slice(), 50, 1*drawSpeed,1, 0x00ff00, 1, 1.5, 1.5),//stair 2

											//Huge Platform Section
											new ImmediateBaseVector(this, 1100, -3300, shapes.rectangleLoop.slice(),24, 1*drawSpeed,1, 0x00ff00, 1, 5, 5),//platform 1
											new ImmediateBaseVector(this, 1700, -3350, shapes.rectangleLoop.slice(),24, 1*drawSpeed,1, 0x00ff00, 1, 5, 5),//platform 2

											//Circles and Platforms
											new ImmediateBaseVector(this, 2350, -3600, shapes.rectangleLoop.slice(),24, 1*drawSpeed,1, 0x00ff00, 1, 1, 1),//platform 1
											new ImmediateBaseVector(this, 2600, -3700, shapes.rectangleLoop.slice(),24, 1*drawSpeed,1, 0x00ff00, 1, 1, 1),//platform 2
											
											//End
											new BaseVector(this, 2800, -3700, shapes.stairsBack.slice(),60, 1*drawSpeed,1, 0x101010, 1, 1.5, 1.5),//stairs 1
											new BaseVector(this, 3205, -3700, shapes.stairsBack.slice(),60, 1*drawSpeed,1, 0x101010, 1, -1.5, 1.5),//stairs 2


											/**GOAL**/
											new GoalNoLoopBaseVector(this, 3000, -3800, shapes.spiralStart.slice(),75,2*drawSpeed, 3,0x101010, 1, 0.5,0.5),//goal
											
											/**BAD PLATFORMS**/
											/**Floor 1**/
											//initial border
											new BadImmediateVector(this, -1500, 400, shapes.borderLine.slice(),1,1,1,0xff0000,1,3 ),//borderline 1
											
											//Platform/Spike Section 1
											new BadBaseVector(this, 2200, -200, shapes.spikesBack.slice(), 15, 2*drawSpeed, 1, 0xff0000, 1, 0.6,0.6,90),//spike 1
											new BadBaseVector(this, 2400, -200, shapes.spikesReverseBack.slice(), 15, 2*drawSpeed, 1, 0xff0000, 1, 0.6,0.6,90),//spike 2
											new BadBaseVector(this, 2600, -200, shapes.spikesBack.slice(), 15, 2*drawSpeed, 1, 0xff0000, 1, 0.6,0.6,90),//spike 3

											/**Floor 2**/
											//Good/Bad Platform Section
											new BadBaseVector(this, 2000, -1700, shapes.rectangleLoop.slice(), 11, 1*drawSpeed,1,0xff0000),//bad platform 1
											new BadBaseVector(this, 1800, -1650, shapes.rectangleLoop.slice(), 11, 1*drawSpeed,1,0xff0000),//bad platform 2
											new BadBaseVector(this, 1600, -1750, shapes.rectangleReverseLoop.slice(), 11, 1*drawSpeed,1,0xff0000),//bad platform 3
											
											//Good/Bad Stair Section
											new BadBaseVector(this, 1200, -1550, shapes.stairsReverseLoop.slice(), 10, 1*drawSpeed,1, 0xff0000, 1, -1.5, 1.5),//bad stair 1
											new BadBaseVector(this, 795, -1550, shapes.stairsLoop.slice(), 10, 1*drawSpeed,1, 0xff0000, 1, 1.5, 1.5),//bad stair 2
											new BadBaseVector(this, 700, -1550, shapes.stairsBack.slice(), 15, 2*drawSpeed,1, 0xff0000, 1, -1.5, 1.5),//bad stair 3
											new BadBaseVector(this, 295, -1550, shapes.stairsReverseBack.slice(), 15, 2*drawSpeed,1, 0xff0000, 1, 1.5, 1.5),//bad stair 4

											//Wall Jump Section
											new BadBaseVector(this, 0, -2325, shapes.rectangleLoop.slice(), 10, 1*drawSpeed,1,0xff0000,1,1,1,90),//bad platform 6
											new BadBaseVector(this, -200, -2450, shapes.rectangleLoop.slice(), 10, 1*drawSpeed,1,0xff0000,1,1,1,90),//bad platform 6

											/**Floor 3**/
											//Good/Bad Stair Up
											new BadNoLoopBaseVector(this, 200, -2450, shapes.stairsStart.slice(), 15, 3*drawSpeed,1, 0xff0000, 1, 1.5, 1.5),//bad stair 1
											new BadNoLoopBaseVector(this, 250, -2725, shapes.stairsStart.slice(), 15, 2*drawSpeed,1, 0xff0000, 1, -1.5, 1.5),//bad stair 2
											new BadNoLoopBaseVector(this, 200, -2975, shapes.stairsStart.slice(), 15, 3*drawSpeed,1, 0xff0000, 1, 1.5, 1.5),//bad stair 3

											//Huge Platform Sections
											new BadBaseVector(this, 1100, -3300, shapes.rectangleLoop.slice(),2, 1*drawSpeed,2, 0xff0000, 1, 5, 5),//platform 1
											new BadBaseVector(this, 1700, -3350, shapes.rectangleLoop.slice(),2, 2*drawSpeed,2, 0xff0000, 1, 5, 5),//platform 2
											new BadBaseVector(this, 1700, -3350, shapes.rectangleReverseLoop.slice(),2, 2*drawSpeed,2, 0xff0000, 1, 5, 5),//platform 2

											//Circles and Platforms
											new BadBaseVector(this, 2350, -3600, shapes.smallCircleLoop.slice(),10, 1*drawSpeed,1, 0xff0000, 1, 0.75, 0.75),//circle 1
											new BadBaseVector(this, 2600, -3700, shapes.smallCircleReverseLoop.slice(),10, 1*drawSpeed,1, 0xff0000, 1, 0.75, 0.75)//circle 2


											);
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
		
		/**FUNCTION TO UPDATE GUI AND LOGIC**/
		protected function updateAll(event:Event):void
		{		
			
			/**Screen Follows Player**/
			this.x = stage.stageWidth/2 - (Player)(movers[0]).getX();
			this.y = stage.stageHeight/2 + (Player)(movers[0]).getY();
			
			one.x = -( stage.stageWidth/2 - (Player)(movers[0]).getX()) + 100;
			one.y = -(stage.stageHeight/2 + (Player)(movers[0]).getY()) + 100;

			/**Movers**/
			//Player
			for each (var moverElement: Particle in movers)
			{					
				moverElement.add_force( gravity );//apply a negative velocity to all velocities to simulate gravity
				moverElement.move( 0.1 );// tell movers to simulate 1/10 of a second of motion every frame to simulate movement
				moverElement.clear_forces();//clear forces every frame to determine new calculations
			}
			
			//Platforms
			for each (var platformMoverElement: Mover in platformMovers)
			{					
				platformMoverElement.move(777);//DURATION SHOULD DO NOTHING (PARAMETER)
			}
			
			/**BORDERLINE**/
			if((Player)(movers[0]).location.y > 1200 && (Player)(movers[0]).location.y < 2500 && floorOneComplete == false)
			{
				collisionList.addItem(	new BadImmediateVector(this, -1500, -1175, shapes.borderLine.slice(),1,1,1,0xff0000,1,3 ) );//borderline 2
				
				floorOneComplete = true;
			}
			else if((Player)(movers[0]).location.y > 2500 && floorTwoComplete == false)
			{
				collisionList.addItem(	new BadImmediateVector(this, -1500, -2385, shapes.borderLine.slice(),1,1,1,0xff0000,1,3 ) );//borderline 2
				
				floorTwoComplete = true;
			}
			
			/**COLLISIONS CHECK**/
			//check for collisions
			var collisions:Array = collisionList.checkCollisions();
			
			//handle collisions
			for(var i:int = 0; i < collisions.length; i++)
			{
				//first collision returned should always be player
				var collision:Object = collisions[0];
				
				collisionList.returnAngleType = "DEG";//angle is in degrees
				
				//information of collision
				var angle:Number = collision.angle;
				var overlap:int = collision.overlapping.length;
				
//				trace(angle);
//				trace(overlap);
				var collidedObject: String = collisions[i].object2;
				var collidedObjectName: String = collisions[i].object2.name;

				trace(collidedObjectName);
				
				if(overlap > 0)
				{
					//player on top
					if(angle > 75 && angle < 110)
					{
						(Player)(movers[0]).stabilize(1);//stabilize player
					}
					//player on bottom
					if(angle > -110 && angle < -79)
					{
						(Player)(movers[0]).stabilize(2);//stabilize player
					}
					//player hits left side
					if(angle < 75 && angle > -75)
					{
						(Player)(movers[0]).stabilize(3);//stabilize player

					}
					//player hits right side
					if(angle < 180 && angle > 110 || angle > -180 && angle < -110)
					{
						(Player)(movers[0]).stabilize(4);//stabilize player
						
					}
					
					//Bad collision
					if(collidedObject == "[object BadNoLoopBaseVector]" || collidedObject == "[object BadImmediateVector]" || collidedObject == "[object BadBaseVector]")
					{
						checkpointReset();
					}
					//Goal collision
					else if(collidedObject == "[object GoalNoLoopBaseVector]")
					{
						while(numChildren > 0)
						{
							//Remove everything graphically
							removeChildAt(0);
							
							movers = null;
							platformMovers = null;
							collisionList = null;
							
							if(levelOneComplete == false)
							{
								var levelTwo: Level_Two = new Level_Two(screen);
							}
							levelOneComplete = true;
							
							stop_simulation();
						}
					}
					//Moving collision
					else if(collidedObject == "[object MovingImmediateVector]")
					{
						//doesn't work
//						if((BaseVector)(platformMovers[0]).isMovingLeft)
//						{
//							trace("moving left");
//							(Player)(movers[0]).location.x -= (BaseVector)(platformMovers[0]).horizontalMoveSpeed*3;
//						}
//						else if((BaseVector)(platformMovers[0]).isMovingRight)
//						{
//							trace("moving right");
//							(Player)(movers[0]).location.x += (BaseVector)(platformMovers[0]).horizontalMoveSpeed*3;
//						}
//						else if((BaseVector)(platformMovers[1]).isMovingUp)
//						{
//							
//							(Player)(movers[0]).location.y += (BaseVector)(platformMovers[1]).verticalMoveSpeed*1000;
//						}
//						else if((BaseVector)(platformMovers[1]).isMovingDown)
//						{
//							(Player)(movers[0]).location.y -= (BaseVector)(platformMovers[1]).verticalMoveSpeed*1000;
//						}
					}
					//Checkpoint collision
					else if(collidedObject == "[object CheckpointImmediateVector]")
					{
						collidedObject = collisions[i].object2.name;
						
						if(collidedObject == "instance171")
						{
							//Checkpoint 1
							currentCheckPoint = 1;
						}
						else if(collidedObject == "instance172")
						{
							//Checkpoint 2
							currentCheckPoint = 2;
						}
						else if(collidedObject == "instance173")
						{
							//Checkpoint 3
							currentCheckPoint = 3;
						}
						else if(collidedObject == "instance174")
						{
							//Checkpoint 4
							currentCheckPoint = 4;
						}
						else if(collidedObject == "instance175")
						{
							//Checkpoint 5
							currentCheckPoint = 5;
						}
						else if(collidedObject == "instance176")
						{
							//Checkpoint 6
							currentCheckPoint = 6;
						}
						else if(collidedObject == "instance177")
						{
							//Checkpoint 7
							currentCheckPoint = 7;
						}
						else if(collidedObject == "instance178")
						{
							//Checkpoint 8
							currentCheckPoint = 8;
						}
					}
					
				}
			}
		}
		
		private function checkpointReset():void
		{
			if(currentCheckPoint == 1)
			{
				(Player)(movers[0]).reset(0, 0);
			}
			else if(currentCheckPoint == 2)
			{
				(Player)(movers[0]).reset( 1900, 0);
			}
			else if(currentCheckPoint == 3)
			{
				(Player)(movers[0]).reset( 2700, 1200);
			}
			else if(currentCheckPoint == 4)
			{
				(Player)(movers[0]).reset( 1400, 1550);
			}
			else if(currentCheckPoint == 5)
			{
				(Player)(movers[0]).reset( 0, 1550);
			}
			else if(currentCheckPoint == 6)
			{
				(Player)(movers[0]).reset( 0, 2450);
			}
			else if(currentCheckPoint == 7)
			{
				(Player)(movers[0]).reset( 600, 3350);
			}
			else if(currentCheckPoint == 8)
			{
				(Player)(movers[0]).reset( 2100, 3550);
			}
		}
	}//end class
}//end package