using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using area_Lib;

namespace Figure_Lib1
{
    public class Circle : IFigure
    {
        public const double Pi = 3.1415926535897931;

        public int ParamNumbers { get; } = 1;

        public AreaOutput GetFigureArea(double[] paramss)
        {
            var areaOutput = new AreaOutput() { Area = Pi * paramss[0] * paramss[0], Message = "Circle area calculated." };

            return areaOutput;
        }
    }
}
