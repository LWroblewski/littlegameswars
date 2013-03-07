package com.littlegames.framework.entities.unit.weapon
{
	import flash.utils.Dictionary;

	/**
	 * Type d'arme d'une unité.
	 */
	public class Weapon
	{
		public static const AMMO_UNLIMITED:uint = 99;
		
		/**
		 * Nom de l'arme.
		 */
		protected var _name:String;
		
		/**
		 * Nombre de munitions (99 = infini).
		 */
		protected var _ammo:uint;
		
		/**
		 * Type de l'arme (corps à corps ou à distance).
		 */
		protected var _type:String;
		
		/**
		 * Distance minimale d'utilisation.
		 */
		protected var _rangeMin:uint;
		
		/**
		 * Distance maximale d'utilisation.
		 */
		protected var _rangeMax:uint;
		
		/**
		 * Efficacité de l'arme par rapport à chaque unité.
		 */
		protected var _efficiency:Dictionary;
		
		public function Weapon(pName:String, pAmmo:uint = AMMO_UNLIMITED, pType:String = null, pRangeMin:uint = 1, prangeMax:uint = 1)
		{
			_name = pName;
			_ammo = pAmmo;
			_type = pType ? pType : WeaponType.DIRECT;
			_rangeMin = pRangeMin;
			_rangeMax = prangeMax;
			_efficiency = getEfficiencies();
		}
		
		protected function getEfficiencies():Dictionary
		{
			//To override.
			return null;
		}
	}
}