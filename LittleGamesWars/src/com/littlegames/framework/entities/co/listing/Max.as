package com.littlegames.framework.entities.co.listing
{
  import com.littlegames.framework.entities.co.Commander;
  
  public class Max extends Commander
  {
    public function Max()
    {
      super("Max", new PowerMax(), 3);
    }
  }
}

import com.littlegames.framework.entities.co.Power;

class PowerMax extends Power
{
  public function PowerMax()
  {
    super("Puissance Max");
  }
}