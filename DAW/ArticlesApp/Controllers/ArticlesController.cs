using ArticlesApp.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ArticlesApp.Controllers
{
    public class ArticlesController : Controller
    {

        private readonly ApplicationDbContext db; // readonly pt ca este o referinta
        public ArticlesController(ApplicationDbContext context)
        {
            db = context;
        }

        public IActionResult Index()
        {
            var articles = db.Articles.Include("Category"); // include face join cu tabelele asociate; lambda expression
            ViewBag.Articles = articles;

            return View();
        }
    }
}
