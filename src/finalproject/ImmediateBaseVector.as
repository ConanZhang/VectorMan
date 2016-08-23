package finalproject
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	
	public class ImmediateBaseVector extends BaseVector
	{
		public function ImmediateBaseVector(world:Sprite, xCoordinateParameter:Number, yCoordinateParameter:Number, pointsParameter:Vector.<Point>, numberOfLinesShownParameter:int, drawSpeedParameter:int=1, lineThicknessParameter:Number=1, lineColorParameter:Number=0x00ff00, lineAlphaParameter:Number=1, scalarXParameter:Number=1, scalarYParameter:Number=1,initialRotationParameter:Number =0, horizontalMoveSpeedParameter:Number=1, horizontalLimitParameter:Number=100, horizontalDirectionParameter:int=-1, verticalMoveSpeedParameter:Number=1, verticalLimitParameter:Number=100, verticalDirectionParameter:int=-1, speedOfRotationParameter:Number=0)
		{
			super(world, xCoordinateParameter, yCoordinateParameter, pointsParameter, numberOfLinesShownParameter, drawSpeedParameter, lineThicknessParameter, lineColorParameter, lineAlphaParameter, scalarXParameter, scalarYParameter,initialRotationParameter, horizontalMoveSpeedParameter, horizontalLimitParameter, horizontalDirectionParameter, verticalMoveSpeedParameter, verticalLimitParameter, verticalDirectionParameter, speedOfRotationParameter);
			
			var identifier:String = "ImmediateBaseVector";
		}
		
		public override function draw(event:TimerEvent):void
		{
			//clear all of drawing
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
				
				//Move to current point
				this.graphics.moveTo(points[i].x, points[i].y);
				//Draw to next point
				this.graphics.lineTo(points[i+1].x, points[i+1].y);
			}
			
			timer.stop();
		}
		
	}
}