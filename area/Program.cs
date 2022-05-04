using area_Lib;
using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;

namespace area
{ // Здравствуйте. 
  // Как раз хотел написать модульное расширяемое приложение, когда учился на курсах по .NET.
  // Прошу написать пожелания/ замечания, если они есть.
  // Юнит тестов в нашей программе не было, но я уже скачал платный курс и займусь им при первой возможности.


    // Напишите на C# библиотеку для поставки внешним клиентам, которая умеет вычислять площадь круга по радиусу и треугольника по трем сторонам.
    // Дополнительно к работоспособности оценим:
    // - Юнит-тесты
    // - Легкость добавления других фигур
         // Можно просто добавлять в прект библиотеки Figure_Lib?.dll с другими фигурами

    // - Вычисление площади фигуры без знания типа фигуры в compile-time
         // Реализован ввод данных фигуры через пробел. Сколько будет значений, такой тип и отработает для вычисления.

    // - Проверку на то, является ли треугольник прямоугольным
         // Проверка встроена. Интерфейс типа, производящего вычисление предусматривает вывод дополнительного комментария к вычислениям.
    class Program
    {
        static void Main(string[] args)
        {
            // получение всех типов всех сборок
            Assembly assembly = null;
            List<Type> typesList = new();
            string path = null;
            int maxLibNumber = 10;
            int libCount = 0;

            for (int i = 1; i <= maxLibNumber; i++)
            {
                path = "Figure_Lib" + i;
                try
                {
                    assembly = Assembly.Load(path);            // загрузка библиотеки
                    typesList.AddRange(assembly.GetTypes());   // добавление  в список всех типов всех сборок
                    libCount++;
                    Console.WriteLine($"Library {path} loaded successfully.");
                }
                catch (FileNotFoundException ex)
                {
                    //Console.WriteLine(ex.Message);
                    //Console.ReadKey();
                    //Environment.Exit(1);
                }
            }
            if (libCount == 0)
            {
                Console.WriteLine("Libraries are not found");
                Console.ReadKey();
                Environment.Exit(0);
            }


            // использование сборок для вычислений
            while (true)
            {
                Console.Write("Enter the parameter(s) of the figure separated by a space: ");
                string[] str = Console.ReadLine().Split(new char[] { ' ', '\n', '\t' }, StringSplitOptions.RemoveEmptyEntries);


                double[] parametersDouble = new double[str.Length];           // массив параметров для метода из сборки

                for (int i = 0; i < parametersDouble.Length; i++)
                {
                    parametersDouble[i] = Convert.ToDouble(str[i]);
                }

                object[] parameters = new object[1] { parametersDouble };      // этот массив для передачи в .Invoke

                
                object instance = null;
                int property = 0;
                PropertyInfo propertyInfo = null;
                MethodInfo method = null;
                AreaOutput areaOutput = null;
                int calcAreaCount = 0;

                foreach (Type type in typesList)
                {
                    if (type.GetInterface("IFigure") != null)                   // реализует ли тип библиотеки нужный интерфейс
                    {
                        instance = Activator.CreateInstance(type);              // получили экземпляр класса сборки
                        propertyInfo = type.GetProperty("ParamNumbers");        // получили инфо о свойстве класса
                        property = (int)propertyInfo.GetValue(instance);        // получили значение свойства экземпляра класса

                        if (property == parametersDouble.Length)                // если тип предназначен для приема данного кол-ва параметров фигуры
                        {
                            calcAreaCount++;
                            method = type.GetMethod("GetFigureArea");           // получили метод типа
                            areaOutput = (AreaOutput)method.Invoke(instance, parameters); // запуск метода экземпляра с входным параметром
                            Console.WriteLine($" {areaOutput.Message} Figure area:  {areaOutput.Area} ");
                        }
                    }
                }
                if (calcAreaCount == 0)
                {
                    Console.WriteLine($"There was not a method for calculating the area from {parametersDouble.Length} parameters.");
                }

                Console.WriteLine();
            }
        }
    }
}
