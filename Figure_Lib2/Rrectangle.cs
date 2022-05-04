using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using area_Lib;

namespace Figure_Lib2
{
    public class Rectangle : IFigure
    {
        public int ParamNumbers { get; } = 2;

        public AreaOutput GetFigureArea(double[] paramss)
        {
            var areaOutput = new AreaOutput() { Area = paramss[0] * paramss[1], Message = "Rectangle area calculated." };

            return areaOutput;
        }
    }
}
