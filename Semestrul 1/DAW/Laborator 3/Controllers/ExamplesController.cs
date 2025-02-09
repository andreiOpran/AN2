using Microsoft.AspNetCore.Mvc;

namespace Laborator_3.Controllers
{
    public class ExamplesController : Controller
    {
        public string Concatenare(string s1, string s2)
        {
            return s1 + " " + s2;
        }

        public string Produs(int param1, int? param2)
        {
            if(param2 is null)
            {
                return "Parametrul 2 nu este specificat";
            }
            else
                return (param1 * param2).ToString();
        }

        public string Operatie(int? a, int? b, string? op)
        {
            if(a is null)
                return "Parametrul a nu este specificat";
            if (b is null)
                return "Parametrul b nu este specificat";
            if (op is null)
                return "Operatia nu este specificata";

            switch (op)
            {
                case "+":
                    return (a + b).ToString();
                case "-":
                    return (a - b).ToString();
                case "*":
                    return (a * b).ToString();
                case "i":
                    if (b == 0)
                        return "Impartire la 0";
                    return (a / b).ToString();
                default:
                    return "Operatie invalida";
            }
        }
    }
}