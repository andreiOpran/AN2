using Microsoft.AspNetCore.Mvc;

namespace Laborator_3.Controllers
{
    public class StudentController1 : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
