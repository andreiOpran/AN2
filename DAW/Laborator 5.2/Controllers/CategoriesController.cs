using Laborator_5._2.Models;
using Microsoft.AspNetCore.Mvc;

namespace Laborator_5._2.Controllers
{
    public class CategoriesController : Controller
    {
        private readonly AppDbContext _db;

        public CategoriesController(AppDbContext context)
        {
            _db = context;
        }

        public IActionResult Index()
        {
            var categories = from category in _db.Categories
                             select category;

            ViewBag.Categories = categories;

            return View();
        }
    }
}
