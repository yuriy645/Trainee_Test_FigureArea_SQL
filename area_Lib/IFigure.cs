using System;

namespace area_Lib
{
    public interface IFigure
    {
        public  int ParamNumbers { get; }               // кол-во параметров, при котором будет вызван тип
        
        public AreaOutput GetFigureArea(double[] paramss);         
    }
}
