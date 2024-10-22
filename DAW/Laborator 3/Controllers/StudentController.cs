using Microsoft.AspNetCore.Mvc;

namespace Laborator_3.Controllers
{
    public class StudentController : Controller
    {
        public string Index()
        {
            return "Afisare lista studenti:s";
        }

        public string Show(int? id)
        {
            if(id is null)
            {
                return "Id-ul nu este specificat";
            }
            return "Afisare student cu id-ul " + id.ToString();
        }

        public string Create()
        {
            return "Creare student";
        }

        public string Edit(int? id)
        {
            if (id is null)
            {
                return "Id-ul nu este specificat";
            }
            return "Editare student cu id-ul " + id.ToString();
        }

        public string Delete(int? id)
        {
            if (id is null)
            {
                return "Id-ul nu este specificat";
            }
            return "Stergere student cu id-ul " + id.ToString();
        }
    }
}

/*
    https://localhost:7034/student/index
*/
