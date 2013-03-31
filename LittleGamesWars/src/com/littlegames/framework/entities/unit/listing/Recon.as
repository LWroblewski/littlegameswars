package com.littlegames.framework.entities.unit.listing
{
  import com.littlegames.framework.entities.unit.MovementType;
  import com.littlegames.framework.entities.unit.BaseUnit;
  import com.littlegames.framework.entities.unit.weapon.listing.MachineGun;

  public class Recon extends BaseUnit
  {
    public static const ID:String = "recon";
    
    public function Recon()
    {
      super("Recon", 4000, 400, 8, MovementType.TIRES, 5, 80, new MachineGun());
    }
  }
}