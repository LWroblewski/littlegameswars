package com.littlegames.framework.entities.building
{
	import com.littlegames.framework.entities.unit.UnitType;
	
	/** Bâtiment permettant la production d'unités. */
	public class Factory extends BaseBuilding
	{
		/** Unités produites par le bâtiment. */
		protected var _productedUnits:Vector.<UnitType>;
    
    /** Constructeur */
		public function Factory(pName:String)
		{
			super(pName, 0);
		}
	}
}