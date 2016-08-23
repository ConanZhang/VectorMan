/**
 * 
 * File:		Player.as
 *
 * Author:		Georbec Ammon (u0552984@utah.edu) & Conan Zhang (conan.zhang@utah.edu)
 * Date: 		11-25-13
 * Partner:		Georbec Ammon / Conan Zhang
 * Course:		Computer Science 1410 - EAE
 *
 * Description:
 *				Player class.
 *  
 **/
package finalproject
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Point;
	import flash.media.SoundChannel;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	
	public class Player extends Particle implements Mover, Collider
	{		
		/**Class Member Variables**/
		/*Movement*/
		//Horizontal
		protected var playerSpeed               : Number;//pixels able to move left or right by every frame
		
		protected var isMovingLeft              : Boolean;
		protected var isMovingRight             : Boolean;
		
		//Vertical
		protected var isJumping                 : Boolean;
		protected var decreaseUpwardsVelocity   : Boolean;
		
		/*Collisions*/
		protected var stabilizeTimer            : Timer;
		protected var colliding                 : Boolean;
		
		
		/**Finite State Variables**/
		
			/**Modes**/
		    protected var mode              : int;		
			protected const STANDING        : int = 0;
			protected const WALKING         : int = 1;
			protected const JUMPING         : int = 2;
		
			/**Timers**/
			protected var FSM_timer    : Timer;
 			 		
			/**Sprites**/
			protected var shapes            : VectorShapes;
			
			protected var playerHead        : BaseVector;
			protected var playerHeadInside  : BaseVector;
			
			protected var STANDING_1        : STANDING_Frame1;
			protected var STANDING_2        : STANDING_Frame2;
			
			protected var WALKING_1         :  WALKING_Frame1;
			protected var WALKING_2         :  WALKING_Frame2;
			protected var WALKING_3         :  WALKING_Frame3;
			protected var WALKING_4         :  WALKING_Frame4;
			protected var WALKING_5         :  WALKING_Frame5;
			
			protected var JUMPING_1         :  JUMPING_Frame1;
			protected var JUMPING_2         :  JUMPING_Frame2;
			protected var JUMPING_3         :  JUMPING_Frame3;
			
		/**End Finite State Variables**/
		
			
		//Owner
		private var world: Sprite;
		
		/**CONSTRUCTOR**/
		public function Player(worldP             : Sprite, 
							   locationParameter  : Point, 
							   velocityParameter  : GeometricVector, 
							   massParameter      : Number)
		{
			/**Pass variables into Particle super class for physics**/
			super( locationParameter, velocityParameter, massParameter);
			
			/**Assign Member Variables to Parameters**/
			world = worldP;
			
			//Add player to OWNER (simulator)
			world.addChild(this);
			
			/**Assigning Values to Class Member Variables**/
			/*Movement*/
			//Horizontal
			playerSpeed = 33;
			
			isMovingLeft = false;
			isMovingRight = false;
			
			//Vertical
			isJumping = false;
			decreaseUpwardsVelocity = false;
			colliding = true;
				
			/**Collisions**/
			stabilizeTimer = new Timer(250);
			stabilizeTimer.addEventListener(TimerEvent.TIMER, handleStabilizeTimer);
			
						
			/**-----FINITE STATE MACHINE START-----**/
				
				//-----CREATE-----//
				STANDING_1 = new STANDING_Frame1();
				STANDING_2 = new STANDING_Frame2();
				
				WALKING_1  = new WALKING_Frame1();
				WALKING_2  = new WALKING_Frame2();
				WALKING_3  = new WALKING_Frame3();
				WALKING_4  = new WALKING_Frame4();
				WALKING_5  = new WALKING_Frame5();
				
				JUMPING_1  = new JUMPING_Frame1();
				JUMPING_2  = new JUMPING_Frame2();
				JUMPING_3  = new JUMPING_Frame3();
				//-----END CREATE-----//
				
				
				//-----SCALE-----//
				STANDING_1.scaleX = 0.25;
				STANDING_1.scaleY = 0.25;
				STANDING_2.scaleX = 0.25;
				STANDING_2.scaleY = 0.25;
				
				WALKING_1.scaleX  = 0.25;
				WALKING_1.scaleY  = 0.25;
				WALKING_2.scaleX  = 0.25;
				WALKING_2.scaleY  = 0.25;
				WALKING_3.scaleX  = 0.25;
				WALKING_3.scaleY  = 0.25;
				WALKING_4.scaleX  = 0.25;
				WALKING_4.scaleY  = 0.25;
				WALKING_5.scaleX  = 0.25;
				WALKING_5.scaleY  = 0.25;
				
				JUMPING_1.scaleX  = 0.25;
				JUMPING_1.scaleY  = 0.25;
				JUMPING_2.scaleX  = 0.25;
				JUMPING_2.scaleY  = 0.25;
				JUMPING_3.scaleX  = 0.25;
				JUMPING_3.scaleY  = 0.25;
				//-----END SCALE-----//
				
				
				//-----STARTING LOCATION-----//
				var startingX: Number = 0;
				var startingY: Number = -50;
				
				STANDING_1.x = startingX;
				STANDING_1.y = startingY;			
				STANDING_2.x = startingX;
				STANDING_2.y = startingY;
				
				WALKING_1.x  = startingX;
				WALKING_1.y  = startingY;
				WALKING_2.x  = startingX;
				WALKING_2.y  = startingY;
				WALKING_3.x  = startingX;
				WALKING_3.y  = startingY;
				WALKING_4.x  = startingX;
				WALKING_4.y  = startingY;
				WALKING_5.x  = startingX;
				WALKING_5.y  = startingY;
				
				JUMPING_1.x  = startingX;
				JUMPING_1.y  = startingY;
				JUMPING_2.x  = startingX;
				JUMPING_2.y  = startingY;
				JUMPING_3.x  = startingX;
				JUMPING_3.y  = startingY;
				//-----END STARTING LOCATION-----//
				
				
				//-----INITIAL STATE-----//
				mode = STANDING;				
				this.addChild(STANDING_1);
				//-----END INITIAL STATE-----//
				
				
				//-----TIMER-----//
				FSM_timer = new Timer(150, 0);
				FSM_timer.addEventListener(TimerEvent.TIMER, FSM_handleTimer);
				FSM_timer.start();
				//-----END TIMER-----//
			
			/**--------END CONSTRUCTOR FSM--------**/
			
			/**Head**/
			shapes = new VectorShapes();
			playerHead = new BaseVector(this, 0, -78, shapes.headLoop.slice(), 10, 1, 8,0xffffff);
			playerHead.scaleX = 0.3;
			playerHead.scaleY = 0.3;
			playerHeadInside = new BaseVector(this, 0, -78, shapes.headReverseLoop.slice(), 10, 1, 20, 0xffffff);
			playerHeadInside.scaleX = 0.1;
			playerHeadInside.scaleY = 0.1;	
						
			/**Add Event Listeners**/
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
			
//			trace("width:  " + this.width);
//			trace("height:  " + this.height);

			
		}
		
		/**FUNCTION TO HANDLE FSM TIMER**/
		private function FSM_handleTimer(event:TimerEvent):void
		{
//			trace("FSM_handleTimer called.");
			
			//-----SET MODE-----//
//			trace("Velocity X == " + this.velocity.x);
//			trace("Velocity Y == " + this.velocity.y);
			if(  (this.velocity.x < 1 && this.velocity.x > -1)  &&  (this.velocity.y < 1 && this.velocity.y > -1)  )
			{
				mode = STANDING;
			}
			else if(isJumping == false && (this.velocity.x > 1 || this.velocity.x < -1) )
			{
				mode = WALKING;
			}
			else if(isJumping)
			{
				mode = JUMPING
			}
			//-----END SET MODE-----//
			
			
			//-----STANDING FSM ANIMATION-----//
			if (mode == STANDING)
			{		
				if (this.contains(STANDING_1) ||
					this.contains(WALKING_1)  ||
					this.contains(WALKING_2)  ||
					this.contains(WALKING_3)  ||
					this.contains(WALKING_4)  ||
					this.contains(WALKING_5)  ||
					this.contains(JUMPING_1)  ||
					this.contains(JUMPING_2)  ||
					this.contains(JUMPING_3) )
				{
//					trace("     Standing frame 1 called");
					
					if(this.contains(STANDING_1))
					{
						this.removeChild(STANDING_1);						
					}
					else if (this.contains(WALKING_1))
					{
						this.removeChild(WALKING_1);
					}
					else if (this.contains(WALKING_2))
					{
						this.removeChild(WALKING_2);
					}
					else if (this.contains(WALKING_3))
					{
						this.removeChild(WALKING_3);
					}
					else if (this.contains(WALKING_4))
					{
						this.removeChild(WALKING_4);
					}
					else if (this.contains(WALKING_5))
					{
						this.removeChild(WALKING_5);
					}
					else if (this.contains(JUMPING_1))
					{
						this.removeChild(JUMPING_1);
					}
					else if (this.contains(JUMPING_2))
					{
						this.removeChild(JUMPING_2);
					}
					else if (this.contains(JUMPING_3))
					{
						this.removeChild(JUMPING_3);
					}
					
					
					
					this.addChild(STANDING_2);
					
					this.removeChild(playerHead);
					this.addChild(playerHead);
					this.removeChild(playerHeadInside);
					this.addChild(playerHeadInside);
					
					return;
				}
				if (this.contains(STANDING_2))
				{
//					trace("     Standing frame 2 called");

					this.removeChild(STANDING_2);						
					this.addChild(STANDING_1);
					
					this.removeChild(playerHead);
					this.addChild(playerHead);
					this.removeChild(playerHeadInside);
					this.addChild(playerHeadInside);
					
					return;
				}				
			}
			//-----END STANDING FSM ANIMATION-----//

			
			//-----WALKING FSM ANIMATION-----//
			else if (mode == WALKING)
			{				
				if (this.contains(WALKING_1)  || 
					this.contains(STANDING_1) || 
					this.contains(STANDING_2) ||
					this.contains(JUMPING_1) ||
					this.contains(JUMPING_2) ||
					this.contains(JUMPING_3) )
				{
//					trace("     Walking frame 1 called");
					
					if(this.contains(WALKING_1))
					{
						this.removeChild(WALKING_1);
					}
					else if (this.contains(STANDING_1))
					{
						this.removeChild(STANDING_1);
					}
					else if (this.contains(STANDING_2))
					{
						this.removeChild(STANDING_2);
					}
					else if (this.contains(JUMPING_1))
					{
						this.removeChild(JUMPING_1);
					}
					else if (this.contains(JUMPING_2))
					{
						this.removeChild(JUMPING_2);
					}
					else if (this.contains(JUMPING_3))
					{
						this.removeChild(JUMPING_3);
					}
					
					this.addChild(WALKING_2);
					
					this.removeChild(playerHead);
					this.addChild(playerHead);
					this.removeChild(playerHeadInside);
					this.addChild(playerHeadInside);
					
					return;
				}
				if (this.contains(WALKING_2))
				{
//					trace("     Walking frame 2 called");

					this.removeChild(WALKING_2);						
					this.addChild(WALKING_3);
					
					this.removeChild(playerHead);
					this.addChild(playerHead);
					this.removeChild(playerHeadInside);
					this.addChild(playerHeadInside);
					
					return;
				}
				if (this.contains(WALKING_3))
				{
//					trace("     Walking frame 3 called");

					this.removeChild(WALKING_3);						
					this.addChild(WALKING_4);
					
					this.removeChild(playerHead);
					this.addChild(playerHead);
					this.removeChild(playerHeadInside);
					this.addChild(playerHeadInside);
					
					return;
				}
				if (this.contains(WALKING_4))
				{
//					trace("     Walking frame 4 called");

					this.removeChild(WALKING_4);						
					this.addChild(WALKING_5);
					
					this.removeChild(playerHead);
					this.addChild(playerHead);
					this.removeChild(playerHeadInside);
					this.addChild(playerHeadInside);
					
					return;
				}
				if (this.contains(WALKING_5))
				{
//					trace("     Walking frame 5 called");

					if(this.contains(WALKING_5))
					{
						this.removeChild(WALKING_5);
					}
					else if (this.contains(STANDING_1))
					{
						this.removeChild(STANDING_1);
					}
					else if (this.contains(STANDING_2))
					{
						this.removeChild(STANDING_2);
					}
					else if (this.contains(JUMPING_1))
					{
						this.removeChild(JUMPING_1);
					}
					else if (this.contains(JUMPING_2))
					{
						this.removeChild(JUMPING_2);
					}
					else if (this.contains(JUMPING_3))
					{
						this.removeChild(JUMPING_3);
					}
					
					this.addChild(WALKING_1);
					
					this.removeChild(playerHead);
					this.addChild(playerHead);
					this.removeChild(playerHeadInside);
					this.addChild(playerHeadInside);
					
					return;
				}	
			}
			//-----END WALKING FSM ANIMATION-----//
			
			
			//-----JUMPING FSM ANIMATION-----//
			else if(mode == JUMPING)
			{	
				if (this.contains(JUMPING_1)  ||
					this.contains(STANDING_1) ||
					this.contains(STANDING_2) ||
					this.contains(WALKING_1)  ||
					this.contains(WALKING_2)  ||
					this.contains(WALKING_3)  ||
					this.contains(WALKING_4)  ||
					this.contains(WALKING_5))
				{
//					trace("     Jumping frame 1 called");
					
					if(this.contains(JUMPING_1))
					{
						this.removeChild(JUMPING_1);						
					}
					else if (this.contains(STANDING_1))
					{
						this.removeChild(STANDING_1);						
					}
					else if (this.contains(STANDING_2))
					{
						this.removeChild(STANDING_2);
					}
					else if (this.contains(WALKING_1))
					{
						this.removeChild(WALKING_1);
					}
					else if (this.contains(WALKING_2))
					{
						this.removeChild(WALKING_2);
					}
					else if (this.contains(WALKING_3))
					{
						this.removeChild(WALKING_3);
					}
					else if (this.contains(WALKING_4))
					{
						this.removeChild(WALKING_4);
					}
					else if (this.contains(WALKING_5))
					{
						this.removeChild(WALKING_5);
					}
					
					this.addChild(JUMPING_2);
					
					this.removeChild(playerHead);
					this.addChild(playerHead);
					this.removeChild(playerHeadInside);
					this.addChild(playerHeadInside);
					
					return;
				}
				if (this.contains(JUMPING_2))
				{
//					trace("     Jumping frame 2 called");

					this.removeChild(JUMPING_2);						
					this.addChild(JUMPING_3);
					
					this.removeChild(playerHead);
					this.addChild(playerHead);
					this.removeChild(playerHeadInside);
					this.addChild(playerHeadInside);
					
					return;
				}
				if (this.contains(JUMPING_3))
				{
//					trace("     Jumping frame 3 called");

					this.removeChild(JUMPING_3);						
					this.addChild(JUMPING_2);
					
					this.removeChild(playerHead);
					this.addChild(playerHead);
					this.removeChild(playerHeadInside);
					this.addChild(playerHeadInside);
					
					return;
				}
			}
			//-----END JUMPING FSM ANIMATION-----//
		}
		
		protected function handleStabilizeTimer(event:TimerEvent):void
		{
			if (colliding == false)
			{
				colliding = true;
			}
		}
		
		/**MOVE FUNCTION FOR IMPLEMENTED INTERFACE MOVER**/
		public override function move(duration:Number):void
		{
			
			/**Lateral Movement**/
			if (isMovingLeft)
			{
				this.velocity.x = -playerSpeed; 
			}
			else if (isMovingRight)
			{
				this.velocity.x =  playerSpeed;
			}
			
			/**Vertical Movement**/
			if (decreaseUpwardsVelocity == true && this.velocity.y >= 10 && isJumping == true)
			{				
				this.velocity.y -= 20; 
			}
			
			/**Falling**/
			//Calculate Physics
			super.move(duration);
			
			//Update player location based on particle calculations
			this.update_gui();
		}
		
		/**COLLIDE FUNCTION FOR IMPLEMENTED INTERFACE COLLIDER**/
		public function collide(otherObject: Sprite):Boolean
		{
			return false;//CHANGE ME IF YOU EVER WANT THE PLAYER TO COLLIDE
		}
		
		/**GET NORMAL FUNCTION FOR IMPLEMENTED INTERFACE COLLIDER**/
		public function getNormal():GeometricVector
		{
			return new GeometricVector(-1,0);
		}
		
		/**FUNCTION TO HANDLE KEY DOWNS**/
		protected function handleKeyDown(event:KeyboardEvent):void
		{
			//user presses left arrow or A
			if (event.keyCode == Keyboard.LEFT || event.keyCode == Keyboard.A)
			{
				//Move left
				isMovingLeft = true;
				isMovingRight = false;
				
				//-----SCALE-----//
				STANDING_1.scaleX = -0.25;
				STANDING_2.scaleX = -0.25;
				
				WALKING_1.scaleX  = -0.25;
				WALKING_2.scaleX  = -0.25;
				WALKING_3.scaleX  = -0.25;
				WALKING_4.scaleX  = -0.25;
				WALKING_5.scaleX  = -0.25;
				
				JUMPING_1.scaleX  = -0.25;
				JUMPING_2.scaleX  = -0.25;
				JUMPING_3.scaleX  = -0.25;
				//-----END SCALE-----//
			}
				//user presses right arrow or D
			else if(event.keyCode == Keyboard.RIGHT || event.keyCode == Keyboard.D)
			{
				//Move right
				isMovingRight = true;
				isMovingLeft = false;
				
				//-----SCALE-----//
				STANDING_1.scaleX = 0.25;
				STANDING_2.scaleX = 0.25;
				
				WALKING_1.scaleX  = 0.25;
				WALKING_2.scaleX  = 0.25;
				WALKING_3.scaleX  = 0.25;
				WALKING_4.scaleX  = 0.25;
				WALKING_5.scaleX  = 0.25;
				
				JUMPING_1.scaleX  = 0.25;
				JUMPING_2.scaleX  = 0.25;
				JUMPING_3.scaleX  = 0.25;
				//-----END SCALE-----//
			}
				//user presses space,shift, up arrow, or W
			else if (event.keyCode == Keyboard.SPACE || event.keyCode == Keyboard.SHIFT || event.keyCode == Keyboard.UP || event.keyCode == Keyboard.W)
			{
				if( isJumping == false   )
				{
					//jump
					isJumping = true;					
					this.velocity.y = 70;
				}
			}
			else if (event.keyCode == Keyboard.DOWN || event.keyCode == Keyboard.S)
			{
				
					decreaseUpwardsVelocity = true;
				
			}
		}
		
		/**FUNCTION TO HANDLE KEY UPS**/
		protected function handleKeyUp(event:KeyboardEvent):void
		{
			//Don't move when are not pressed
			if (event.keyCode == Keyboard.LEFT || event.keyCode == Keyboard.A)
			{
				isMovingLeft = false;
				
			}
				//user presses right arrow or D
			else if(event.keyCode == Keyboard.RIGHT || event.keyCode == Keyboard.D)
			{
				isMovingRight = false;
			}
			else if (event.keyCode == Keyboard.DOWN || event.keyCode == Keyboard.S)
			{
				decreaseUpwardsVelocity = false;
			}
		}
		
		
		
		/**getX FUNCTION FOR IMPLEMENTED INTERFACE MOVER**/
		public function getX():int
		{
			/**TEST CODE**/
			//trace(this.location.x);
			
			return this.location.x;
		}
		
		/**getY FUNCTION FOR IMPLEMENTED INTERFACE MOVER**/
		public function getY():int
		{
			return this.location.y;
		}
		
		/**setY FUNCTION**/
		public function reset(xCoordinate: Number, yCoordinate:Number):void
		{
			mode == STANDING;
			
			this.location.x = xCoordinate;
			this.location.y = yCoordinate;
			
			this.velocity.y = 0;
			this.velocity.x = 0;

			
			update_gui();
		}
		
		/**FUNCTION TO UPDATE PLAYER LOCATION BY MATH DONE IN THE PARTICLE CLASS**/
		protected function update_gui() : void
		{
			//set x position to particle calculations for the next x position
			this.x = this.location.x;
			//set y position to particle calculations for the next y position
			this.y = -this.location.y;//MIRROR DUE TO Y INCREASING ↓
		}
		
		/**FUNCTION TO STABILIZE PLAYER**/
		public function stabilize(type:int) : void
		{
			//player hits top
			if(type == 1)
			{
				this.velocity.y = 0;
				//Decrease the horizontal velocity by some (friction)
				this.velocity.x = this.velocity.x * 0.5;
				
				this.location.y += 0.5;
			
				//Can jump again
				isJumping = false;
			}
			//player hits bottom
			else if(type == 2)
			{
				this.velocity.y = -this.velocity.y*0.5;
				this.velocity.x = this.velocity.x * 0.5;
				
				this.location.y -= 0.5;
			}
			//player hits left
			else if(type == 3)
			{	
				this.velocity.y = this.velocity.y*0.5;
				this.velocity.x = 0;
				
				this.location.x -= 15;
				
				//Can jump again
				isJumping = false;	
			}
			//player hits right
			else if(type == 4)
			{
				this.velocity.y = this.velocity.y*0.5;
				this.velocity.x = 0;
				
				this.location.x += 15;
				
				//Can jump again
				isJumping = false;
			}
			else if(type == 777)
			{
				this.velocity.y = -(this.velocity.y);
				this.velocity.x = -(this.velocity.x);
				
				//Can jump again
				isJumping = false;
			}
			
			
			
		}
		
	}//end class
}//end package