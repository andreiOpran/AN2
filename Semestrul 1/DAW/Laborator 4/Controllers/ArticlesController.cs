using Laborator_4.Models;
using Microsoft.AspNetCore.Mvc;

namespace Laborator_4.Controllers
{
    public class ArticlesController : Controller
    {

        // [NonAction]
        public Article[] GetArticles()
        {
            // Se instantiaza un array de articole
            Article[] articles = new Article[3];
            // Se creeaza articolele
            for (int i = 0; i < 3; i++)
            {
                Article article = new Article();
                article.Id = i;
                article.Title = "Articol " + (i + 1).ToString();
                article.Content = "Continut articol " + (i + 1).ToString();
                article.Date = DateTime.Now;
                // Se adauga articolul in array
                articles[i] = article;
            }
            return articles;
        }

        // Afisarea tutoror articulelor
        // GttpGet - implicit
        [HttpGet]
        public IActionResult Index()
        {
            Article[] articles = GetArticles();        
            ViewBag.Articles = articles; // ViewBag.numeVariabila

            return View();

            // return RedirectToRoute("ArticlesShow", { } );
        }

        // Afisarea unui singur articol pe baza unui id
        [HttpGet]
        public IActionResult Show(int? id)
        {
            Article[] art = GetArticles();

            try
            {
                ViewBag.Article = art[(int)id];
                return View();
            }
            catch(Exception e)
            {
                ViewBag.ErrorMessage = e.Message; // pentru a memora mesajul de eroare
                return View("Error");
                //return StatusCode(StatusCodes.Status404NotFound);
            }
        }

        [HttpGet]
        public IActionResult New()
        {



            return View();
        }

        [HttpPost]
        public IActionResult New(Article article)
        {
            // codul de adaugare in baza de date
            return Content("Articolul a fost adaugat cu succes!");
        }

        public IActionResult Edit()
        {
            return View();
        }

        public IActionResult Delete()
        {
            return View();
        }
    }
}
