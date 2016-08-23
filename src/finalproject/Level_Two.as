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
	
	
	
	public class Level_Two extends Sprite
	{
		/**Screen**/
		public var screen: Sprite;
		
		/**Level**/
		private var levelTwoComplete: Boolean = false;
		private var floorOneComplete: Boolean = false;
		private var currentCheckPoint: int;
		private var two:BaseVector;
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
		
		public function Level_Two(screenParameter:Sprite)
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
			/**Two HUD**/
			two = new BaseVector(this, 0,0,shapes.twoLoop.slice(),70,1,1,0x101010);
			
			currentCheckPoint = 1;
			/**Movers**/
			movers = new Vector.<Particle>(1);			
			//Player
			movers[0] = new Player(this, new Point(0, 500), new GeometricVector(0,10), 1);
			
			//Platforms
			platformMovers = new Vector.<Mover>(1);
			
			platformMovers[0] = new MovingBaseVector(this, -800, 0 , shapes.rectangleLoop.slice(), 10, 1*drawSpeed,1,0x00ff00,1,1,1,0, 1*moveSpeed, 100, 1);

			
			/**Colliders**/
			//create collision list with player as target
			collisionList = new CollisionList(movers[0],
																								
											/**CHECKPOINTS**/
											//starting platform
											new CheckpointImmediateVector(this, 100, 0, shapes.rectangleLoop.slice(), 24, 1, 1,0x0000ff, 1, 4),
											//top of stairs
											new CheckpointImmediateVector(this, 900, -250, shapes.rectangleLoop.slice(), 24, 1, 1,0x0000ff, 1, 1),
											//after circles
											new CheckpointImmediateVector(this, 2000, -250, shapes.rectangleLoop.slice(), 24, 1, 1,0x0000ff, 1, 2),
											//after spikes
											new CheckpointImmediateVector(this, 2900, -450, shapes.rectangleLoop.slice(), 24, 1, 1,0x0000ff, 1, 1),
											//after puzzle and wall jump
											new CheckpointImmediateVector(this, 3950, -280, shapes.rectangleLoop.slice(), 24, 1, 1,0x0000ff, 1, 2),
											//after good and bad chain
											new CheckpointImmediateVector(this, 4800, -325, shapes.rectangleLoop.slice(), 24, 1, 1,0x0000ff, 1, 1),

											/**NORMAL PLATFORMS**/
											//when falling
											new BaseVector(this, -50, -600, shapes.rectangleLoop.slice(), 10, 1*drawSpeed,1,0x00ff00,1,1,1,90),
											new BaseVector(this, -50, -400, shapes.rectangleLoop.slice(), 10, 1*drawSpeed,1,0x00ff00,1,1,1,90),
											new BaseVector(this, -50, -200, shapes.rectangleLoop.slice(), 10, 1*drawSpeed,1,0x00ff00,1,1,1,90),
											new BaseVector(this, 50, -600, shapes.rectangleLoop.slice(), 10, 1*drawSpeed,1,0x00ff00,1,1,1,90),
											new BaseVector(this, 50, -400, shapes.rectangleLoop.slice(), 10, 1*drawSpeed,1,0x00ff00,1,1,1,90),
											new BaseVector(this, 50, -200, shapes.rectangleLoop.slice(), 10, 1*drawSpeed,1,0x00ff00,1,1,1,90),

											//stairs
											new NoLoopBaseVector(this,350,0,shapes.stairsStart.slice(),15,1*drawSpeed),
											new NoLoopBaseVector(this,500,-100,shapes.stairsStart.slice(),15,1*drawSpeed),
											new NoLoopBaseVector(this,650,-200,shapes.stairsStart.slice(),15,1*drawSpeed),

											//circles
											new BaseVector(this, 1200, 200, shapes.circleLoop.slice(), 25, 1*drawSpeed,1,0x00ff00,1,4,3,180),
											new BadBaseVector(this, 1500, 400, shapes.circleLoop.slice(), 25, 1*drawSpeed,1,0xff0000,1,6,3,180),
											new BaseVector(this, 1900, 450, shapes.circleLoop.slice(), 25, 1*drawSpeed,1,0x00ff00,1,4,5,180),

											//platform with spikes
											new BaseVector(this, 2300, -300, shapes.rectangleLoop.slice(), 10, 1*drawSpeed,1,0x00ff00,1,1,1,0),
											new BadBaseVector(this, 2350, -325, shapes.spikesBack.slice(), 15, 3*drawSpeed, 1, 0xff0000, 1, 1,1,0),
											new BaseVector(this, 2500, -350, shapes.rectangleLoop.slice(), 10, 1*drawSpeed,1,0x00ff00,1,1,1,0),
											new BadBaseVector(this, 2550, -375, shapes.spikesBack.slice(), 15, 3*drawSpeed, 1, 0xff0000, 1, 1,1,0),
											new BaseVector(this, 2700, -400, shapes.rectangleLoop.slice(), 10, 1*drawSpeed,1,0x00ff00,1,1,1,0),
											
											//spike wall where you have to just walk off the checkpoint
											new BadBaseVector(this, 3225, -800, shapes.spikesBack.slice(), 15, 3*drawSpeed, 1, 0xff0000, 1, 1,1,90),
											new BadBaseVector(this, 3225, -700, shapes.spikesReverseBack.slice(), 15, 3*drawSpeed, 1, 0xff0000, 1, 1,1,90),
											new BadBaseVector(this, 3225, -600, shapes.spikesBack.slice(), 15, 3*drawSpeed, 1, 0xff0000, 1, 1,1,90),
											new BadBaseVector(this, 3225, -500, shapes.spikesReverseBack.slice(), 15, 3*drawSpeed, 1, 0xff0000, 1, 1,1,90),
											new BadBaseVector(this, 3225, -400, shapes.spikesBack.slice(), 15, 3*drawSpeed, 1, 0xff0000, 1, 1,1,90),
											new BadBaseVector(this, 3225, -300, shapes.spikesReverseBack.slice(), 15, 3*drawSpeed, 1, 0xff0000, 1, 1,1,90),

											new BadBaseVector(this, 3275, -1000, shapes.spikesReverseBack.slice(), 15, 3*drawSpeed, 1, 0xff0000, 1, 1,1,90),
											new BadBaseVector(this, 3275, -800, shapes.spikesBack.slice(), 15, 3*drawSpeed, 1, 0xff0000, 1, 1,1,90),
											new BadBaseVector(this, 3275, -600, shapes.spikesReverseBack.slice(), 15, 3*drawSpeed, 1, 0xff0000, 1, 1,1,90),
											new BadBaseVector(this, 3275, -550, shapes.spikesBack.slice(), 15, 3*drawSpeed, 1, 0xff0000, 1, 1,1,90),
											new BadBaseVector(this, 3275, -400, shapes.spikesReverseBack.slice(), 15, 3*drawSpeed, 1, 0xff0000, 1, 1,1,90),
											new BadBaseVector(this, 3275, -300, shapes.spikesBack.slice(), 15, 3*drawSpeed, 1, 0xff0000, 1, 1,1,90),

											new BadBaseVector(this, 3325, -900, shapes.spikesReverseBack.slice(), 15, 3*drawSpeed, 1, 0xff0000, 1, 1,1,90),
											new BadBaseVector(this, 3325, -750, shapes.spikesBack.slice(), 15, 3*drawSpeed, 1, 0xff0000, 1, 1,1,90),
											new BadBaseVector(this, 3325, -600, shapes.spikesReverseBack.slice(), 15, 3*drawSpeed, 1, 0xff0000, 1, 1,1,90),
											new BadBaseVector(this, 3325, -450, shapes.spikesBack.slice(), 15, 3*drawSpeed, 1, 0xff0000, 1, 1,1,90),
											new BadBaseVector(this, 3325, -350, shapes.spikesReverseBack.slice(), 15, 3*drawSpeed, 1, 0xff0000, 1, 1,1,90),
											new BadBaseVector(this, 3325, -300, shapes.spikesBack.slice(), 15, 3*drawSpeed, 1, 0xff0000, 1, 1,1,90),

											new ImmediateBaseVector(this, 3300, 250, shapes.rectangleLoop.slice(), 24, 1*drawSpeed,1,0x00ff00,1,6,1,0),

											//stairs and wall jump
											new NoLoopBaseVector(this,3600,200,shapes.stairsStart.slice(),15,1*drawSpeed,2),
											new NoLoopBaseVector(this,3750,100,shapes.stairsStart.slice(),15,1*drawSpeed,2),
											new ImmediateBaseVector(this, 3900, -125, shapes.rectangleLoop.slice(), 24, 1*drawSpeed,1,0x00ff00,1,1,1,90),
											new ImmediateBaseVector(this, 3750, -225, shapes.rectangleLoop.slice(), 24, 1*drawSpeed,1,0x00ff00,1,1,1,90),

											//bad&good platforms
											new BaseVector(this, 4200, -300, shapes.rectangleLoop.slice(), 15, 1*drawSpeed, 1, 0x00ff00, 1, 1,1,0),
											new BadBaseVector(this, 4250, -300, shapes.rectangleReverseLoop.slice(), 10, 1*drawSpeed, 1, 0xff0000, 1, 1,1,0),

											new BaseVector(this, 4300, -300, shapes.rectangleLoop.slice(), 15, 1*drawSpeed, 1, 0x00ff00, 1, 1,1,0),
											new BadBaseVector(this, 4350, -300, shapes.rectangleReverseLoop.slice(), 10, 1*drawSpeed, 1, 0xff0000, 1, 1,1,0),

											new BaseVector(this, 4400, -300, shapes.rectangleLoop.slice(), 15, 1*drawSpeed, 1, 0x00ff00, 1, 1,1,0),
											new BadBaseVector(this, 4450, -300, shapes.rectangleReverseLoop.slice(), 10, 1*drawSpeed, 1, 0xff0000, 1, 1,1,0),

											new BaseVector(this, 4500, -300, shapes.rectangleLoop.slice(), 15, 1*drawSpeed, 1, 0x00ff00, 1, 1,1,0),
											new BadBaseVector(this, 4550, -300, shapes.rectangleReverseLoop.slice(), 10, 1*drawSpeed, 1, 0xff0000, 1, 1,1,0),

											new BaseVector(this, 4600, -300, shapes.rectangleLoop.slice(), 15, 1*drawSpeed, 1, 0x00ff00, 1, 1,1,0),

											//final stretch
											new BaseVector(this, 5300, 200, shapes.circleLoop.slice(), 20, 1*drawSpeed,1,0x00ff00,1,4,3,180),
											
											new BaseVector(this, 5800,-100, shapes.rectangleLoop.slice(), 15, 1*drawSpeed, 1, 0x00ff00, 1, 1,1,0),

											new NoLoopBaseVector(this,5900,-100,shapes.stairsStart.slice(),15,1*drawSpeed,2),
											new BaseVector(this, 6200,-300, shapes.rectangleLoop.slice(), 15, 1*drawSpeed, 1, 0x00ff00, 1, 1,1,0),

											new NoLoopBaseVector(this,6300,-300,shapes.stairsStart.slice(),15,1*drawSpeed,2),
											new BaseVector(this, 6600,-550, shapes.rectangleLoop.slice(), 15, 1*drawSpeed, 1, 0x00ff00, 1, 1,1,0),

											new NoLoopBaseVector(this,6700,-600,shapes.stairsStart.slice(),15,1*drawSpeed,2),
																					
											//Moving Platforms Section
											platformMovers[0],
											
											//goal
											new GoalNoLoopBaseVector(this, 7100, -500, shapes.spiralStart.slice(),75,2*drawSpeed, 3,0x101010, 1, 0.5,0.5),//goal
											
											/**BAD PLATFORMS**/
											/**Floor 1**/
											//initial border
											new BadImmediateVector(this, -1500, 1200, shapes.borderLine.slice(),1,1,1,0xff0000,1,8 )
																		
											
											);
			
			var jumpEndMessage: ENDJUMP = new ENDJUMP();
			jumpEndMessage.x = 7100;
			jumpEndMessage.y = -800;
			this.addChild(jumpEndMessage);
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
			
			two.x = -( stage.stageWidth/2 - (Player)(movers[0]).getX()) + 100;
			two.y = -(stage.stageHeight/2 + (Player)(movers[0]).getY()) + 100;
			
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
			if((Player)(movers[0]).location.y > 1200 && floorOneComplete == false)
			{
				collisionList.addItem(	new BadImmediateVector(this, -1500, -2000, shapes.borderLine.slice(),1,1,1,0xff0000,1,3 ) );//borderline 2
				floorOneComplete = true;
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
							
							if(levelTwoComplete == false)
							{
								var endLevel: End_Level = new End_Level(screen);

							}
							levelTwoComplete = true;
							
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
			
						if(collidedObjectName == "instance272")
						{
							currentCheckPoint = 1;
						}
						else if(collidedObjectName == "instance273")
						{
							currentCheckPoint = 2;
						}
						else if(collidedObjectName == "instance274")
						{
							currentCheckPoint = 3;
						}
						else if(collidedObjectName == "instance275")
						{
							currentCheckPoint = 4;
						}
						else if(collidedObjectName == "instance276")
						{
							currentCheckPoint = 5;
						}
						else if(collidedObjectName == "instance277")
						{
							currentCheckPoint = 6;
						}

					}
					
				}
			}
		}
		
		private function checkpointReset():void
		{
			if(currentCheckPoint == 1)
			{
				(Player)(movers[0]).reset(0, 10);
			}
			else if(currentCheckPoint == 2)
			{
				(Player)(movers[0]).reset( 900, 250);
			}
			else if(currentCheckPoint == 3)
			{
				(Player)(movers[0]).reset( 2000, 350);
			}
			else if(currentCheckPoint == 4)
			{
				(Player)(movers[0]).reset( 2900, 460);
			}
			else if(currentCheckPoint == 5)
			{
				(Player)(movers[0]).reset( 3950, 290);
			}
			else if(currentCheckPoint == 6)
			{
				(Player)(movers[0]).reset( 4800, 335);
			}

		}
	}//end class
}//end package