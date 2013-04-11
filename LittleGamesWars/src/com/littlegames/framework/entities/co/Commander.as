package com.littlegames.framework.entities.co
{
	import com.littlegames.framework.utils.HashMap;
	
	import flash.utils.Dictionary;

	/** Commandant. */
	public class Commander
	{
		/** Nom du CO. */
		protected var _name:String;
    
    public function get name():String
    {
      return _name;
    }
    
    /** Armée du CO */
    protected var _army:String;
		
		/** Dictionnaire d'objets Bonus, symbolisant les bonus du CO pour chaque type d'unité. */
		protected var _bonusUnits:HashMap;
		
		/** Pouvoir du co. */
		protected var _power:Power;
    
    public function get power():Power
    {
      return _power;
    }
		
		/** Nombre à atteindre pour pouvoir déclencher le pouvoir du co. */
		protected var _powerActivationLevel:uint;
    
    public function get powerActivationLevel():uint
    {
      return _powerActivationLevel;
    }
		
		/** Niveau actuel de la jauge de pouvoir. */
		public var powerCurrentLevel:uint;
		
		/** Indique si le pouvoir est en cours d'utilisation. */
		public var isPowerActive:Boolean;
    
    /** Liste d'images des portraits des COs */
    protected var _portraits:HashMap;
		
		public function Commander(pName:String, pPower:Power, pActivationLevel:uint)
		{
			_name = pName;
			_power = pPower;
			_powerActivationLevel = pActivationLevel;
			powerCurrentLevel = 0;
			
			_bonusUnits = getUnitsBonus();
      _portraits = initPortraits();
      
			isPowerActive = false;
		}
    
    /** Initialisation des portraits du co. */
    protected function initPortraits():HashMap
    {
      //To override
      return null;
    }
		
    /** Initialisation des bonus accodés aux unités du CO. */
		protected function getUnitsBonus():HashMap
		{
			//To override.
			return null;
		}
		
		public function getBonus(pUnit:String, pBonusType:String):uint
		{
			//TODO
			return 0;
		}
	}
}