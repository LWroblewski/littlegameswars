package com.gamewars.enums
{
  public class Commanders
  {
    /** Noms des COs (clés primaires). */
    public static const ANDY:String = "Andy";
    public static const MAX:String = "Max";
    public static const SAMI:String = "Sami";
    
    /** Liste des COs. */
    private static var _list:Vector.<CommanderType>;
    
    public static function get list():Vector.<CommanderType>
    {
      if (!_list)
      {
        _list = new Vector.<CommanderType>;
        _list.push(new Andy());
        _list.push(new Max());
        _list.push(new Sami());
      }
      return _list;
    }
    
    /** Retourne un CO de nom pName. */
    public static function getByName(pName:String):CommanderType
    {
      for each (var co:CommanderType in list)
      {
        if (co.name == pName)
        {
          return co;
        }
      }
      return null;
    }
  }
}

import com.gamewars.enums.CommanderType;
import com.gamewars.enums.Commanders;

class Andy extends CommanderType
{
  public function Andy() 
  {
    super(Commanders.ANDY);
  }
}

class Max extends CommanderType
{
  public function Max() 
  {
    super(Commanders.MAX);
  }
}

class Sami extends CommanderType
{
  public function Sami() 
  {
    super(Commanders.SAMI);
  }
}