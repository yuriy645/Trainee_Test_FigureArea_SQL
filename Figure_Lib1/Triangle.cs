using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using area_Lib;

namespace Figure_Lib1
{
    public class Triangle : IFigure
    {
        public int ParamNumbers { get; } = 3;

        public AreaOutput GetFigureArea(double[] paramss)
        {
            var areaOutput = new AreaOutput(); 

            double halfPerimeter = (paramss[0] + paramss[1] + paramss[2]) / 2;
            double underSqrt = halfPerimeter * (halfPerimeter - paramss[0]) * (halfPerimeter - paramss[1]) * (halfPerimeter - paramss[2]);
            areaOutput.Area = Math.Sqrt(underSqrt);


            if (underSqrt < 0)
            {
                areaOutput.Message = "There are no triangles with such sides exists.";
            }
            else
            {
                //areaOutput.Area = Math.Sqrt(underSqrt);

                areaOutput.Message = "Triangle area calculated.";

                paramss = paramss.OrderBy(x => x).ToArray();

                if (paramss[2] * paramss[2] - paramss[1] * paramss[1] - paramss[0] * paramss[0] == 0)
                {
                    areaOutput.Message = areaOutput.Message + " Triangle is rectangular.";
                }
                else
                {
                    areaOutput.Message = areaOutput.Message + " Triangle is NOT rectangular.";
                }
            }
            

            return areaOutput;
        }
    }
}
