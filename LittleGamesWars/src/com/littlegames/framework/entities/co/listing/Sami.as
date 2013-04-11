package com.littlegames.framework.entities.co.listing
{
  import com.littlegames.framework.entities.co.Commander;
  
  public class Sami extends Commander
  {
    public function Sami()
    {
      super("Samy", new ForcedWalk(), 3);
    }
  }
}

import com.littlegames.framework.entities.co.Power;

class ForcedWalk extends Power
{
  public function ForcedWalk()
  {
    super("Marche Forcée");
  }
}