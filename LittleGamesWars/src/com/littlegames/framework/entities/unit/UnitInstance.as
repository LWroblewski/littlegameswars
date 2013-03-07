package com.littlegames.framework.entities.unit
{
	
	/** Occurence d'une unité. */
	public class UnitInstance
	{
    /** Max HPs d'une unité */
		public static const MAX_HP:uint = 10;
		
		/** Type de l'unité. */
		protected var _unit:Unit;
		
		/** Points de vie courants (10 au maximum). */
		protected var _hp:uint;
		
		/** Position x sur la map. */
		protected var _x:uint;
		
		/** Position y sur la map. */
		protected var _y:uint;
		
		public function UnitInstance(pUnit:Unit, pHp:uint = MAX_HP, pX:uint = 0, pY:uint = 0)
		{
      _unit = pUnit;
			_hp = pHp;
      _x = pX;
      _y = pY;
		}
	}
}