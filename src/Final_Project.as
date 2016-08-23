/**
 * 
 * File:		Final_Project.as
 *
 * Author:		Georbec Ammon (u0552984@utah.edu) & Conan Zhang (conan.zhang@utah.edu)
 * Date: 		11-25-13
 * Partner:		Georbec Ammon / Conan Zhang
 * Course:		Computer Science 1410 - EAE
 *
 * Description:
 *				Main base-level class which creates world and edits SWF settings.
 *  
 **/
package
{
	import finalproject.*;
	
	import flash.display.Sprite;
	
	/**CHANGE BACKGROUND COLOR, STAGE SIZE, AND FRAME RATE**/
	[SWF(backgroundColor="#101010", width="800", height="800", frameRate="50")]
	
	public class Final_Project extends Sprite
	{
		private var introLevel : Intro_Level;
		
		public function Final_Project()
		{
			introLevel = new Intro_Level(this);
		}
	}
}