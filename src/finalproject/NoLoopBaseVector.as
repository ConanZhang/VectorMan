package finalproject
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.events.TimerEvent;
	
	public class NoLoopBaseVector extends BaseVector
	{
		public function NoLoopBaseVector(world:Sprite, xCoordinateParameter:Number, yCoordinateParameter:Number, pointsParameter:Vector.<Point>, numberOfLinesShownParameter:int, drawSpeedParameter:int=1, lineThicknessParameter:Number=1, lineColorParameter:Number=0x00ff00, lineAlphaParameter:Number=1,scalarXParameter:Number = 1,scalarYParameter:Number = 1, initialRotationParameter:Number = 0,horizontalMoveSpeedParameter:Number=1, horizontalLimitParameter:Number=100, horizontalDirectionParameter:int=-1, verticalMoveSpeedParameter:Number=1, verticalLimitParameter:Number=100, verticalDirectionParameter:int=-1, speedOfRotationParameter:Number=0)
		{
			super(world, xCoordinateParameter, yCoordinateParameter, pointsParameter, numberOfLinesShownParameter, drawSpeedParameter, lineThicknessParameter, lineColorParameter, lineAlphaParameter,scalarXParameter,scalarYParameter,initialRotationParameter, horizontalMoveSpeedParameter, horizontalLimitParameter, horizontalDirectionParameter, verticalMoveSpeedParameter, verticalLimitParameter, verticalDirectionParameter, speedOfRotationParameter);
		}
		
		public override function draw(event:TimerEvent):void
		{
			//Clear all of sprite
			this.graphics.clear();
			
			//Drawing part of the shape up to variable limit
			for(var i:int = 0; i < numberOfLinesShown; i++)
			{
				/**Set Line Style**/
				//if color is same color as background
				if(lineColor != 0x101010)
				{
					
					this.graphics.lineStyle(lineThickness,lineColor,lineAlpha);
				}
				else
				{
					//randomize line
					this.graphics.lineStyle(lineThickness,Math.random()*0xffffff,lineAlpha);
				}
				
				//if next point is null
				if(points[i+1] == null)
				{
					//move two points down (to skip over null)
					this.graphics.moveTo(points[i+(numberOfLinesShown + 1) ].x, points[i+(numberOfLinesShown + 1)].y);
					
					//do extra shifts (to skip over null)
					for(var q:int = 0; q< (numberOfLinesShown+1); q++)
					{
						var extraShiftedPoint : Point = points.shift();
						points.push(extraShiftedPoint);
					}
					
					i+= (numberOfLinesShown+1);

					
				}
				else
				{
					//do normal stuff
					//Move to current point
					this.graphics.moveTo(points[i].x, points[i].y);
					//Draw to next point
					this.graphics.lineTo(points[i+1].x, points[i+1].y);
				}
			}
			
			for(var m:int = 0; m< drawSpeed; m++)
			{
				//Remove point from the front of the array...
				var shiftedPoint : Point = points.shift();
				
				//...and put it on the back
				points.push(shiftedPoint);
			}
		}
		
	}
}