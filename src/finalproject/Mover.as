/**
 * 
 * File:		Mover.as
 *
 * Author:		Georbec Ammon (u0552984@utah.edu) & Conan Zhang (conan.zhang@utah.edu)
 * Date: 		11-18-13
 * Partner:		Georbec Ammon / Conan Zhang
 * Course:		Computer Science 1410 - EAE
 *
 * Description:
 *
 *The Mover interface states all Movers must have a move(duration:Number), getX, and getY function.
 *  
 **/
package finalproject
{
	public interface Mover
	{
		function move(duration:Number):void;
		function getX():int;
		function getY():int;
	}
}