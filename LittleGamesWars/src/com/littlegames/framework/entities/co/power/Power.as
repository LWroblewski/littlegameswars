package com.littlegames.framework.entities.co.power
{
	import com.littlegames.framework.entities.co.bonus.Bonus;
	import com.littlegames.framework.entities.unit.UnitInstance;
	import com.littlegames.framework.entities.unit.UnitType;
	import com.littlegames.framework.entities.unit.Units;
	import com.littlegames.framework.utils.HashMap;

	/** Pouvoir de commandant. Composé de bonus de base (attaque/défense améliorées, etc...) et de traitements plus spécifiques. */
	public class Power
	{
		/** Nom du pouvoir. */
		protected var _name:String;
    
    public function get name():String
    {
      return _name;
    }
		
		/** Bonus accordés pendant le tour de déclenchement du pouvoir. */
		protected var _bonus:HashMap;
		
		public function Power(pName:String)
		{
			_name = pName;
			_bonus = getPowerBonus();
		}
    
    /** Fonction d'initialisation des bonus génériques du pouvoir. */
    protected function getPowerBonus():HashMap
    {
      //To override.
      //Par défaut, bonus de 10% sur la défense.
      var bonus:HashMap = new HashMap();
      bonus.put(Units.ALL, new Bonus(1, 1.1));
      return bonus;
    }
		
		/** Rendu graphique du pouvoir. */
		public function render():void
		{
			//To override.
		}
		
		/** Traitements logiques (hors bonus génériques) du pouvoir (ex: soin d'unités, dégats sur ennemis, etc...). */
		public function launch(pUnits:Vector.<UnitInstance> = null, pEnnemies:Vector.<UnitInstance> = null):void
		{
			//To override.
		}
	}
}