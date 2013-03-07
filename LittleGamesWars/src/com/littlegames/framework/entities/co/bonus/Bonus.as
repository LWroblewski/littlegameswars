package com.littlegames.framework.entities.co.bonus
{
	/** Bonus génériques accordés aux unités par les COs (de base ou via pouvoir). */
	public class Bonus
	{
		/** Bonus multiplicateur d'attaque des unités */
		protected var _offense:Number;
		
		/** Bonus multiplicateur de défense des unités */
		protected var _defense:Number;
		
		/** Pourcentage sur le coût de déploiement des unités */
		protected var _cost:Number;
		
		/** Rang minimum d'attaque des unités */
		protected var _rangeMin:int;
		
		/** Rang maximum d'attaque des unités */
		protected var _rangeMax:int;
		
		/** Bonus de mouvement */
		protected var _movement:int;
    
    /** Bonus de vitesse de capture des villes. */
    protected var _captureSpeed:Number;
		
		public function Bonus(pOffense:Number = 1, pDefense:Number = 1, pCost:Number = 1, pRangeMin:int = 0, pRangeMax:int = 0, pMovement:int = 0, pCaptureSpeed:Number = 1)
		{
			_offense = pOffense;
			_defense = pDefense;
			_cost = pCost;
			_rangeMin = pRangeMin;
			_rangeMax = pRangeMax;
			_movement = pMovement;
      _captureSpeed = pCaptureSpeed;
		}
	}
}